package ru.sweater.domain.dto;
import lombok.Getter;
import lombok.ToString;
import ru.sweater.domain.Message;
import ru.sweater.domain.User;
import ru.sweater.domain.utils.MessageHelper;

@Getter
@ToString(exclude = {"text", "tag", "filename"})
public class MessageDto {
    private Long id;
    private String text;
    private String tag;
    private User author;
    private String filename;
    private Long likes;
    private Boolean meLiked;

    public MessageDto(Message message, Long likes, Boolean meLiked) {
        this.id = message.getId();
        this.text = message.getText();
        this.tag = message.getTag();
        this.author = message.getAuthor();
        this.filename = message.getFilename();
        this.likes = likes;
        this.meLiked = meLiked;
    }

    public String getAuthorName() {
        return MessageHelper.getAuthorName(author);
    }
}
