package hkmu.comps380f.controller;

import hkmu.comps380f.dao.*;
import hkmu.comps380f.exception.NotEnoughBooksInStockException;
import hkmu.comps380f.model.AppUser;
import hkmu.comps380f.model.Book;
import hkmu.comps380f.model.CoverPhoto;
import hkmu.comps380f.model.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ShoppingCartController {
    private final ShoppingCartService shoppingCartService;
    private final BookService bookService;
    private final BookRepository bookRepository;
    private final CoverPhotoRepository coverPhotoRepository;
    private final OrderRepository orderRepository;

    @Autowired
    public ShoppingCartController(ShoppingCartService shoppingCartService, BookService bookService, BookRepository bookRepository, CoverPhotoRepository coverPhotoRepository, OrderRepository orderRepository) {
        this.shoppingCartService = shoppingCartService;
        this.bookService = bookService;
        this.bookRepository = bookRepository;
        this.coverPhotoRepository = coverPhotoRepository;
        this.orderRepository = orderRepository;
    }

    @GetMapping("/shoppingCart")
    public String shoppingCart(Model model, Principal principal) {
        String username = principal.getName();
        model.addAttribute("books", shoppingCartService.getBooksInCart());
        model.addAttribute("total", shoppingCartService.getTotal().toString());
        Map<Long, CoverPhoto> coverPhotoMap = new HashMap<>();
        for (Map.Entry<Book, Integer> entry : shoppingCartService.getBooksInCart().entrySet()) {
            Book book = entry.getKey();
            Long bookId = book.getBook_id();
            CoverPhoto coverPhoto = coverPhotoRepository.findByBookId(bookId);
            coverPhotoMap.put(bookId, coverPhoto);
        }
        model.addAttribute("coverPhoto", coverPhotoMap);
        model.addAttribute("username", username);
        return "shoppingCart";
    }
    @PostMapping("/shoppingCart/removeProducts")
    public String removeSelectedProducts(@RequestParam("selectedBooks") List<Long> selectedBookIds) {
        for (Long bookId : selectedBookIds) {
            bookRepository.findById(bookId).ifPresent(shoppingCartService::removeProductBook);
        }
        return "redirect:/shoppingCart";
    }
    @GetMapping("/shoppingCart/addProduct/{BookId}")
    public String addProductToCart(@PathVariable("BookId") Long BookId) {
        bookRepository.findById(BookId).ifPresent(shoppingCartService::addProductBook);
        return "redirect:/shoppingCart";
    }

    @GetMapping("/shoppingCart/removeProduct/{BookId}")
    public String removeProductFromCart(@PathVariable("BookId") Long BookId) {
        bookRepository.findById(BookId).ifPresent(shoppingCartService::removeProductBook);
        return "redirect:/shoppingCart";
    }

    @GetMapping("/shoppingCart/checkout/{username}")
    public String checkout(Model model, @PathVariable("username") String username) {
        Map<Book, Integer> cartItems = shoppingCartService.getBooksInCart();
        BigDecimal totalPrice = calculateTotalPrice(cartItems);
        model.addAttribute("total", totalPrice);
        model.addAttribute("username", username);
        return "checkout";
    }
    private BigDecimal calculateTotalPrice(Map<Book, Integer> cartItems) {
        BigDecimal totalPrice = BigDecimal.ZERO;
        for (Map.Entry<Book, Integer> entry : cartItems.entrySet()) {
            Book book = entry.getKey();
            Integer quantity = entry.getValue();
            BigDecimal itemPrice = book.getPrice().multiply(BigDecimal.valueOf(quantity));
            totalPrice = totalPrice.add(itemPrice);
        }
        return totalPrice;
}
    @PostMapping("/shoppingCart/processPayment")
    public String processPayment(Model model, RedirectAttributes redirectAttributes, Principal principal) {
        String username = principal.getName();
        Map<Book, Integer> cartItems = shoppingCartService.getBooksInCart();
        BigDecimal totalPrice = calculateTotalPrice(cartItems);
        for (Map.Entry<Book, Integer> entry : cartItems.entrySet()) {
            Book book = entry.getKey();
            Integer quantity = entry.getValue();
            book.setQuantity(book.getQuantity() - quantity);
            bookRepository.save(book);
        }
        Order order = new Order(username, cartItems, totalPrice);
        orderRepository.save(order);
        redirectAttributes.addFlashAttribute("message", "Payment successful!");
        return "redirect:/user/"+username;
    }
    @PostMapping("/shoppingCart/updateQuantity")
    @ResponseBody
    public BigDecimal updateQuantity(@RequestBody Map<String, Object> requestBody) {
        Long bookId = Long.parseLong(requestBody.get("bookId").toString());
        Integer quantity = Integer.parseInt(requestBody.get("quantity").toString());
        bookRepository.findById(bookId).ifPresent(book -> shoppingCartService.updateProductQuantity(book, quantity));
        Map<Book, Integer> cartItems = shoppingCartService.getBooksInCart();
        return calculateTotalPrice(cartItems);
    }
}