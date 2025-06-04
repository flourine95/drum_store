package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.dto.LogDTO;
import com.drumstore.web.services.LogService;
import com.drumstore.web.utils.ParseHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/histories/*")
public class HistoryManagerController extends HttpServlet {

    private final LogService logService = new LogService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            index(request, response);
            return;
        }

        switch (action) {
            case "edit" -> edit(request, response);
            case "delete" -> delete(request, response);
            default -> index(request, response);
        }
    }

    private void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<LogDTO> logs = logService.all();
        System.out.println("danh sách: " + logs);
        request.setAttribute("logs", logs);
        request.setAttribute("title", "Quản lý lịch sử hoạt động");
        request.setAttribute("content", "histories/index.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String logId = request.getParameter("id");

        if (logId == null || logId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/dashboard/histories");
            return;
        }

        try {
            Integer id = ParseHelper.tryParseInt(logId);
            LogDTO log = logService.findById(id);

            if (log == null) {
                response.sendRedirect(request.getContextPath() + "/dashboard/histories");
                return;
            }

            request.setAttribute("log", log);
            request.setAttribute("title", "Chỉnh sửa danh mục");
            request.setAttribute("content", "history/edit.jsp");
            request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/dashboard/histories");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String logId = request.getParameter("id");
        response.setContentType("application/json");

        try {
            Integer id = ParseHelper.tryParseInt(logId);
            if (id == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"message\": \"ID không hợp lệ\"}");
                return;
            }

            logService.delete(id); // Gọi đến LogService
            response.getWriter().write("{\"success\": true, \"message\": \"Xóa thành công\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            index(request, response);
            return;
        }
        switch (action) {
            case "delete" -> delete(request, response);
            default -> index(request, response);
        }
    }

}
