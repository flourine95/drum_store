package com.drumstore.web.services;

import com.drumstore.web.utils.ConfigUtils;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Date;
import java.util.Properties;

public class MailService {
    private static final String FROM_EMAIL = ConfigUtils.get("email.sender");
    private static final String PASSWORD = ConfigUtils.get("email.password");
    private static final String BASE_URL = ConfigUtils.get("app.baseUrl");


    private Session createSession() {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        return Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });
    }

    public void sendEmail(String to, String subject, String content) throws MessagingException {
        Session session = createSession();
        MimeMessage msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(FROM_EMAIL));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
        msg.setSubject(subject);
        msg.setSentDate(new Date());
        msg.setContent(content, "text/html; charset=UTF-8");

        Transport.send(msg);
    }

    public String generateVerificationCode() {
        int code = 100000 + (int) (Math.random() * 900000);
        return String.valueOf(code);
    }

    public void sendVerificationEmail(String toEmail, String verificationCode) throws MessagingException {
        String subject = "Mã OTP xác thực tài khoản Drum Store";

        String content = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 10px;'>"
                + "<div style='text-align: center; margin-bottom: 20px;'>"
                + "<h1 style='color: #1B2832; margin-bottom: 10px;'>Xác thực tài khoản Drum Store</h1>"
                + "<div style='height: 3px; background-color: #FFD700; width: 100px; margin: 0 auto 20px;'></div>"
                + "</div>"
                + "<p style='color: #4A5568; font-size: 16px; line-height: 1.5;'>Xin chào,</p>"
                + "<p style='color: #4A5568; font-size: 16px; line-height: 1.5;'>Cảm ơn bạn đã đăng ký tài khoản tại Drum Store. Để hoàn tất quá trình đăng ký, vui lòng sử dụng mã OTP dưới đây:</p>"
                + "<div style='background-color: #f8f9fa; border-radius: 8px; padding: 20px; margin: 20px 0; text-align: center;'>"
                + "<h2 style='letter-spacing: 5px; font-size: 32px; color: #1B2832; margin: 0;'>" + verificationCode + "</h2>"
                + "</div>"
                + "<p style='color: #4A5568; font-size: 16px; line-height: 1.5;'>Mã này có hiệu lực trong <strong>5 phút</strong>. Vui lòng không chia sẻ mã này với người khác.</p>"
                + "<p style='color: #4A5568; font-size: 16px; line-height: 1.5;'>Nếu bạn không thực hiện yêu cầu này, vui lòng bỏ qua email này.</p>"
                + "<div style='margin-top: 30px; padding-top: 20px; border-top: 1px solid #e0e0e0;'>"
                + "<p style='color: #718096; font-size: 14px; text-align: center;'>© 2025 Drum Store. Tất cả các quyền được bảo lưu.</p>"
                + "</div>"
                + "</div>";

        sendEmail(toEmail, subject, content);
    }

    public void sendPasswordResetEmail(String toEmail, String resetToken) throws MessagingException {
        String resetLink = BASE_URL + "/forgot-password?token=" + resetToken;
        String subject = "Đặt Lại Mật Khẩu - Drum Store";

        String htmlContent = String.format("""
                <!DOCTYPE html>
                <html>
                <head>
                    <meta charset="UTF-8">
                    <style>
                        body { font-family: 'Segoe UI', Arial, sans-serif; color: #333; }
                        .container { max-width: 600px; margin: auto; padding: 20px; background-color: #f9fafb; }
                        .header { text-align: center; background-color: #fcc419; padding: 20px 0; border-radius: 8px 8px 0 0; }
                        .header h1 { color: #1B2832; margin: 0; font-size: 24px; }
                        .content { background-color: #fff; padding: 30px; border-radius: 0 0 8px 8px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); }
                        .reset-button { display: inline-block; padding: 12px 24px; background-color: #fcc419; color: #1B2832; text-decoration: none; border-radius: 6px; font-weight: bold; margin: 20px 0; }
                        .reset-button:hover { background-color: #f0b400; }
                        .footer { text-align: center; margin-top: 20px; color: #666; font-size: 14px; }
                        .warning { background-color: #fff3cd; border: 1px solid #ffeeba; color: #856404; padding: 12px; border-radius: 4px; margin-top: 20px; font-size: 14px; }
                    </style>
                </head>
                <body>
                    <div class="container">
                        <div class="header">
                            <h1>🥁 Drum Store</h1>
                        </div>
                        <div class="content">
                            <h2>Xin chào quý khách,</h2>
                            <p>Bạn đã yêu cầu đặt lại mật khẩu. Nhấn vào nút bên dưới để thực hiện:</p>
                            <div style="text-align: center;">
                                <a href="%s" class="reset-button">Đặt Lại Mật Khẩu</a>
                            </div>
                            <div class="warning">
                                <strong>Lưu ý:</strong>
                                <ul>
                                    <li>Liên kết này hết hạn sau 30 phút.</li>
                                    <li>Nếu không phải bạn yêu cầu, vui lòng bỏ qua email này.</li>
                                </ul>
                            </div>
                            <p>Nếu không nhấn được nút trên, sao chép liên kết sau:</p>
                            <p style="word-break: break-all;">%s</p>
                        </div>
                        <div class="footer">
                            <p>Email này được gửi tự động, vui lòng không trả lời.</p>
                            <p>&copy; 2025 Drum Store. All rights reserved.</p>
                        </div>
                    </div>
                </body>
                </html>
                """, resetLink, resetLink);

        sendEmail(toEmail, subject, htmlContent);
    }
}
