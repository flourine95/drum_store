package com.drumstore.web.services;

import com.drumstore.web.constants.PaymentConstants;
import com.drumstore.web.models.*;
import com.drumstore.web.repositories.OrderItemRepository;
import com.drumstore.web.repositories.OrderRepository;
import com.drumstore.web.repositories.PaymentRepository;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderService {
    private final OrderRepository orderRepository = new OrderRepository();
    private final OrderItemRepository orderItemRepository = new OrderItemRepository();
    private final PaymentRepository paymentRepository = new PaymentRepository();


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

    public Order createOrder(int userId, double totalAmount, int userAddressId) {
        Order order = new Order();
        order.setUserId(userId);
        order.setUserAddressId(userAddressId);
        order.setTotalAmount((float) totalAmount);
        order.setOrderDate(new Timestamp(System.currentTimeMillis()));
        order.setStatus((byte) 0); // Pending
        order.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        return orderRepository.save(order);
    }

    public void processOrder(int orderId, Cart cart) {
        for (CartItem cartItem : cart.getItems()) {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrderId(orderId);
            orderItem.setVariantId(cartItem.getCartItem().getProductVariant().getId());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setBasePrice(cartItem.getCartItem().getBasePrice());
            orderItem.setFinalPrice(cartItem.getCartItem().getLowestSalePrice());
            orderItem.setCreatedAt(new Timestamp(System.currentTimeMillis()));

            orderItemRepository.save(orderItem);
        }
    }

    public void paymentOrderWithCod(int orderId) {
        Payment payment = new Payment();
        payment.setOrderId(orderId);
        payment.setPaymentMethod(PaymentConstants.Method.COD.getValue());
        payment.setStatus(PaymentConstants.Status.PENDING.getValue());
        payment.setPaymentDate(new Timestamp(System.currentTimeMillis()));
        payment.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        paymentRepository.save(payment);
    }

    public void paymentOrderWithVNPay(int orderId) {
        Payment payment = new Payment();
        payment.setOrderId(orderId);
        payment.setPaymentMethod(PaymentConstants.Method.BANK_TRANSFER.getValue());
        payment.setStatus(PaymentConstants.Status.PENDING.getValue());
        payment.setPaymentDate(new Timestamp(System.currentTimeMillis()));
        payment.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        paymentRepository.save(payment);
    }

    public Map<String, String> orderWithCod(int userId, double totalAmount, int userAddressId, Cart cart) {
        Map<String, String> map = new HashMap<>();
        try {
            Order order = createOrder(userId, totalAmount, userAddressId);
            processOrder(order.getId(), cart);
            paymentOrderWithCod(order.getId());
            map.put("success", "true");
            map.put("orderId", String.valueOf(order.getId()));
        } catch (Exception e) {
            map.put("success", "false");
        }
        return map;
    }

    public Map<String, String> orderWithVNPay(int userId, double totalAmount, int userAddressId, Cart cart) {
        Map<String, String> map = new HashMap<>();
        try {
            Order order = createOrder(userId, totalAmount, userAddressId);
            processOrder(order.getId(), cart);
            paymentOrderWithVNPay(order.getId());
            map.put("success", "true");
        } catch (Exception e) {
            map.put("success", "false");
        }
        return map;
    }


}
