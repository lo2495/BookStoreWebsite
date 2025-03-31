package hkmu.comps380f.controller;

import hkmu.comps380f.dao.*;
import hkmu.comps380f.exception.BookNotFound;
import hkmu.comps380f.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
public class UserHomeController {
    private final BookService bookService;
    private final AppUserRepository appUserRepository;
    private final CoverPhotoRepository coverPhotoRepository;
    private final CommentRepository commentRepository;
    private final OrderRepository orderRepository;
    @Autowired
    public UserHomeController(BookService bookService, AppUserRepository appUserRepository, CoverPhotoRepository coverPhotoRepository, CommentRepository commentRepository, OrderRepository orderRepository) {
        this.bookService = bookService;
        this.appUserRepository = appUserRepository;
        this.coverPhotoRepository = coverPhotoRepository;
        this.commentRepository = commentRepository;
        this.orderRepository = orderRepository;
    }

    @GetMapping("/user/{username}")
    public String userhome(@PathVariable String username, Model model) {
        List<Book> books = bookService.getAllBooks();
        Map<Long, CoverPhoto> coverPhotoMap = new HashMap<>();

        for (Book book : books) {
            Long bookId = book.getBook_id();
            CoverPhoto coverPhoto = coverPhotoRepository.findByBookId(bookId);
            coverPhotoMap.put(bookId, coverPhoto);
        }
        model.addAttribute("bookDatabase", books);
        model.addAttribute("coverPhoto", coverPhotoMap);
        return "user-home";
    }
    @GetMapping("/user/{username}/bookdetails/{bookId}")
    public String view(@PathVariable("bookId") long bookId, ModelMap model, @PathVariable("username") String username)
            throws BookNotFound {
        Book book = bookService.getBook(bookId);
        CoverPhoto coverPhoto = coverPhotoRepository.findByBookId(bookId);
        List<Comment> comments = commentRepository.findByBookId(bookId);
        System.out.println("Comments:"+comments);
        model.addAttribute("bookId", bookId);
        model.addAttribute("book", book);
        model.addAttribute("coverPhoto", coverPhoto);
        model.addAttribute("comments", comments);
        return "user-bookdetails";
    }
    @GetMapping("/user/{username}/bookdetails/coverPhoto/{coverPhotoId}")
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

    @PostMapping("/user/{username}/bookdetails/{bookId}/addComment")
    @Transactional
    public String addComment(@ModelAttribute("comment") Comment comment, @PathVariable("username") String username, @PathVariable("bookId") long bookId)
            throws BookNotFound {
            Book book = bookService.getBook(bookId);
            comment.setBookId(bookId);
            comment.setUsername(username);
            comment.setTimestamp(new Date());
            commentRepository.save(comment);
            return "redirect:/user/{username}/bookdetails/"+bookId;
    }
    @GetMapping("/user/{username}/personalinformation")
    public String userShowPersonalInfo(@PathVariable String username, Model model) {
        AppUser appUser = appUserRepository.findByUsername(username);
        model.addAttribute("appuser",appUser);
        return "user-PersonalInfo";
    }
    @PostMapping("/user/{username}/personalinformation/updateInfo")
    public String updatePersonalInfo(@ModelAttribute("appuser") AppUser appUser, @PathVariable("username") String username){
        AppUser existinguser = appUserRepository.findByUsername(username);
        existinguser.setUsername(appUser.getUsername());
        existinguser.setPassword(appUser.getPassword());
        existinguser.setFullname(appUser.getFullname());
        existinguser.setEmail(appUser.getEmail());
        existinguser.setDeliveryaddress(appUser.getDeliveryaddress());
        appUserRepository.save(existinguser);
        return "redirect:/user/{username}";
    }
    @GetMapping("/user/{username}/orderhistory")
    public String orderHistory(@PathVariable String username, Model model) {
        List<Order> orders = orderRepository.findByUsername(username);
        model.addAttribute("orders", orders);
        return "user-orderhistory";
    }
    @GetMapping("/user/{username}/orderdetails/{orderno}")
    public String orderDetails(@PathVariable String username, @PathVariable Long orderno, Model model) {
        Order order = orderRepository.findByUsernameAndId(username, orderno);
        if (order == null) {
            return "redirect:/user/{username}/orderhistory";
        }
        List<Long> bookIds = new ArrayList<>();
        for (Map.Entry<Book, Integer> entry : order.getItems().entrySet()) {
            Book book = entry.getKey();
            Long bookId = book.getBook_id();
            bookIds.add(bookId);
        }
        List<CoverPhoto> coverPhotos = coverPhotoRepository.findByBookIdIn(bookIds);
        Map<Long, CoverPhoto> coverPhotoMap = new HashMap<>();
        for (CoverPhoto coverPhoto : coverPhotos) {
            coverPhotoMap.put(coverPhoto.getBookId(), coverPhoto);
        }
        model.addAttribute("order", order);
        model.addAttribute("coverPhotos", coverPhotoMap);
        return "user-orderdetails";
    }
}