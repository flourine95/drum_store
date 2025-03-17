package com.drumstore.web.filters;

import com.drumstore.web.models.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/dashboard/*")
public class DashboardFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
//        if (session == null || session.getAttribute("user") == null) {
//            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
//        } else {
//            User user = (User) session.getAttribute("user");
//            if (!user.isAdmin()) {
//                httpResponse.sendRedirect(httpRequest.getContextPath() + "/home");
//                return;
//            }
//        }
        // bypass filter
        // bỏ qua đăng nhập
        chain.doFilter(request, response);
    }

}