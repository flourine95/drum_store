package com.drumstore.web.repositories;

import com.drumstore.web.constants.ReviewConstants;
import com.drumstore.web.dto.FeedBackDTO;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.ArrayList;
import java.util.List;

public class ProductReviewRepository {
    private final Jdbi jdbi;

    public ProductReviewRepository() {
        this.jdbi = DBConnection.getJdbi();
    }


    public boolean insertReview(int userId, int productId, int orderId, double rating, String content) {
        String sql = """
            INSERT INTO product_reviews (userId, productId, orderId, rating, content, status)
            VALUES (:userId, :productId, :orderId, :rating, :content,0)
        """;

        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("userId", userId)
                        .bind("productId", productId)
                        .bind("orderId", orderId)
                        .bind("rating", rating)
                        .bind("content", content)
                        .execute() == 1
        );
    }


    public boolean hasUserReviewed(int userId, int productId, int orderId) {
        String sql = """
            SELECT COUNT(*) FROM product_reviews 
            WHERE userId = :userId AND productId = :productId AND orderId = :orderId
        """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", userId)
                        .bind("productId", productId)
                        .bind("orderId", orderId)
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(0) > 0
        );
    }

    public List<FeedBackDTO> getAllReviews() {
        String sql = """
        SELECT 
            pr.id,
            u.fullName AS userName,
            pr.rating,
            pr.content,
            pr.status,
            p.name AS productName,
            (
                SELECT image 
                FROM product_images 
                WHERE productId = pr.productId AND main = 1 
                ORDER BY sortOrder ASC LIMIT 1
            ) AS imageUrl,
            pr.createdAt
        FROM product_reviews pr
        JOIN users u ON pr.userId = u.id
        JOIN products p ON pr.productId = p.id
        ORDER BY pr.createdAt ASC;
    """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .map((rs, ctx) -> {
                            FeedBackDTO dto = new FeedBackDTO();
                            dto.setId(rs.getInt("id"));
                            dto.setUserName(rs.getString("userName"));
                            dto.setRating(rs.getDouble("rating"));
                            dto.setContent(rs.getString("content"));
                            dto.setStatus((rs.getInt("status")));
                            dto.setProductName(rs.getString("productName"));
                            dto.setImageUrl(rs.getString("imageUrl"));
                            dto.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
                            return dto;
                        })
                        .list()
        );
    }


    public boolean deleteReview(int reviewId) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("DELETE FROM product_reviews WHERE id = :id")
                        .bind("id", reviewId)
                        .execute() > 0
        );
    }

    public boolean updateStatus(int feedbackId, int newStatus) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE product_reviews SET status = :status WHERE id = :id")
                        .bind("id", feedbackId)
                        .bind("status", newStatus)
                        .execute() > 0
        );
    }
}
