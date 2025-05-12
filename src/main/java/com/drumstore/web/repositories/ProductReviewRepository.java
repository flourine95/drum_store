package com.drumstore.web.repositories;

import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

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
}
