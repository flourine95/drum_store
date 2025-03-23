package com.drumstore.web.controllers.auth;

import com.drumstore.web.dto.RegisterRequestDTO;
import com.drumstore.web.models.User;
import com.drumstore.web.services.UserService;
import com.drumstore.web.validators.RegisterValidator;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private final UserService userService = new UserService();
    private final RegisterValidator registerValidator = new RegisterValidator();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("title", "Đăng ký");
        request.setAttribute("content", "register.jsp");
        request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RegisterRequestDTO registerRequest = new RegisterRequestDTO(
                request.getParameter("fullname"),
                request.getParameter("phone"),
                request.getParameter("email"),
                request.getParameter("password")
        );

        Map<String, String> errors = registerValidator.validate(
                registerRequest.getFullname(),
                registerRequest.getPhone(),
                registerRequest.getEmail(),
                registerRequest.getPassword()
        );

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("title", "Đăng ký");
            request.setAttribute("content", "register.jsp");
            request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);
            return;
        }

        String hashedPassword = userService.hashPassword(registerRequest.getPassword());
        User user = new User(registerRequest.getFullname(), registerRequest.getPhone(), hashedPassword, registerRequest.getEmail());
        userService.register2(user);

        request.setAttribute("successMessage", "Đăng ký thành công! Bạn có thể đăng nhập ngay.");
        request.setAttribute("title", "Đăng nhập");
        request.setAttribute("content", "login.jsp");
        request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);
    }
}
