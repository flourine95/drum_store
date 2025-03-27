package com.drumstore.web.controllers.homepage;

import com.drumstore.web.dto.UserAddressDTO;
import com.drumstore.web.dto.UserDTO;
import com.drumstore.web.models.Cart;
import com.drumstore.web.models.User;
import com.drumstore.web.models.UserAddress;
import com.drumstore.web.services.OrderService;
import com.drumstore.web.services.UserAddressService;
import com.drumstore.web.services.VnPayService;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/order")
public class OrderController extends HttpServlet {
    private OrderService orderService;
    private Gson gson;
    private UserAddressService userAddressService;
    private VnPayService vnPayService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
        gson = new Gson();
        userAddressService = new UserAddressService();
        vnPayService = new VnPayService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cart cart = (Cart) req.getSession().getAttribute("cart");
        UserDTO user = (UserDTO) req.getSession().getAttribute("user");

        if (user == null || cart == null) {
            resp.sendRedirect("/login");
            return;
        }

        Map<String, List<UserAddressDTO>> map = userAddressService.getMainAddressAndSubAddress(user.getId());

        req.setAttribute("title", "Thanh toán");
        req.setAttribute("cart", cart);
        req.setAttribute("address", map);
        req.setAttribute("total", cart.getTotal() - cart.getDiscountTotal());
        req.setAttribute("content", "order.jsp");
        req.getRequestDispatcher("/pages/homepage/layout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, String> result = new HashMap<>();

        try {
            Cart cart = (Cart) req.getSession().getAttribute("cart");
            UserDTO user = (UserDTO) req.getSession().getAttribute("user");

            if (user == null || cart == null) {
                result.put("success", "false");
                result.put("message", "Người dùng hoặc giỏ hàng không hợp lệ. Vui lòng đăng nhập lại.");
                sendResponse(resp, result);
                return;
            }

            double amount;
            int userAddressId;
            String action;

            try {
                amount = Double.parseDouble(req.getParameter("amount"));
                userAddressId = Integer.parseInt(req.getParameter("userAddressId"));
                action = req.getParameter("action");
            } catch (NumberFormatException e) {
                result.put("success", "false");
                result.put("message", "Dữ liệu đầu vào không hợp lệ (amount hoặc userAddressId).");
                sendResponse(resp, result);
                return;
            }

            if (action == null || action.isEmpty()) {
                result.put("success", "false");
                result.put("message", "Phương thức thanh toán không được chỉ định.");
                sendResponse(resp, result);
                return;
            }

            switch (action) {
                case "cod" -> {
                    result = orderService.orderWithCod(user.getId(), amount, userAddressId, cart);
                    if ("true".equals(result.get("success"))) {
                        req.getSession().setAttribute("cart", new Cart());
                    }else {
                        result.put("success", "false");
                    }
                }

                case "payment" -> {
                    Map<String, String> orderResult = orderService.orderWithVNPay(user.getId(), amount, userAddressId, cart);
                    if ("true".equals(orderResult.get("success"))) {
                        req.getSession().setAttribute("cart", new Cart());
                        long vnpayAmount = (long) (amount * 100L);
                        String paymentUrl = vnPayService.createPaymentUrl(vnpayAmount, req);
                        if (paymentUrl != null && !paymentUrl.isEmpty()) {
                            result.put("success", "true");
                            result.put("orderId", orderResult.get("orderId"));
                            result.put("paymentUrl", paymentUrl);
                        } else {
                            result.put("success", "false");
                            result.put("message", "Không thể tạo URL thanh toán VNPay");
                        }
                    } else {
                        result.put("success", "false");
                        result.put("message", orderResult.get("message"));
                    }
                }

                default -> {
                    result.put("success", "false");
                    result.put("message", "Phương thức thanh toán không được hỗ trợ: " + action);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", "false");
            result.put("message", "Có lỗi xảy ra: " + e.getMessage());
        }

        sendResponse(resp, result);
    }

    private void sendResponse(HttpServletResponse resp, Map<String, String> result) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(gson.toJson(result));
    }
}