package ru.sweater.repos;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import ru.sweater.domain.User;

public interface UserRepo extends JpaRepository<User, Long> {

    Page<User> findAll(Pageable pageable);

    User findByUsername(String username);

    User findByActivationCode(String code);

    User findByEmail(String email);
}
