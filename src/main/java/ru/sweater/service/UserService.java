package ru.sweater.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import ru.sweater.domain.Role;
import ru.sweater.domain.User;
import ru.sweater.repos.UserRepo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;


import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    @Value("${hostname}")
    private String myUrl;

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private MailSender mailSender;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepo.findByUsername(username);

        if (user == null)
            throw new InternalAuthenticationServiceException("User not found");
        return user;
    }

    public boolean addUser(User user) {
        User userFromDb = userRepo.findByUsername(user.getUsername());

        if (userFromDb != null) return false;

        user.setActive(true);
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepo.save(user);

        sendMessage(user);
        return true;
    }

    public boolean doubleUsername(User user) {
        return userRepo.findByUsername(user.getUsername()) == null;
    }

    public boolean doubleEmail(User user) {
        return userRepo.findByEmail(user.getEmail()) == null;
    }

    private void sendMessage(User user) {
        if (!ObjectUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Hello, %s! \nWelcome to Sweater. " +
                            "Please, visit next link: http://%s/activate/%s",
                    user.getUsername(),
                    myUrl,
                    user.getActivationCode()
            );
            mailSender.send(user.getEmail(), "Activation code", message);
        }
    }

    public boolean activateUser(String code) {
        User user = userRepo.findByActivationCode(code);
        if (user == null) return false;

        user.setActivationCode(null);
        userRepo.save(user);
        return true;
    }

    public Page<User> findAll(Pageable pageable) {
        return userRepo.findAll(pageable);
    }

    public User findUserByUsername(String username) {
        return userRepo.findByUsername(username);
    }

    public User findUserByEmail(String email) {
        return userRepo.findByEmail(email);
    }

    private boolean isEmailChanged(User user, String email) {
        return ((email != null && !email.equals(user.getEmail())) ||
                (user.getEmail() != null && !user.getEmail().equals(email)));
    }

    private void EmailChanged (User user, String email) {
        user.setEmail(email);

        if (!ObjectUtils.isEmpty(email))
            user.setActivationCode(UUID.randomUUID().toString());
    }

    public void saveUser(User user, String username, String email, boolean active, Map<String, String> form) {
        boolean isEmailChanged = isEmailChanged(user, email);

        if (!user.getUsername().equals(username))
            user.setUsername(username);
        if (isEmailChanged)
            EmailChanged(user, email);

        user.setActive(active);
        Set<String> roles = Arrays.stream(Role.values())
                .map((Role::name))
                .collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key : form.keySet()) {
            if (roles.contains(key))
                user.getRoles().add(Role.valueOf(key));
        }
        userRepo.save(user);

        if (isEmailChanged)
            sendMessage(user);
    }

    public void updateProfile(User user, String password, String email) {
        boolean isEmailChanged = isEmailChanged(user, email);

        if (isEmailChanged)
            EmailChanged(user, email);

        if (!ObjectUtils.isEmpty(password))
            user.setPassword(passwordEncoder.encode(password));

        userRepo.save(user);

        if (isEmailChanged)
            sendMessage(user);
    }

    public void subscribe(User currentUser, User user) {
        user.getSubscribers().add(currentUser);
        userRepo.save(user);
    }

    public void unsubscribe(User currentUser, User user) {
        user.getSubscribers().remove(currentUser);
        userRepo.save(user);
    }
}
