package com.drumstore.web.controllers.homepage;

import com.drumstore.web.dto.UserDTO;
import com.drumstore.web.dto.VoucherDTO;
import com.drumstore.web.models.CartContext;
import com.drumstore.web.services.CartService;
import com.drumstore.web.services.VoucherService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/voucher")
public class VoucherController extends HttpServlet {
    private VoucherService voucherService;
    private Gson gson;
    private CartService cartService;

    @Override
    public void init() throws ServletException {
        voucherService = new VoucherService();
        gson = new Gson();
        cartService = new CartService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            UserDTO user = (UserDTO) req.getSession().getAttribute("user");
            CartContext cart = (CartContext) req.getSession().getAttribute("cart");

            if (cart == null) {
                cart =  cartService.getCartContext(user.getId());
                req.getSession().setAttribute("cart", cart);
            }

            String action = req.getParameter("action");

            switch (action) {
                case "add" -> {
                    String code = req.getParameter("code");
                    if (code == null || code.trim().isEmpty()) {
                        Map<String, Object> error = new HashMap<>();
                        error.put("success", false);
                        error.put("message", "Mã voucher không được để trống!");
                        resp.getWriter().write(gson.toJson(error));
                        return;
                    }

                    Map<String, Object> result = voucherService.applyVoucher(user.getId(), code, cart.getTotal());
                    if ("success".equals(result.get("status"))) {
                        cart.setVoucher((VoucherDTO) result.get("voucher"));

                        Map<String, Object> success = new HashMap<>();
                        success.put("success", true);
                        success.put("message", "Áp dụng mã voucher thành công!");
                        success.put("discount", result.get("discount"));
                        success.put("total", cart.getTotal());
                        success.put("voucher", result.get("voucher"));
                        resp.getWriter().write(gson.toJson(success));
                    } else {
                        Map<String, Object> error = new HashMap<>();
                        error.put("success", false);
                        error.put("message", result.get("message"));
                        resp.getWriter().write(gson.toJson(error));
                    }
                }
                case "remove" -> {
                    int voucherId = Integer.parseInt(req.getParameter("voucherId"));
                    if (voucherId == cart.getVoucher().getId()) {
                        cart.setVoucher(null);
                        req.getSession().setAttribute("cart", cart);

                        Map<String, Object> success = new HashMap<>();
                        success.put("success", true);
                        success.put("total", cart.getTotal());
                        success.put("message", "Đã xóa mã voucher thành công!");
                        resp.getWriter().write(gson.toJson(success));
                    }

                }
                default -> {
                    Map<String, Object> error = new HashMap<>();
                    error.put("success", false);
                    error.put("message", "Hành động không hợp lệ!");
                    resp.getWriter().write(gson.toJson(error));
                }
            }
        } catch (Exception e) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "Lỗi hệ thống: " + e.getMessage());
            resp.getWriter().write(gson.toJson(error));
        }
    }
}