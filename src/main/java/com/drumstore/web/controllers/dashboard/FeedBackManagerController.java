package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.api.BaseApiController;
import com.drumstore.web.services.ProductReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/dashboard/feedbacks")
public class FeedBackManagerController extends BaseApiController {
    private final ProductReviewService productReviewService = new ProductReviewService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("title", "Quản lý Feedback");
        req.setAttribute("content", "feed-backs/index.jsp");
        req.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        boolean success = false;
        String message = "";

        try {
            switch (action) {
                case "updateStatus":
                    int feedbackId = Integer.parseInt(req.getParameter("feedbackId"));
                    int newStatus = Integer.parseInt(req.getParameter("status"));
                    success = productReviewService.updateStatus(feedbackId, newStatus);
                    message = success ? "Cập nhật trạng thái thành công" : "Cập nhật trạng thái thất bại";
                    break;
                case "delete":
                    int idToDelete = Integer.parseInt(req.getParameter("feedbackId"));
                    success = productReviewService.deleteReview(idToDelete);
                    message = success ? "Xóa đánh giá thành công" : "Xóa đánh giá thất bại";
                    break;
                default:
                    message = "Hành động không hợp lệ";
            }
        } catch (Exception e) {
            success = false;
            message = "Lỗi server: " + e.getMessage();
            e.printStackTrace();
        }

        Map<String, Object> result = new HashMap<>();
        result.put("status", success ? "success" : "error");
        result.put("message", message);

        sendResponse(resp, result);
    }


}
