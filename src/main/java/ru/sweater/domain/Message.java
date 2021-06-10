package ru.sweater.domain;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

import lombok.Data;
import org.hibernate.validator.constraints.Length;
import ru.sweater.domain.utils.MessageHelper;

import java.util.HashSet;
import java.util.Set;

@Data
@Entity
public class Message {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotBlank(message = "Please fill the message")
    @Length(max = 2048, message = "Message too long (more than 2kB)")
    private String text;
    @Length(max = 255, message = "Tag too long (more than 255)")
    private String tag;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User author;

    private String filename;

    @ManyToMany
    @JoinTable(name = "message_likes",
              joinColumns = { @JoinColumn(name = "message_id") },
              inverseJoinColumns = { @JoinColumn(name = "user_id")})
    private Set<User> likes = new HashSet<>();

    public Message() {}

    public Message(String text, String tag, User user) {
        this.author = user;
        this.text = text;
        this.tag = tag;
    }

    public String getAuthorName() {
        return MessageHelper.getAuthorName(author);
    }
}
