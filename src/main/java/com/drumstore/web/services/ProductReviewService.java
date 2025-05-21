package com.drumstore.web.services;

import com.drumstore.web.dto.FeedBackDTO;
import com.drumstore.web.repositories.ProductReviewRepository;

import java.util.List;

public class ProductReviewService {
    private final ProductReviewRepository productReviewRepository = new ProductReviewRepository();

    public boolean submitReview(int userId, int productId, int orderId, double rating, String comment) {
        // Kiểm tra người dùng đã đánh giá sản phẩm đó trong order đó chưa
        boolean alreadyReviewed = productReviewRepository.hasUserReviewed(userId, productId, orderId);
        if (alreadyReviewed) return false;

        return productReviewRepository.insertReview(userId, productId, orderId, rating, comment);
    }

    public List<FeedBackDTO> getAllReviewedProducts(){
        return productReviewRepository.getAllReviews();
    }

    public boolean deleteReview(int reviewId) {
        return productReviewRepository.deleteReview(reviewId);
    }

    public boolean updateStatus(int feedbackId, int newStatus) {
        return productReviewRepository.updateStatus(feedbackId,newStatus);
    }
}
