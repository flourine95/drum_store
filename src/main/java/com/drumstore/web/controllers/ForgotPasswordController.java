package com.drumstore.web.controllers;

import com.drumstore.web.services.ForgotPasswordService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/forgot-password2/*")
public class ForgotPasswordController extends HttpServlet {
    private final ForgotPasswordService passwordResetService;

    public ForgotPasswordController() {
        this.passwordResetService = new ForgotPasswordService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        
        if (token != null) {
            if (passwordResetService.validateResetToken(token)) {
                request.setAttribute("token", token);
                request.setAttribute("title", "Đặt lại mật khẩu");
                request.setAttribute("content", "reset-password.jsp");
                request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Invalid or expired reset token.");
                request.setAttribute("title", "Quên mật khẩu");
                request.setAttribute("content", "forgot-password.jsp");
                request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("title", "Quên mật khẩu");
            request.setAttribute("content", "forgot-password.jsp");
            request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("request".equals(action)) {
            handleForgotPasswordRequest(request, response);
        } else if ("reset".equals(action)) {
            handlePasswordReset(request, response);
        }
    }

    private void handleForgotPasswordRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        
        if (passwordResetService.requestPasswordReset(email)) {
            request.setAttribute("message", "Password reset instructions have been sent to your email.");
        } else {
            request.setAttribute("error", "Could not process password reset request. Please try again.");
        }

        request.setAttribute("title", "Quên mật khẩu");
        request.setAttribute("content", "forgot-password.jsp");
        request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);
    }

    private void handlePasswordReset(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        String newPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.setAttribute("token", token);
            request.setAttribute("title", "Đặt lại mật khẩu");
            request.setAttribute("content", "reset-password.jsp");
            request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);
            return;
        }

        if (passwordResetService.resetPassword(token, newPassword)) {
            request.setAttribute("message", "Password has been reset successfully. You can now login.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Could not reset password. Please try again.");
            request.setAttribute("token", token);
            request.setAttribute("title", "Đặt lại mật khẩu");
            request.setAttribute("content", "reset-password.jsp");
            request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);
        }
    }
} 