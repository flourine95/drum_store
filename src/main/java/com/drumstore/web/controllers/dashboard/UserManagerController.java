package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.models.User;
import com.drumstore.web.services.UserService;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/dashboard/users")
public class UserManagerController extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        Gson gson = new Gson();
        if (action == null) action = "list";
        switch (action) {
            case "list":
                request.getRequestDispatcher("/pages/dashboard/users/list.jsp").forward(request, response);
                break;
            case "create":
                request.getRequestDispatcher("/pages/dashboard/users/create.jsp").forward(request, response);
                break;
            case "show":
                int userId = Integer.parseInt(request.getParameter("userId"));
                User user = userService.show(userId);
                if (user != null) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    String jsonResponse = gson.toJson(user);
                    response.getWriter().write(jsonResponse);
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
                break;
            case "edit":
                String editUserId = request.getParameter("userId");
                User editUser = userService.find(Integer.parseInt(editUserId));
                if (editUser != null) {
                    request.setAttribute("user", editUser);
                    request.getRequestDispatcher("/pages/dashboard/users/edit.jsp").forward(request, response);
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
                break;
            case "ajaxList":
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(gson.toJson(userService.all()));
                break;
            default:
                response.sendRedirect("/dashboard/users?action=list");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "store":
                // Thêm người dùng mới
                User user = new User();
                user.setEmail(request.getParameter("email"));
                user.setFullname(request.getParameter("fullname"));
                user.setPassword(request.getParameter("password"));
                userService.createUser(user);
                response.sendRedirect("/dashboard/users?action=list");
                break;

            case "update":
                // Cập nhật thông tin người dùng
                String userId = request.getParameter("userId");
                User updatedUser = userService.find(Integer.parseInt(userId));
                if (updatedUser != null) {
                    updatedUser.setFullname(request.getParameter("fullname"));
                    updatedUser.setEmail(request.getParameter("email"));
                    userService.updateUser(updatedUser);
                    response.sendRedirect("/dashboard/users?action=list");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
                break;

            case "destroy":
                // Xóa người dùng
                String deleteUserId = request.getParameter("userId");
                userService.deleteUser(Integer.parseInt(deleteUserId));
                response.sendRedirect("/dashboard/users?action=list");
                break;

            default:
                response.sendRedirect("/dashboard/users?action=list");
                break;
        }
    }
}
