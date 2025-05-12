package com.drumstore.web.controllers.homepage;

import com.drumstore.web.api.BaseApiController;
import com.drumstore.web.dto.UserDTO;
import com.drumstore.web.services.ProductReviewService;
import com.drumstore.web.services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/product/review")
public class ProductReviewController extends BaseApiController {
    private final ProductReviewService productReviewService = new ProductReviewService();
    private final ProductService productService = new ProductService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDTO user = (UserDTO) req.getSession().getAttribute("user");
        Map<String, Object> result = new HashMap<>();
        try {
            int variantId = Integer.parseInt(req.getParameter("productId"));
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            double rating = Double.parseDouble(req.getParameter("rating"));
            String comment = req.getParameter("comment");

            int productId = productService.findProductIdByVariantId(variantId);
            if (productId == 0) {
                result.put("success", false);
                result.put("message", "Không tìm thấy sản phẩm");
                sendResponse(resp, result);
                return;
            }

            boolean success = productReviewService.submitReview(user.getId(), productId, orderId, rating, comment);

            result.put("success", success);
            result.put("message", success ? "Đánh giá thành công" : "Bạn đã đánh giá sản phẩm rồi.");

        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "Dữ liệu đánh giá không hợp lệ.");
        }

        sendResponse(resp, result);
    }
}
