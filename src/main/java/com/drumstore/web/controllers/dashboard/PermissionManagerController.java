package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.dto.PermissionDTO;
import com.drumstore.web.repositories.PermissionRepository;
import com.drumstore.web.utils.ForceLogoutCache;
import com.drumstore.web.utils.OperationResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/permissions/*")
public class PermissionManagerController extends HttpServlet {
    private final PermissionRepository permissionRepository = new PermissionRepository();

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
        List<PermissionDTO> permissions = permissionRepository.getAllPermissions();
        request.setAttribute("permissions", permissions);
        request.setAttribute("title", "Quản lý quyền");
        request.setAttribute("content", "permissions/index.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("title", "Tạo quyền mới");
        request.setAttribute("content", "permissions/create.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            PermissionDTO permission = permissionRepository.getPermissionById(id);
            if (permission != null) {
                request.setAttribute("permission", permission);
                request.setAttribute("title", "Chỉnh sửa quyền");
                request.setAttribute("content", "permissions/edit.jsp");
                request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/dashboard/permissions");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/dashboard/permissions");
            return;
        }

        switch (action) {
            case "store" -> store(request, response);
            case "update" -> update(request, response);
            case "delete" -> delete(request, response);
            default -> response.sendRedirect(request.getContextPath() + "/dashboard/permissions");
        }
    }

    private void store(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (name != null && !name.isEmpty()) {
            OperationResult<Void> result = permissionRepository.createPermission(name, description);
            if (result.isSuccess()) {
                response.sendRedirect(request.getContextPath() + "/dashboard/permissions?success=created");
                return;
            }

            request.setAttribute("error", result.getMessage());
        } else {
            request.setAttribute("error", "Tên quyền không được để trống.");
        }

        request.setAttribute("title", "Tạo quyền mới");
        request.setAttribute("content", "permissions/create.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }


    private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (idStr != null && !idStr.isEmpty() && name != null && !name.isEmpty()) {
            int id = Integer.parseInt(idStr);

            List<Integer> affectedUsers = permissionRepository.getUserIdsByPermissionId(id);

            OperationResult<Void> result = permissionRepository.updatePermission(id, name, description);
            if (result.isSuccess()) {
                for (Integer userId : affectedUsers) {
                    ForceLogoutCache.markForLogout(userId);
                }
                response.sendRedirect(request.getContextPath() + "/dashboard/permissions?success=updated");
                return;
            }

            request.setAttribute("error", result.getMessage());
            PermissionDTO permission = permissionRepository.getPermissionById(id);
            request.setAttribute("permission", permission);
            request.setAttribute("title", "Chỉnh sửa quyền");
            request.setAttribute("content", "permissions/edit.jsp");
            request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/dashboard/permissions?error=update_failed");
    }


    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("id");

        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);

            List<Integer> affectedUsers = permissionRepository.getUserIdsByPermissionId(id);

            OperationResult<Void> result = permissionRepository.deletePermission(id);
            if (result.isSuccess()) {
                for (Integer userId : affectedUsers) {
                    ForceLogoutCache.markForLogout(userId);
                }
                response.sendRedirect(request.getContextPath() + "/dashboard/permissions?success=deleted");
                return;
            }

            response.sendRedirect(request.getContextPath() + "/dashboard/permissions?error=" + result.getMessage());
            return;
        }

        response.sendRedirect(request.getContextPath() + "/dashboard/permissions?error=delete_failed");
    }

}
