package com.drumstore.web.controllers.homepage;

import com.drumstore.web.dto.AddressDTO;
import com.drumstore.web.models.User;
import com.drumstore.web.services.AddressService;
import com.drumstore.web.services.OrderService;
import com.drumstore.web.services.UserService;
import com.drumstore.web.services.WishlistService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;


@WebServlet("/profile")
public class ProfileController extends HttpServlet {
    private UserService userService;
    private AddressService addressService;
    private WishlistService wishlistService;
    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        this.userService = new UserService();
        this.addressService = new AddressService();
        this.wishlistService = new WishlistService();
        this.orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "";
        int userId = user.getId();
        switch (action) {
            case "addresses" -> {
                List<AddressDTO> addresses = addressService.getAddressesByUserId(userId);
                request.setAttribute("addresses", addresses);
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
                user = userService.find(userId);
                request.setAttribute("user", user);
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

    private void handleProfileRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    private void setProfileAttributes(HttpServletRequest request, String title, String profileContent, String activePage) {
        request.setAttribute("title", title);
        request.setAttribute("profileContent", profileContent);
        request.setAttribute("activePage", activePage);
    }
}
