package hkmu.comps380f.dao;

import hkmu.comps380f.exception.BookNotFound;
import hkmu.comps380f.model.Book;
import hkmu.comps380f.model.CoverPhoto;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.swing.plaf.basic.BasicIconFactory;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

@Service
public class BookService {
    private final BookRepository bookRepository;
    @Resource
    private BookRepository bRepo;

    @Autowired
    public BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }
    @Transactional
    public List<Book> getAllBooks() {
        return bRepo.findAll();
    }
    public Page<Book> getBooks(Pageable pageable) {
        return bookRepository.findAll(pageable);
    }

    @Transactional
    public Book getBook(Long id)
            throws BookNotFound {
        Book book = bRepo.findById(id).orElse(null);
        if (book == null) {
            throw new BookNotFound(id);
        }
        return book;
    }
    @Transactional
    public Long createBook(String bookname, String author, BigDecimal price, String description, boolean availability, List<MultipartFile>coverphoto, int quantity)
        throws IOException{
        Book book = new Book();
        book.setBookname(bookname);
        book.setAuthor(author);
        book.setPrice(price);
        book.setDescription(description);
        book.setAvailability(availability);
        for (MultipartFile filePart:coverphoto){
            CoverPhoto coverPhoto = new CoverPhoto();
            coverPhoto.setName(filePart.getOriginalFilename());
            coverPhoto.setMimecontentType(filePart.getContentType());
            coverPhoto.setContents(filePart.getBytes());
            coverPhoto.setBook(book);
            if (coverPhoto.getName()!=null && coverPhoto.getName().length()>0 && coverPhoto.getContents()!=null && coverPhoto.getContents().length > 0){
                book.getCoverphotos().add(coverPhoto);
            }
        }
        book.setQuantity(quantity);
        Book savedBook = bRepo.save(book);
        return savedBook.getBook_id();
    }
}
