package com.drumstore.web.repositories;

import com.drumstore.web.models.Order;
import com.drumstore.web.models.OrderItem;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.util.LinkedHashMap;
import java.util.List;

public class OrderRepository {
    private final Jdbi jdbi;

    public OrderRepository() {
        this.jdbi = DBConnection.getJdbi();
    }

    public Order find(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM orders WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Order.class)
                        .findFirst()
                        .orElse(null)
        );
    }
}
