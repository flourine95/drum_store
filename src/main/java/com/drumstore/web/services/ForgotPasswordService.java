package com.drumstore.web.services;

import com.drumstore.web.dto.UserDTO;
import com.drumstore.web.models.User;
import com.drumstore.web.repositories.UserRepository;

import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.Base64;

public class ForgotPasswordService {
    private final UserRepository userRepository = new UserRepository();
    private final MailService mailService = new MailService();


    public boolean requestPasswordReset(String email) {
        UserDTO user = userRepository.findUser("email", email);
        if (user == null) {
            return false;
        }

        String resetToken = generateResetToken();
        LocalDateTime expiryTime = LocalDateTime.now().plusMinutes(30);

        try {
            userRepository.saveResetToken(user.getId(), resetToken, expiryTime);
            mailService.sendPasswordResetEmail(email, resetToken);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean validateResetToken(String token) {
        return userRepository.isResetTokenValid(token);
    }

    public boolean resetPassword(String token, String newPassword) {
        User user = userRepository.findByResetToken(token);
        if (user == null || !validateResetToken(token)) {
            return false;
        }

        try {
            userRepository.updatePassword(user.getId(), newPassword);
            userRepository.markResetTokenAsUsed(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    private String generateResetToken() {
        SecureRandom secureRandom = new SecureRandom();
        byte[] tokenBytes = new byte[32];
        secureRandom.nextBytes(tokenBytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(tokenBytes);
    }
} 