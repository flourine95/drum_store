package com.drumstore.web.repositories;

import com.drumstore.web.models.OrderItem;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

public class OrderItemRepository extends BaseRepository<OrderItem> {
    private final Jdbi jdbi;

    public OrderItemRepository() {
        this.jdbi = DBConnection.getJdbi();
    }

    public OrderItem save(Handle handle, OrderItem orderItem) {
        String insertQuery = "INSERT INTO order_items (orderId, variantId, quantity, basePrice, finalPrice, createdAt) " +
                "VALUES (:orderId, :variantId, :quantity, :basePrice, :finalPrice, :createdAt)";
        int orderItemId =
                handle.createUpdate(insertQuery)
                        .bindBean(orderItem)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(int.class)
                        .one();
        orderItem.setId(orderItemId);
        return orderItem;
    }
}
