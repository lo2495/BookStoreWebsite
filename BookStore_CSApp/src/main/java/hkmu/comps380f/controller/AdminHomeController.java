package hkmu.comps380f.controller;

import hkmu.comps380f.dao.AppUserRepository;
import hkmu.comps380f.dao.AppUserService;
import hkmu.comps380f.dao.BookService;
import hkmu.comps380f.model.AppUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class AdminHomeController {
    private final AppUserService appUserService;
    private final AppUserRepository appuserRepository;
    private final BookService bookService;

    @Autowired
    public AdminHomeController(BookService bookService, AppUserService appUserService, AppUserRepository appuserRepository) {
        this.appUserService = appUserService;
        this.bookService = bookService;
        this.appuserRepository = appuserRepository;
    }

    @GetMapping("/admin/{username}")
    public String adminhome(@PathVariable String username, Model model) {
        model.addAttribute("bookDatabase", bookService.getAllBooks());
        model.addAttribute("username", username);
        return "admin-home";
    }
    @GetMapping("/admin/{username}/usermanagement")
    public String userManagement(@PathVariable String username, Model model){
        List<AppUser> appUserList = appUserService.getAllUsers();
        model.addAttribute("userList",appUserList);
        return "admin-userManagement";
    }
    @GetMapping("/admin/{username}/inventorymanagement")
    public String inventoryManagement(@PathVariable String username, Model model){
        model.addAttribute("bookDatabase", bookService.getAllBooks());
        model.addAttribute("username", username);
        return "admin-inventoryManagement";
    }
}
