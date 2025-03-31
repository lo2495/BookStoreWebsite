package hkmu.comps380f.dao;

import hkmu.comps380f.exception.NotEnoughBooksInStockException;
import hkmu.comps380f.model.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;


@Service
@Scope(value = WebApplicationContext.SCOPE_SESSION, proxyMode = ScopedProxyMode.TARGET_CLASS)
public class ShoppingCartServiceImpl implements ShoppingCartService {

    private final BookRepository bookRepository;

    private Map<Book, Integer> books = new HashMap<>();

    @Autowired
    public ShoppingCartServiceImpl(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    @Override
    public void addProductBook(Book book) {
        if (books.containsKey(book)) {
            books.replace(book, books.get(book) + 1);
        } else {
            books.put(book, 1);
        }
    }
    @Override
    public void removeProductBook(Book book) {
        if (books.containsKey(book)) {
            books.remove(book);
        }
    }
    @Override
    public void updateProductQuantity(Book book, int quantity) {
        if (books.containsKey(book) && quantity >= 1) {
            books.put(book, quantity);
        }
    }

    @Override
    public Map<Book, Integer> getBooksInCart() {
        return Collections.unmodifiableMap(books);
    }

    @Override
    @Transactional
    public void checkout() throws NotEnoughBooksInStockException {
        Set<Long> bookIds = books.keySet().stream()
                .map(Book::getBook_id)
                .collect(Collectors.toSet());

        List<Book> fetchedBooks = bookRepository.findAllById(bookIds);

        for (Map.Entry<Book, Integer> entry : books.entrySet()) {
            Book book = fetchedBooks.stream()
                    .filter(b -> b.getBook_id().equals(entry.getKey().getBook_id()))
                    .findFirst()
                    .orElseThrow(() -> new NotEnoughBooksInStockException(entry.getKey()));

            if (book.getQuantity() < entry.getValue()) {
                throw new NotEnoughBooksInStockException(book);
            }

            book.setQuantity(book.getQuantity() - entry.getValue());
        }

        bookRepository.saveAll(fetchedBooks);
        bookRepository.flush();
        books.clear();
    }

    @Override
    public BigDecimal getTotal() {
        return books.entrySet().stream()
                .map(entry -> entry.getKey().getPrice().multiply(BigDecimal.valueOf(entry.getValue())))
                .reduce(BigDecimal::add)
                .orElse(BigDecimal.ZERO);
    }
}