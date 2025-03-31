package hkmu.comps380f.dao;

import hkmu.comps380f.exception.NotEnoughBooksInStockException;
import hkmu.comps380f.model.Book;

import java.math.BigDecimal;
import java.util.Map;

public interface ShoppingCartService {
    void addProductBook(Book book);

    void removeProductBook(Book book);

    Map<Book, Integer> getBooksInCart();

    void checkout() throws NotEnoughBooksInStockException;

    BigDecimal getTotal();
    void updateProductQuantity(Book book, int quantity);
}
