package ru.sweater.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;
import ru.sweater.domain.Message;
import ru.sweater.domain.User;
import ru.sweater.repos.MessageRepo;
import ru.sweater.service.MessageService;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Set;
import java.util.UUID;

@Controller
public class MessageController {
    @Autowired
    private MessageRepo messageRepo;

    @Autowired
    private MessageService messageService;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String main(@AuthenticationPrincipal User user,
                       @RequestParam(required = false, defaultValue = "") String filter,
                       Model model,
                       @PageableDefault(sort = {"id"}, direction = Sort.Direction.DESC) Pageable pageable) {
        model.addAttribute("page", messageService.messagesList(filter, pageable, user));
        model.addAttribute("url", "/");
        model.addAttribute("filter", filter);
        return "main";
    }

    @PreAuthorize("#user.username == authentication.principal.username")
    @PostMapping("/")
    public String add(@AuthenticationPrincipal User user,
                      @Valid Message message,
                      BindingResult bindingResult,
                      Model model,
                      @RequestParam("file") MultipartFile file,
                      @PageableDefault(sort = { "id" }, direction = Sort.Direction.DESC) Pageable pageable)
            throws IOException {
        message.setAuthor(user);
        if (bindingResult.hasErrors()) {
            model.mergeAttributes(ControllerUtils.getErrors(bindingResult));
            model.addAttribute("message", message);
        } else {
            saveFile(message, file);

            model.addAttribute("message", null);
            messageRepo.save(message);
        }
        model.addAttribute("url", "/");
        model.addAttribute("page", messageService.messagesList(pageable, user));
        return "main";
    }

    private void saveFile(@Valid Message message,
                          @RequestParam("file") MultipartFile file) throws IOException {
        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists())
                uploadDir.mkdir();
            String resultFilename = UUID.randomUUID() + "." + file.getOriginalFilename();
            file.transferTo(new File(uploadPath + "/" + resultFilename));
            message.setFilename(resultFilename);
        }
    }

    private void addVariable(User author,
                             User currentUser,
                             Pageable pageable,
                             Message message,
                             Model model) {
        model.addAttribute("userChannel", author);
        model.addAttribute("subscriptionsCount", author.getSubscriptions().size());
        model.addAttribute("subscribersCount", author.getSubscribers().size());
        model.addAttribute("isSubscriber", author.getSubscribers().contains(currentUser));
        model.addAttribute("isCurrentUser", currentUser.equals(author));
        model.addAttribute("page", messageService.messagesListForUser(pageable, currentUser, author));
        model.addAttribute("message", message);
        model.addAttribute("url", "/user-messages/" + author.getId());
    }

    @GetMapping("/user-messages/{author}")
    public String userMessages(@AuthenticationPrincipal User currentUser,
                               @PathVariable User author,
                               Model model,
                               @RequestParam(required = false) Message message,
                               @PageableDefault(sort = {"id"}, direction = Sort.Direction.DESC) Pageable pageable) {
        addVariable(author, currentUser, pageable, message, model);
        return "userMessages";
    }

    @PostMapping("/user-messages/{author}")
    public String updateMessages(@AuthenticationPrincipal User currentUser,
                                 @PathVariable User author,
                                 @RequestParam Message message,
                                 @RequestParam String text,
                                 @RequestParam String tag,
                                 @RequestParam("file") MultipartFile file,
                                 Model model,
                                 @PageableDefault(sort = {"id"}, direction = Sort.Direction.DESC) Pageable pageable) throws IOException {

        if (!message.getAuthor().equals(currentUser))
            model.addAttribute("userError", "You are not the author of this post");
        if (ObjectUtils.isEmpty(text))
            model.addAttribute("textError", "Please fill the message");
        if (text.length() > 2048)
            model.addAttribute("textError", "Message too long (more than 2kB)");
        if (tag.length() > 255)
            model.addAttribute("tagError", "Tag too long (more than 255)");
        if (model.asMap().size() != 0) {
            addVariable(author, currentUser, pageable, message, model);
            return "userMessages";
        }
        if (!ObjectUtils.isEmpty(tag))
            message.setTag(tag);
        message.setText(text);
        saveFile(message, file);
        messageRepo.save(message);
        return "redirect:/user-messages/" + author.getId();
    }

    @GetMapping("/{message}/like")
    public String like(@AuthenticationPrincipal User currentUser,
                       @PathVariable Message message,
                       RedirectAttributes redirectAttributes,
                       @RequestHeader(required = false) String referer) {
        Set<User> likes = message.getLikes();

        if (likes.contains(currentUser))
            likes.remove(currentUser);
        else
            likes.add(currentUser);
        UriComponents components = UriComponentsBuilder.fromHttpUrl(referer).build();
        components.getQueryParams()
                .forEach(redirectAttributes::addAttribute);
        return "redirect:" + components.getPath();
    }
}