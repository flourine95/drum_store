package com.drumstore.web.validators;

import java.util.HashMap;
import java.util.Map;

public class LoginValidator {
    public Map<String, String> validate(String email, String password) {
        Map<String, String> errors = new HashMap<>();

        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Vui lòng nhập email");
        } else if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errors.put("email", "Email không hợp lệ");
        }

        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Vui lòng nhập mật khẩu");
        }

        return errors;
    }
}
