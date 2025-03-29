package com.drumstore.web.services;

import com.drumstore.web.constants.PaymentConstants;
import com.drumstore.web.dto.OrderHistoryDTO;
import com.drumstore.web.dto.ProductVariantDTO;
import com.drumstore.web.models.*;
import com.drumstore.web.repositories.OrderItemRepository;
import com.drumstore.web.repositories.OrderRepository;
import com.drumstore.web.repositories.PaymentRepository;
import com.drumstore.web.repositories.ProductRepository;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderService {
    private final OrderRepository orderRepository = new OrderRepository();
    private final OrderItemRepository orderItemRepository = new OrderItemRepository();
    private final PaymentRepository paymentRepository = new PaymentRepository();
    private final ProductRepository productRepository = new ProductRepository();
    private final Jdbi jdbi = DBConnection.getJdbi();

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
        return orderRepository.deleteOrder(orderId);
    }

    //  Tạo đơn hàng
    public Order createOrder(Handle handle, int userId, double totalAmount, int userAddressId) {
        Order order = new Order();
        order.setUserId(userId);
        order.setUserAddressId(userAddressId);
        order.setTotalAmount((float) totalAmount);
        order.setOrderDate(new Timestamp(System.currentTimeMillis()));
        order.setStatus((byte) 0); // Pending
        order.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        return orderRepository.save(handle, order);
    }

    //  Kiểm tra & cập nhật stock
    public boolean updateStock(Handle handle, int variantId, int quantity) {
        ProductVariantDTO productVariantDTO = productRepository.findProductVariantById(variantId);

        if (productVariantDTO.getStock() < quantity) {
            return false;
        }
        return  productRepository.updateStock(handle, variantId, quantity) > 0;
    }

    //  Xử lý đơn hàng
    public void processOrder(Handle handle, int orderId, Cart cart) {
        for (CartItem cartItem : cart.getItems()) {
            int variantId = cartItem.getCartItem().getProductVariant().getId();
            int quantity = cartItem.getQuantity();

            // Kiểm tra và cập nhật stock ngay lập tức
            if (!updateStock(handle, variantId, quantity)) {
                throw new IllegalStateException("Sản phẩm ID " + variantId + " không đủ hàng để đặt hàng.");
            }

            OrderItem orderItem = new OrderItem();
            orderItem.setOrderId(orderId);
            orderItem.setVariantId(variantId);
            orderItem.setQuantity(quantity);
            orderItem.setBasePrice(cartItem.getCartItem().getBasePrice());
            orderItem.setFinalPrice(cartItem.getCartItem().getLowestSalePrice());
            orderItem.setCreatedAt(new Timestamp(System.currentTimeMillis()));

            orderItemRepository.save(handle, orderItem);
        }
    }

    //  Thanh toán COD
    public void paymentOrderWithCod(Handle handle, int orderId) {
        Payment payment = new Payment();
        payment.setOrderId(orderId);
        payment.setPaymentMethod(PaymentConstants.Method.COD.getValue());
        payment.setStatus(PaymentConstants.Status.PENDING.getValue());
        payment.setPaymentDate(new Timestamp(System.currentTimeMillis()));
        payment.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        paymentRepository.save(handle, payment);
    }

    //  Thanh toán VNPay
    public void paymentOrderWithVNPay(Handle handle, int orderId , double totalAmount) {
        Payment payment = new Payment();
        payment.setOrderId(orderId);
        payment.setPaymentMethod(PaymentConstants.Method.BANK_TRANSFER.getValue());
        payment.setStatus(PaymentConstants.Status.PENDING.getValue());
        payment.setAmount(totalAmount);
        payment.setPaymentDate(new Timestamp(System.currentTimeMillis()));
        payment.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        paymentRepository.save(handle, payment);
    }

    //  Đặt hàng với COD (Kiểm tra stock & rollback nếu thiếu hàng)
    public Map<String, Object> orderWithCod(int userId, double totalAmount, int userAddressId, Cart cart) {
        return jdbi.inTransaction(handle -> {
            Map<String, Object> response = new HashMap<>();
            try {
                Order order = createOrder(handle, userId, totalAmount, userAddressId);
                processOrder(handle, order.getId(), cart);
                paymentOrderWithCod(handle, order.getId());

                response.put("success", true);
                response.put("orderId", order.getId());
            } catch (IllegalStateException e) {
                handle.rollback();
                response.put("success", false);
                response.put("message", e.getMessage());
            } catch (Exception e) {
                response.put("success", false);
                response.put("message", "Không thể tạo đơn hàng. Vui lòng thử lại sau.");
                throw e;
            }
            return response;
        });
    }

    //  Đặt hàng với VNPay (Kiểm tra stock & rollback nếu thiếu hàng)
    public Map<String, Object> orderWithVNPay(int userId, double totalAmount, int userAddressId, Cart cart) {
        return jdbi.inTransaction(handle -> {
            Map<String, Object> response = new HashMap<>();
            try {
                Order order = createOrder(handle, userId, totalAmount, userAddressId);
                processOrder(handle, order.getId(), cart);
                paymentOrderWithVNPay(handle, order.getId(), totalAmount);

                response.put("success", true);
                response.put("orderId", order.getId());
            } catch (IllegalStateException e) {
                handle.rollback();
                response.put("success", false);
                response.put("message", e.getMessage());
            } catch (Exception e) {
                response.put("success", false);
                response.put("message", "Không thể tạo đơn hàng. Vui lòng thử lại sau.");
                throw e;
            }
            return response;
        });
    }

    // ✅ Lịch sử đặt hàng
    public List<OrderHistoryDTO> orderHistoryList(int userId) {
        return orderRepository.orderHistoryList(userId);
    }
}
