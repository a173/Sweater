package ru.sweater.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import ru.sweater.domain.User;
import ru.sweater.domain.dto.MessageDto;
import ru.sweater.repos.MessageRepo;

@Service
public class MessageService {
    @Autowired
    private MessageRepo messageRepo;

    public Page<MessageDto> messagesList(String filter,
                                         Pageable pageable,
                                         User user) {
        if (filter != null && !filter.isEmpty())
            return messageRepo.findByTag(filter, pageable, user);
        else
            return messageRepo.findAll(pageable, user);
    }

    public Page<MessageDto> messagesList(Pageable pageable, User user) {
        return messageRepo.findAll(pageable, user);
    }

    public Page<MessageDto> messagesListForUser(Pageable pageable, User currentUser, User author) {
        return messageRepo.findByUser(pageable, author, currentUser);
    }
}
