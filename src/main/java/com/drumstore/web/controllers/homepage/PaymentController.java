package com.drumstore.web.controllers.homepage;

import com.drumstore.web.services.VnPayService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/payment")
public class PaymentController extends HttpServlet {
    private VnPayService vnPayService;

    @Override
    public void init() throws ServletException {
        vnPayService = new VnPayService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        vnPayService.refund(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                long amount = Long.parseLong(req.getParameter("amount")) * 100L;
              String url =  vnPayService.createPaymentUrl(amount, req);
                System.out.println(url);
              resp.sendRedirect(url);
    }
}
