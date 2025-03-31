package hkmu.comps380f.controller;

import hkmu.comps380f.dao.AppUserRepository;
import hkmu.comps380f.dao.UserRoleRepository;
import hkmu.comps380f.model.AppUser;
import hkmu.comps380f.model.UserRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;


@Controller
@RequestMapping("/admin/{username}/usermanagement")
public class UserManagementController {
    private final AppUserRepository appUserRepository;
    private final UserRoleRepository userRoleRepository;

    @Autowired
    public UserManagementController(AppUserRepository appUserRepository, UserRoleRepository userRoleRepository) {
        this.appUserRepository = appUserRepository;
        this.userRoleRepository = userRoleRepository;
    }

    @GetMapping("/edit/{editUsername}")
    public String showEditUserForm(@PathVariable String username, @PathVariable String editUsername, Model model) {
        System.out.println(editUsername);
        AppUser editedUser = appUserRepository.findByUsername(editUsername);
        System.out.println(editedUser);
        if (editedUser == null) {
            throw new IllegalArgumentException("Invalid username: " + editUsername);
        }
        model.addAttribute("editedUser", editedUser);
        return "edit-user-form";
    }

    @PostMapping("/edit/{editUsername}")
    public String editUser(@PathVariable String username, @PathVariable String editUsername, @ModelAttribute("editedUser") AppUser editedUser) {
        AppUser appUser = appUserRepository.findByUsername(editUsername);
        if (appUser == null) {
            throw new IllegalArgumentException("Invalid username: " + editedUser.getUsername());
        }
        appUser.setUsername(editedUser.getUsername());
        appUser.setPassword(editedUser.getPassword());
        appUser.setFullname(editedUser.getFullname());
        appUser.setEmail(editedUser.getEmail());
        appUser.setDeliveryaddress(editedUser.getDeliveryaddress());
        appUserRepository.save(appUser);
        return "redirect:/admin/{username}/usermanagement";
    }

    @GetMapping("/adduser")
    public String showAddUserForm(Model model) {
        model.addAttribute("AppUser", new AppUser());
        return "add-user-form";
    }

    @PostMapping("/adduser")
    @Transactional
    public String addUser(@PathVariable("username")String username, @ModelAttribute("AppUser")AppUser appUser, @RequestParam("userrole")String[] roles) {
        String password = appUser.getPassword();
        appUser.setPassword("{noop}" + password);
        appUserRepository.save(appUser);
        List<UserRole> userRoles = new ArrayList<>();
        for (String role : roles) {
            UserRole userRole = new UserRole();
            userRole.setRole(role);
            userRole.setUsername(appUser.getUsername());
            userRoles.add(userRole);
            userRoleRepository.save(userRole);
        }

        return "redirect:/admin/"+username+"/usermanagement";
    }

    @GetMapping("/delete/{deleteUsername}")
    public String deleteUser(@PathVariable String username, @PathVariable String deleteUsername) {
        AppUser appUser = appUserRepository.findByUsername(deleteUsername);
        if (appUser == null) {
            throw new IllegalArgumentException("Invalid username: " + deleteUsername);
        }
        appUserRepository.delete(appUser);
        return "redirect:/admin/{username}/usermanagement";
    }
}