package com.drumstore.web.controllers.homepage;

import com.drumstore.web.services.VnPayService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/payment")
public class PaymentController extends HttpServlet {
    private VnPayService vnPayService;

    @Override
    public void init() throws ServletException {
        vnPayService = new VnPayService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        Map<String, Object> response = new HashMap<>();

        try {
            long amount = (long) (Double.parseDouble(req.getParameter("amount")) * 100);
            String orderId = req.getParameter("orderId");

            String paymentUrl = vnPayService.createPaymentUrl(amount, req);
            req.getSession().setAttribute("orderId", orderId);

            response.put("success", true);
            response.put("paymentUrl", paymentUrl);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi khi tạo URL thanh toán.");
        }

//        ObjectMapper objectMapper = new ObjectMapper();
//        resp.getWriter().write(objectMapper.writeValueAsString(response));
    }
}
