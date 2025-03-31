package hkmu.comps380f.controller;

import hkmu.comps380f.dao.*;
import hkmu.comps380f.exception.BookNotFound;
import hkmu.comps380f.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.security.Principal;
import java.util.*;

@Controller
@RequestMapping("/admin/{username}/inventorymanagement")
public class InventoryManagementController {
    private final BookService bookService;
    private final BookRepository bookRepository;
    private final CoverPhotoRepository coverPhotoRepository;
    private final CommentRepository commentRepository;
    private final OrderRepository orderRepository;

    @Autowired
    public InventoryManagementController(BookService bookService, BookRepository bookRepository, CoverPhotoRepository coverPhotoRepository, CommentRepository commentRepository, OrderRepository orderRepository) {
        this.bookService = bookService;
        this.bookRepository = bookRepository;
        this.coverPhotoRepository = coverPhotoRepository;
        this.commentRepository = commentRepository;
        this.orderRepository = orderRepository;
    }

    @GetMapping("/addbook")
    public ModelAndView addBook(){
        return new ModelAndView("admin-addBook","BookForm", new Form());
    }
    public static class Form{
        private String bookname;
        private String author;
        private BigDecimal price;
        private String description;
        private boolean availability;
        private Integer quantity;
        private List<MultipartFile> coverphoto;

        public String getBookname() {
            return bookname;
        }

        public void setBookname(String bookname) {
            this.bookname = bookname;
        }

        public String getAuthor() {
            return author;
        }

        public void setAuthor(String author) {
            this.author = author;
        }

        public BigDecimal getPrice() {
            return price;
        }

        public void setPrice(BigDecimal price) {
            this.price = price;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public boolean isAvailability() {
            return availability;
        }

        public void setAvailability(boolean availability) {
            this.availability = availability;
        }

        public Integer getQuantity() {
            return quantity;
        }

        public void setQuantity(Integer quantity) {
            this.quantity = quantity;
        }

        public List<MultipartFile> getCoverphoto() {
            return coverphoto;
        }

        public void setCoverphoto(List<MultipartFile> coverphoto) {
            this.coverphoto = coverphoto;
        }

        @Override
        public String toString() {
            return "Form{" +
                    "bookname='" + bookname + '\'' +
                    ", author='" + author + '\'' +
                    ", price=" + price +
                    ", description='" + description + '\'' +
                    ", availability=" + availability +
                    ", quantity=" + quantity +
                    ", coverphoto=" + coverphoto +
                    '}';
        }
    }
    @PostMapping("/addbook")
    public String addBook(Form form) throws IOException {
        long bookId = bookService.createBook(form.getBookname(), form.getAuthor(), form.getPrice(),
                form.getDescription(), form.isAvailability(), form.getCoverphoto(), form.getQuantity());
        return "redirect:/admin/{username}/inventorymanagement";
    }

    @GetMapping("/book/view/{bookId}")
    public String view(@PathVariable("bookId") long bookId, ModelMap model, @PathVariable("username") String username)
            throws BookNotFound {
        Book book = bookService.getBook(bookId);
        CoverPhoto coverPhoto = coverPhotoRepository.findByBookId(bookId);
        List<Comment> comments = commentRepository.findByBookId(bookId);
        model.addAttribute("bookId", bookId);
        model.addAttribute("book", book);
        model.addAttribute("coverPhoto", coverPhoto);
        model.addAttribute("comments", comments);
        model.addAttribute("newComment", new Comment());
        return "view";
    }

    @PostMapping("/addComment/{bookId}")
    public String addComment(@PathVariable("bookId") long bookId, @ModelAttribute("newComment") Comment comment, Principal principal,@PathVariable("username") String username) {
        String loginusername = principal.getName();
        comment.setBookId(bookId);
        comment.setUsername(loginusername);
        comment.setTimestamp(new Date());
        commentRepository.save(comment);
        return "redirect:/admin/{username}/inventorymanagement/book/view/{bookId}";
    }

    @GetMapping("{bookId}/deleteComment/{deletecommentId}")
    public String deleteComment(@PathVariable("bookId") long bookId, @PathVariable long deletecommentId, @PathVariable("username") String username) {
        Comment comment = commentRepository.findById(deletecommentId).orElse(null);
        System.out.println(comment);
        commentRepository.delete(comment);
        return "redirect:/admin/{username}/inventorymanagement/book/view/"+bookId;
    }

    @GetMapping("/coverPhoto/{coverPhotoId}")
    public ResponseEntity<byte[]> viewCoverPhoto(@PathVariable long coverPhotoId) {
        CoverPhoto coverPhoto = coverPhotoRepository.findById(coverPhotoId).orElse(null);
        if (coverPhoto != null) {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.parseMediaType(coverPhoto.getMimecontentType()));
            headers.setContentLength(coverPhoto.getContents().length);
            return new ResponseEntity<>(coverPhoto.getContents(), headers, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    @PostMapping("/savebook")
    @Transactional
    public String saveBook(@ModelAttribute("book") Book updatedBook, @PathVariable("username") String username) {
        Book existingBook = bookRepository.findById(updatedBook.getBook_id()).orElse(null);
        existingBook.setBookname(updatedBook.getBookname());
        existingBook.setAuthor(updatedBook.getAuthor());
        existingBook.setPrice(updatedBook.getPrice());
        existingBook.setDescription(updatedBook.getDescription());
        existingBook.setAvailability(updatedBook.isAvailability());
        existingBook.setQuantity(updatedBook.getQuantity());
        bookRepository.save(existingBook);
        return "redirect:/admin/{username}/inventorymanagement";
    }
    @GetMapping("/delete/{deleteBookId}")
    public String deleteUser(@PathVariable String username, @PathVariable long deleteBookId) {
        Book deleteBook = bookRepository.findById(deleteBookId).orElse(null);
        List<Order> orders = orderRepository.findOrdersByBook(deleteBook);
        for (Order order : orders) {
            orderRepository.delete(order);
        }
        System.out.println(deleteBook);
        bookRepository.delete(deleteBook);
        return "redirect:/admin/{username}/inventorymanagement";
    }
}
