package com.drumstore.web.api;

import com.drumstore.web.dto.MonthlyRevenueDTO;
import com.drumstore.web.services.AnalyticsService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/api/analytics/*")
public class AnalyticsApiController extends BaseApiController {
    private final AnalyticsService analyticsService = new AnalyticsService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String pathInfo = request.getPathInfo();
            if (pathInfo == null || pathInfo.equals("/")) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Please specify an analytics endpoint.");
                return;
            }

            switch (pathInfo) {
                case "/monthly-revenue":
                    int year = Integer.parseInt(request.getParameter("year") != null ? request.getParameter("year") : "2024");
                    List<MonthlyRevenueDTO> monthlyRevenue = analyticsService.getMonthlyRevenueAndProfit(year);
                    sendResponse(response, monthlyRevenue);
                    break;

                case "/customer-stats":
                    Map<String, Object> customerStats = analyticsService.getCustomerStats();
                    sendResponse(response, customerStats);
                    break;

                case "/revenue-stats":
                    Map<String, Object> revenueStats = analyticsService.getRevenueStats();
                    sendResponse(response, revenueStats);
                    break;

                case "/order-stats":
                    Map<String, Object> orderStats = analyticsService.getOrderStats();
                    sendResponse(response, orderStats);
                    break;

                case "/growth-stats":
                    Map<String, Object> growthStats = analyticsService.getGrowthStats();
                    sendResponse(response, growthStats);
                    break;

                default:
                    sendError(response, HttpServletResponse.SC_NOT_FOUND, "Endpoint not found.");
                    break;
            }
        } catch (Exception e) {
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}
