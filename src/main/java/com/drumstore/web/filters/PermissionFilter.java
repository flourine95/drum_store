package com.drumstore.web.filters;

import com.drumstore.web.dto.UserDTO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

@WebFilter("/dashboard/*")
public class PermissionFilter implements Filter {
    
    // Các URL không cần kiểm tra quyền
    private static final Pattern[] EXCLUDED_URLS = {
        Pattern.compile("^/dashboard/profile/?$"),
        Pattern.compile("^/dashboard/notifications/?$"),
        Pattern.compile("^/dashboard/?$")
    };

    // Map các action đặc biệt sang permission action
    private static final Map<String, String> ACTION_MAPPING = new HashMap<>();
    static {
        ACTION_MAPPING.put("", "list");     // URL kết thúc bằng /
        ACTION_MAPPING.put("edit", "update");
        ACTION_MAPPING.put("view", "view");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String requestURI = httpRequest.getRequestURI();

        // Kiểm tra session
        HttpSession session = httpRequest.getSession(false);
        if (!isAuthenticated(session)) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        // Kiểm tra URL loại trừ
        if (isExcludedUrl(requestURI)) {
            chain.doFilter(request, response);
            return;
        }

        UserDTO user = (UserDTO) session.getAttribute("user");

        // Kiểm tra roles
        if (!hasValidRole(user)) {
            httpResponse.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "Bạn không có quyền truy cập vào trang quản trị!"
            );
            return;
        }

        // Parse permission từ URL
        String permission = parsePermissionFromUrl(requestURI);
        if (permission != null && !user.hasPermission(permission)) {
            httpResponse.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "Bạn không có quyền thực hiện thao tác này!"
            );
            return;
        }

        chain.doFilter(request, response);
    }

    private String parsePermissionFromUrl(String requestURI) {
        // Bỏ /dashboard/ từ đầu URL
        String path = requestURI.replaceFirst("^/dashboard/", "");
        String[] parts = path.split("/");
        if (parts.length == 0) return null;

        // Module là phần tử đầu tiên (products, orders, etc.)
        String module = parts[0];
        
        // Action mặc định là phần tử thứ hai, nếu không có thì là "list"
        String action = parts.length > 1 ? parts[1] : "";
        
        // Kiểm tra xem action có cần map không
        action = ACTION_MAPPING.getOrDefault(action, action);

        // Nếu action chứa số (VD: edit/123), lấy action
        if (action.matches("\\d+")) {
            action = "view";
        }

        // Tạo permission string theo format module:action
        return String.format("%s:%s", module.toLowerCase(), action.toLowerCase());
    }

    private boolean isAuthenticated(HttpSession session) {
        return session != null && session.getAttribute("user") != null;
    }

    private boolean hasValidRole(UserDTO user) {
        return user.getRoles() != null && !user.getRoles().isEmpty();
    }

    private boolean isExcludedUrl(String requestURI) {
        for (Pattern pattern : EXCLUDED_URLS) {
            if (pattern.matcher(requestURI).matches()) {
                return true;
            }
        }
        return false;
    }
}