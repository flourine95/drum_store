package com.drumstore.web.validators;

import com.drumstore.web.services.UserService;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

public class ForgotPasswordValidator {
    private final UserService userService = new UserService();

    public Map<String, String> validate(String email) {
        Map<String, String> errors = new HashMap<>();

        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Vui lòng nhập email.");
        } else if (!Pattern.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$", email)) {
            errors.put("email", "Định dạng email không hợp lệ.");
        }

        return errors;
    }
}
