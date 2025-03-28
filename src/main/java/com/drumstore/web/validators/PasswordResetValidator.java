package com.drumstore.web.validators;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

public class PasswordResetValidator {

    public Map<String, String> validate(String password, String confirmPassword) {
        Map<String, String> errors = new HashMap<>();

        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Mật khẩu không được để trống.");
        } else {
            String passwordPattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!@#$%^&*]).{8,}$";
            if (!Pattern.matches(passwordPattern, password)) {
                errors.put("password", "Mật khẩu phải có ít nhất 8 ký tự, gồm chữ hoa, chữ thường, số và ký tự đặc biệt (!@#$%^&*).");
            }
        }

        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            errors.put("confirmPassword", "Vui lòng nhập lại mật khẩu.");
        } else if (!password.equals(confirmPassword)) {
            errors.put("confirmPassword", "Mật khẩu nhập lại không khớp.");
        }

        return errors;
    }
}
