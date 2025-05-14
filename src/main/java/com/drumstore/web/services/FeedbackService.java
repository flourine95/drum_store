package com.drumstore.web.services;


import com.drumstore.web.models.Feedback;
import com.drumstore.web.utils.MailUtils;

public class FeedbackService {
    private static final String FANPAGE_EMAIL = "fanpage@example.com";

    public void processFeedback(Feedback feedback) {
        // Gửi mail đến fanpage
        String subject = "Feedback mới từ khách hàng: " + feedback.getName();
        String content = "Tên: " + feedback.getName() + "\n"
                + "Email: " + feedback.getEmail() + "\n"
                + "Nội dung: " + feedback.getMessage();

        MailUtils.sendMail(FANPAGE_EMAIL, subject, content);

        // Gửi mail cảm ơn lại khách hàng
        String thankYouSubject = "Cảm ơn bạn đã gửi phản hồi!";
        String thankYouContent = "Chào " + feedback.getName() + ",\n\n"
                + "Chúng tôi rất cảm kích vì phản hồi của bạn. "
                + "Chúng tôi sẽ sớm liên hệ nếu cần.\n\n"
                + "Trân trọng,\nĐội ngũ hỗ trợ khách hàng.";

        MailUtils.sendMail(feedback.getEmail(), thankYouSubject, thankYouContent);
    }
}
