package ru.sweater.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Map;
import java.util.stream.Collector;
import java.util.stream.Collectors;

@Controller
public class ControllerUtils implements ErrorController {
    static Map<String, String> getErrors(BindingResult bindingResult) throws IllegalStateException {
        Collector<FieldError, ?, Map<String, String>> collector = Collectors.toMap(
                fieldError -> fieldError.getField() + "Error",
                FieldError::getDefaultMessage
        );
        return bindingResult.getFieldErrors().stream().collect(collector);
    }

    @GetMapping("/error")
    public String errorNotFound() {
        return "error";
    }

    @Override
    public String getErrorPath() {
        return "error";
    }
}
