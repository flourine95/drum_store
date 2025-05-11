package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.models.Log;
import com.drumstore.web.services.LogService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/history/*")
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
//            case "create" -> create(request, response);
//            case "edit" -> edit(request, response);
            default -> index(request, response);
        }
    }

    private void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Log> logs = logService.all();
        System.out.println("danh sách: " +logs);
        request.setAttribute("logs", logs);
        request.setAttribute("title","Quản lý lịch sử hoạt động");
        request.setAttribute("content","history/index.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }
}
