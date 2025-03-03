package com.drumstore.web.services;

import com.drumstore.web.models.User;
import com.drumstore.web.repositories.UserRepository;
import com.drumstore.web.utils.EmailSender;

import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.Base64;

public class ForgotPasswordService {
    private final UserRepository userRepository;
    
    public ForgotPasswordService() {
        this.userRepository = new UserRepository();
    }

    public boolean requestPasswordReset(String email) {
        User user = userRepository.findByEmail(email);
        if (user == null) {
            return false;
        }

        String resetToken = generateResetToken();
        LocalDateTime expiryTime = LocalDateTime.now().plusMinutes(15);
        
        try {
            userRepository.saveResetToken(user.getId(), resetToken, expiryTime);
            EmailSender.sendPasswordResetEmail(email, resetToken);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
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
            userRepository.markResetTokenAsUsed(user.getId(), token);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
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