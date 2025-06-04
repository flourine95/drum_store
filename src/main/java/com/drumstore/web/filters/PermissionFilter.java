package com.drumstore.web.filters;

import com.drumstore.web.dto.UserDTO;
import com.drumstore.web.utils.FlashManager;
import com.drumstore.web.utils.ForceLogoutCache;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebFilter("/dashboard/*")
public class PermissionFilter implements Filter {
    private static final List<String> skipPermissionRoutes = List.of(
//            "/dashboard",
//            "/dashboard/role-permission"
    );

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession(false);

        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = uri.substring(contextPath.length());
        System.out.println("[PermissionFilter] URI: " + uri);
        System.out.println("[PermissionFilter] Path: " + path);
        if (skipPermissionRoutes.contains(path)) {
            System.out.println("[PermissionFilter] Skip permission check for: " + path);

            chain.doFilter(request, response);
            return;
        }
        UserDTO user = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        if (user == null) {
            System.out.println("[PermissionFilter] User not logged in. Redirecting to login.");

            session = request.getSession(true);
            session.setAttribute("redirectUrl", uri);
            response.sendRedirect(contextPath + "/login");
            return;
        }
        System.out.println("[PermissionFilter] Logged in user ID: " + user.getId());
        System.out.println("[PermissionFilter] User permissions: " + user.getPermissions());
        if (ForceLogoutCache.shouldLogout(user.getId())) {
            System.out.println("[PermissionFilter] User should be force logged out. Reason: ");

            session.invalidate();
            ForceLogoutCache.removeFromLogout(user.getId());
            FlashManager.store(request, "error", "Quyền hoặc vai trò của bạn đã thay đổi. Vui lòng đăng nhập lại.");
            response.sendRedirect(contextPath + "/login");
            return;
        }

        String[] parts = path.split("/");
        if (parts.length >= 3) {
            String module = parts[2];
            String action = request.getParameter("action");

            if (action == null || action.isEmpty()) {
                action = "index";
            }

            String permission = module + ":" + action;
            System.out.println("[PermissionFilter] Checking permission: " + permission);
            if (user.getPermissions() == null || !user.getPermissions().contains(permission)) {
                System.out.println("[PermissionFilter] Permission denied. Redirecting to /error?code=403");

                response.sendRedirect(contextPath + "/error?code=403");
                return;
            }
        }else {
            System.out.println("[PermissionFilter] No module/action found in path.");
        }
        System.out.println("[PermissionFilter] Permission granted. Proceeding...");

        chain.doFilter(request, response);
    }
}