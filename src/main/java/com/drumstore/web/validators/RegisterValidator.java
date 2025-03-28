package com.drumstore.web.validators;

import com.drumstore.web.services.UserService;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

public class RegisterValidator {
    private final UserService userService = new UserService();

    public Map<String, String> validate(String fullname, String phone, String email, String password) {
        Map<String, String> errors = new HashMap<>();

        if (fullname == null || fullname.trim().isEmpty()) {
            errors.put("fullname", "Họ và tên không được để trống.");
        }

        if (phone == null || phone.trim().isEmpty()) {
            errors.put("phone", "Số điện thoại không được để trống.");
        } else if (!Pattern.matches("^[0-9]{10,15}$", phone)) {
            errors.put("phone", "Số điện thoại không hợp lệ.");
        }

        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email không được để trống.");
        } else if (!Pattern.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$", email)) {
            errors.put("email", "Email không hợp lệ.");
        } else if (userService.isEmailExists(email)) {
            errors.put("email", "Email đã tồn tại.");
        }

        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Mật khẩu không được để trống.");
        } else {
            String passwordPattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!@#$%^&*]).{8,}$";
            if (!Pattern.matches(passwordPattern, password)) {
                errors.put("password", "Mật khẩu phải có ít nhất 8 ký tự, gồm chữ hoa, chữ thường, số và ký tự đặc biệt (!@#$%^&*).");
            }
        }

        return errors;
    }
}
