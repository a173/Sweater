package ru.sweater.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import ru.sweater.domain.Role;
import ru.sweater.domain.User;
import ru.sweater.service.UserService;

import javax.validation.Valid;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping
    public String userList(Model model,
                           @PageableDefault(sort = {"username"}, direction = Sort.Direction.ASC) Pageable pageable) {
        model.addAttribute("page", userService.findAll(pageable));
        model.addAttribute("url", "/user");

        return "userList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("{user}")
    public String userEditForm(@PathVariable User user,
                               Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("{user}")
    public String userSave(@RequestParam String username,
                           @Valid EmailValidate email,
                           BindingResult bindingResult,
                           @RequestParam(required = false) boolean active,
                           @RequestParam Map<String, String> form,
                           @RequestParam("userId") User user,
                           Model model) {

        if (username.isEmpty())
            model.addAttribute("usernameError", "Username cannot be empty");
        if (!user.getUsername().equals(username) && userService.findUserByUsername(username) != null)
            model.addAttribute("usernameError", "Username exists!");
        if (!user.getEmail().equals(email.getEmail()) && userService.findUserByEmail(email.getEmail()) != null)
            model.addAttribute("emailError", "Email exists!");
        if (bindingResult.hasErrors())
            model.mergeAttributes(ControllerUtils.getErrors(bindingResult));
        if (model.asMap().size() != 2) {
            model.addAttribute("user", user);
            model.addAttribute("roles", Role.values());
            return "userEdit";
        }
        userService.saveUser(user, username, email.getEmail(), active, form);

        return "redirect:/user";
    }

    @GetMapping("profile")
    public String getProfile(Model model, @AuthenticationPrincipal User user) {
        User currentUser = userService.findUserByUsername(user.getUsername());
        model.addAttribute("username", currentUser.getUsername());
        model.addAttribute("email", currentUser.getEmail());

        return "profile";
    }

    static class EmailValidate{
        @Email(message = "Email is not correct")
        @NotBlank(message = "Email cannot be empty")
        String email;

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }
    }

    @PostMapping("profile")
    public String updateProfile(@AuthenticationPrincipal User user,
                                @RequestParam String password,
                                @RequestParam String password2,
                                @Valid EmailValidate email,
                                BindingResult bindingResult,
                                Model model) {
        if (password != null && !password.equals(password2))
            model.addAttribute("passwordError", "Password are different!");
        if (bindingResult.hasErrors())
            model.mergeAttributes(ControllerUtils.getErrors(bindingResult));
        if (!user.getEmail().equals(email.getEmail()) && userService.findUserByEmail(email.getEmail()) != null)
            model.addAttribute("emailError", "Email exists!");
        if (model.asMap().size() != 2) {
            model.addAttribute("username", user.getUsername());
            model.addAttribute("email", user.getEmail());
            return "profile";
        }
        userService.updateProfile(user, password, email.getEmail());
        return "redirect:/user/profile";
    }

    @GetMapping("subscribe/{user}")
    public String subscribe(@AuthenticationPrincipal User currentUser,
                            @PathVariable User user) {
        userService.subscribe(currentUser, user);
        return "redirect:/user-messages/" + user.getId();
    }

    @GetMapping("unsubscribe/{user}")
    public String unsubscribe(@AuthenticationPrincipal User currentUser,
                              @PathVariable User user) {
        userService.unsubscribe(currentUser, user);
        return "redirect:/user-messages/" + user.getId();
    }

    @GetMapping("{type}/{user}/list")
    public String userList(@PathVariable String type,
                           @PathVariable User user,
                           Model model) {
        model.addAttribute("userChannel", user);
        model.addAttribute("type", type);

        if (type.equals("subscriptions"))
            model.addAttribute("users", user.getSubscriptions());
        else
            model.addAttribute("users", user.getSubscribers());

        return "subscriptions";
    }
}