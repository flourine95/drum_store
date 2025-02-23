package com.drumstore.web.controllers.homepage;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/my-address")
public class MyAddressController extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("title", "Địa chỉ của tôi");
        request.setAttribute("content", "my-address.jsp");
        request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);
    }


    @Override
    public void destroy() {
        super.destroy();
    }
}
