package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.dto.RoleDTO;
import com.drumstore.web.repositories.RoleRepository;
import com.drumstore.web.utils.ForceLogoutCache;
import com.drumstore.web.utils.OperationResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/roles/*")
public class RoleManagerController extends HttpServlet {
    private final RoleRepository roleRepository = new RoleRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            index(request, response);
            return;
        }

        switch (action) {
            case "create" -> create(request, response);
            case "edit" -> edit(request, response);
            default -> index(request, response);
        }
    }

    private void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<RoleDTO> roles = roleRepository.getAllRoles();
        request.setAttribute("title", "Quản lý vai trò");
        request.setAttribute("content", "roles/index.jsp");
        request.setAttribute("roles", roles);
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("title", "Tạo vai trò mới");
        request.setAttribute("content", "roles/create.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            RoleDTO role = roleRepository.getRoleById(id);
            if (role != null) {
                request.setAttribute("role", role);
                request.setAttribute("title", "Chỉnh sửa vai trò");
                request.setAttribute("content", "roles/edit.jsp");
                request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/dashboard/roles");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/dashboard/roles");
            return;
        }

        switch (action) {
            case "store" -> store(request, response);
            case "update" -> update(request, response);
            case "delete" -> delete(request, response);
            default -> response.sendRedirect(request.getContextPath() + "/dashboard/roles");
        }
    }

    private void store(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (name != null && !name.isEmpty()) {
            OperationResult<Void> success = roleRepository.createRole(name, description);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/dashboard/roles?success=created");
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/dashboard/roles?error=create_failed");
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (idStr != null && !idStr.isEmpty() && name != null && !name.isEmpty()) {
            int id = Integer.parseInt(idStr);
            boolean success = roleRepository.updateRole(id, name);
            if (success) {
                // Force logout users with this role
                List<Integer> affectedUsers = roleRepository.getUserIdsByRoleId(id);
                for (Integer userId : affectedUsers) {
                    ForceLogoutCache.markForLogout(userId);
                }
                response.sendRedirect(request.getContextPath() + "/dashboard/roles?success=updated");
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/dashboard/roles?error=update_failed");
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("id");

        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            // Get affected users before deletion
            List<Integer> affectedUsers = roleRepository.getUserIdsByRoleId(id);

            boolean success = roleRepository.deleteRole(id);
            if (success) {
                // Force logout affected users
                for (Integer userId : affectedUsers) {
                    ForceLogoutCache.markForLogout(userId);
                }
                response.sendRedirect(request.getContextPath() + "/dashboard/roles?success=deleted");
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/dashboard/roles?error=delete_failed");
    }

}
