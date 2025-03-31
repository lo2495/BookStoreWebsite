package hkmu.comps380f.controller;

import hkmu.comps380f.dao.*;
import hkmu.comps380f.model.AppUser;
import hkmu.comps380f.model.Book;
import hkmu.comps380f.model.CoverPhoto;
import hkmu.comps380f.model.UserRole;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class HomeController {
    private final BookService bookService;

    private final AppUserService appUserService;
    private final AppUserRepository appuserRepository;
    private final UserRoleRepository userRoleRepository;
    private final CoverPhotoRepository coverPhotoRepository;

    public HomeController(BookService bookService, AppUserRepository appuserRepository, UserRoleRepository userRoleRepository, AppUserService appUserService, CoverPhotoRepository coverPhotoRepository) {
        this.bookService = bookService;
        this.appuserRepository = appuserRepository;
        this.userRoleRepository = userRoleRepository;
        this.appUserService = appUserService;
        this.coverPhotoRepository = coverPhotoRepository;
    }

    @GetMapping("")
    public String home(ModelMap model, @ModelAttribute("systemMessage") String systemMessage) {
        List<Book> books = bookService.getAllBooks();
        Map<Long, CoverPhoto> coverPhotoMap = new HashMap<>();
        for (Book book : books) {
            Long bookId = book.getBook_id();
            CoverPhoto coverPhoto = coverPhotoRepository.findByBookId(bookId);
            coverPhotoMap.put(bookId, coverPhoto);
        }
        model.addAttribute("bookDatabase", books);
        model.addAttribute("coverPhoto", coverPhotoMap);
        model.addAttribute("systemMessage", systemMessage);
        return "home";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/registration")
    public String register(Model model)
    {
        model.addAttribute("AppUser",new AppUser());
        return "registration";
    }
    @PostMapping("/process_registration")
    public String registerUser(@ModelAttribute("AppUser")AppUser appUser, RedirectAttributes redirectAttributes) {
        String password = appUser.getPassword();
        appUser.setPassword("{noop}" + password);
        appuserRepository.save(appUser);
        UserRole userRole = new UserRole();
        userRole.setUsername(appUser.getUsername());
        userRole.setRole("ROLE_USER");
        userRoleRepository.save(userRole);
        redirectAttributes.addFlashAttribute("successMessage", "Registration successful!");
        redirectAttributes.addFlashAttribute("systemMessage", true);
        return "redirect:/";
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
}