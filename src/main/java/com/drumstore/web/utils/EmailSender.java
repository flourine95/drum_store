package com.drumstore.web.utils;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailSender {
    private static final String FROM_EMAIL = "flourinee@gmail.com"; // Replace with your Gmail
    private static final String PASSWORD = "jala xigu kuvl qsct"; // Replace with your app password

    public static void sendPasswordResetEmail(String toEmail, String resetToken) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Password Reset Request");

            String resetLink = "http://localhost:8080/forgot-password?token=" + resetToken;
            String htmlContent = String.format("""
                <h2>Password Reset Request</h2>
                <p>Click the link below to reset your password:</p>
                <a href="%s">Reset Password</a>
                <p>If you didn't request this, please ignore this email.</p>
                <p>This link will expire in 15 minutes.</p>
                """, resetLink);

            message.setContent(htmlContent, "text/html; charset=utf-8");
            Transport.send(message);

        } catch (MessagingException e) {
            throw new RuntimeException("Error sending email: " + e.getMessage());
        }
    }
} 