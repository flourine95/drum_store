package com.drumstore.web.controllers.homepage;

import com.drumstore.web.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet("/profile")
public class ProfileController extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        User user = (User) request.getSession().getAttribute("user");
//        if (user == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }

        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "addresses" -> {
                request.setAttribute("title", "Địa chỉ của tôi");
                request.setAttribute("profileContent", "profile-addresses.jsp");
                request.setAttribute("activePage", "addresses");
            }
            case "orders" -> {
                request.setAttribute("title", "Đơn hàng của tôi");
                request.setAttribute("profileContent", "profile-orders.jsp");
                request.setAttribute("activePage", "orders");
            }
            case "wishlist" -> {
                request.setAttribute("title", "Danh sách yêu thích");
                request.setAttribute("profileContent", "profile-wishlist.jsp");
                request.setAttribute("activePage", "wishlist");
            }
            default -> {
                request.setAttribute("title", "Tài khoản của tôi");
                request.setAttribute("profileContent", "index.jsp");
                request.setAttribute("activePage", "profile");
            }
        }
        request.setAttribute("content", "/pages/homepage/profile/profile-layout.jsp");
        request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

//        switch (action) {
//            case "update":
//                updateProfile(request, response, user);
//                break;
//            case "add_address":
//                addAddress(request, response, user);
//                break;
//            case "edit_address":
//                editAddress(request, response, user);
//                break;
//            case "delete_address":
//                deleteAddress(request, response, user);
//                break;
//            case "add_wishlist":
//                addWishlist(request, response, user);
//                break;
//            case "remove_wishlist":
//                removeWishlist(request, response, user);
//                break;
//            default:
//                response.sendRedirect("/profile");
//                break;
//        }
        request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);
    }


    @Override
    public void destroy() {
        super.destroy();
    }
}
