package com.drumstore.web.api;

import com.drumstore.web.dto.FeedBackDTO;
import com.drumstore.web.services.ProductReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/api/feedbacks"})
public class FeedBackApiController extends BaseApiController {
    private ProductReviewService productReviewService = new ProductReviewService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String pathInfo = req.getPathInfo();
            if (pathInfo == null || pathInfo.equals("/")) {
                List<FeedBackDTO> feedBacks = productReviewService.getAllReviewedProducts();
                sendResponse(resp, feedBacks);
            }
        } catch (Exception e) {
            sendError(resp, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}
