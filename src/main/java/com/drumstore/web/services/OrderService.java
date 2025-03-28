package com.drumstore.web.services;

import com.drumstore.web.models.Order;
import com.drumstore.web.repositories.OrderRepository;

import java.util.List;

public class OrderService {
    private final OrderRepository orderRepository = new OrderRepository();

    public List<Order> all() {
        return orderRepository.all();
    }


    public Order find(int id) {
        return orderRepository.find(id);
    }

    public Order findWithDetails(int id) {
        return orderRepository.findWithDetails(id);
    }

    public boolean deleteOrder(int orderId) {
        return orderRepository.deleteOrder(orderId);  // Gọi phương thức xóa trong Repository
    }


}
