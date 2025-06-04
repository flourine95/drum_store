package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.dto.SaleDTO;
import com.drumstore.web.services.SaleService;
import com.drumstore.web.utils.ParseHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;

@WebServlet("/dashboard/sales/*")
public class SaleManagerController extends HttpServlet {
    private static final String DASHBOARD_LAYOUT = "/pages/dashboard/layout.jsp";
    private static final String MODULE_PATH = "sales/";
    private static final String BASE_URL = "/dashboard/sales";

    private static final String TITLE_INDEX = "Danh sách chương trình khuyến mãi";
    private static final String TITLE_CREATE = "Tạo mới chương trình khuyến mãi";
    private static final String TITLE_EDIT = "Chỉnh sửa chương trình khuyến mãi";

    private static final int ENDING_SOON_DAYS = 3;
    private final SaleService saleService = new SaleService();

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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            index(request, response);
            return;
        }

        switch (action) {
            case "store" -> store(request, response);
            case "update" -> update(request, response);
            case "delete" -> delete(request, response);
            default -> index(request, response);
        }
    }

    private void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<SaleDTO> sales = saleService.all();

        int salesCount = sales.size();

        Timestamp now = Timestamp.from(Instant.now());
        Timestamp soonThreshold = Timestamp.from(Instant.now().plus(ENDING_SOON_DAYS, ChronoUnit.DAYS));

        long activeCount = sales.stream()
                .filter(sale -> !sale.getStartDate().after(now) && !sale.getEndDate().before(now))
                .count();

        long endingSoonCount = sales.stream()
                .filter(sale -> sale.getEndDate().after(now) && !sale.getEndDate().after(soonThreshold))
                .count();

        long expiredCount = sales.stream()
                .filter(sale -> sale.getEndDate().before(now))
                .count();

        request.setAttribute("sales", sales);
        request.setAttribute("salesCount", salesCount);
        request.setAttribute("activeCount", activeCount);
        request.setAttribute("endingSoonCount", endingSoonCount);
        request.setAttribute("expiredCount", expiredCount);

        request.setAttribute("title", TITLE_INDEX);
        request.setAttribute("content", MODULE_PATH + "index.jsp");
        request.getRequestDispatcher(DASHBOARD_LAYOUT).forward(request, response);
    }


    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("title", TITLE_CREATE);
        request.setAttribute("content", MODULE_PATH + "create.jsp");
        request.getRequestDispatcher(DASHBOARD_LAYOUT).forward(request, response);
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String saleId = request.getParameter("id");

        if (saleId == null || saleId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + BASE_URL);
            return;
        }

        try {
            Integer id = ParseHelper.tryParseInt(saleId);
            SaleDTO sale = saleService.findById(id);

            if (sale == null) {
                response.sendRedirect(request.getContextPath() + BASE_URL);
                return;
            }
            
            // Format dates for form fields (yyyy-MM-dd)
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
            if (sale.getStartDate() != null) {
                String startDateStr = inputFormat.format(sale.getStartDate());
                request.setAttribute("startDateStr", startDateStr);
            }
            
            if (sale.getEndDate() != null) {
                String endDateStr = inputFormat.format(sale.getEndDate());
                request.setAttribute("endDateStr", endDateStr);
            }

            request.setAttribute("sale", sale);
            request.setAttribute("title", TITLE_EDIT);
            request.setAttribute("content", MODULE_PATH + "edit.jsp");
            request.getRequestDispatcher(DASHBOARD_LAYOUT).forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + BASE_URL);
        }
    }

    private void store(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String discountPercentage = request.getParameter("discountPercentage");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        if (name == null || name.isEmpty() || discountPercentage == null || discountPercentage.isEmpty() ||
            startDateStr == null || startDateStr.isEmpty() || endDateStr == null || endDateStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"Vui lòng điền đầy đủ thông tin\"}");
            return;
        }

        try {
            // Chuyển đổi chuỗi ngày thành Timestamp
            Timestamp startDate = convertStringToTimestamp(startDateStr);
            Timestamp endDate = convertStringToTimestamp(endDateStr);
            
            // Kiểm tra ngày kết thúc phải sau ngày bắt đầu
            if (endDate.before(startDate)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"message\": \"Ngày kết thúc phải sau ngày bắt đầu\"}");
                return;
            }

            SaleDTO sale = SaleDTO.builder()
                    .name(name)
                    .description(description)
                    .discountPercentage(discountPercentage)
                    .startDate(startDate)
                    .endDate(endDate)
                    .build();

            saleService.create(sale);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Tạo chương trình khuyến mãi thành công\", \"redirectUrl\": \"" +
                    request.getContextPath() + BASE_URL + "\"}");
        } catch (ParseException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"Định dạng ngày không hợp lệ\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi khi tạo chương trình khuyến mãi: " + e.getMessage() + "\"}");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String saleId = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String discountPercentage = request.getParameter("discountPercentage");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        if (saleId == null || saleId.isEmpty() || name == null || name.isEmpty() ||
            discountPercentage == null || discountPercentage.isEmpty() ||
            startDateStr == null || startDateStr.isEmpty() || endDateStr == null || endDateStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"Thiếu thông tin cần thiết\"}");
            return;
        }

        try {
            Integer id = ParseHelper.tryParseInt(saleId);
            
            // Chuyển đổi chuỗi ngày thành Timestamp
            Timestamp startDate = convertStringToTimestamp(startDateStr);
            Timestamp endDate = convertStringToTimestamp(endDateStr);
            
            // Kiểm tra ngày kết thúc phải sau ngày bắt đầu
            if (endDate.before(startDate)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"message\": \"Ngày kết thúc phải sau ngày bắt đầu\"}");
                return;
            }

            SaleDTO sale = SaleDTO.builder()
                    .id(id)
                    .name(name)
                    .description(description)
                    .discountPercentage(discountPercentage)
                    .startDate(startDate)
                    .endDate(endDate)
                    .build();

            saleService.update(sale);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Cập nhật chương trình khuyến mãi thành công\", \"redirectUrl\": \"" +
                    request.getContextPath() + BASE_URL + "\"}");
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"ID chương trình khuyến mãi không hợp lệ\"}");
        } catch (ParseException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"Định dạng ngày không hợp lệ\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi khi cập nhật chương trình khuyến mãi: " + e.getMessage() + "\"}");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String saleId = request.getParameter("id");

        if (saleId == null || saleId.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"ID chương trình khuyến mãi không được cung cấp\"}");
            return;
        }

        try {
            Integer id = ParseHelper.tryParseInt(saleId);
            saleService.delete(id);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Xóa chương trình khuyến mãi thành công\"}");
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"ID không hợp lệ\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi khi xóa chương trình khuyến mãi: " + e.getMessage() + "\"}");
        }
    }
    
    /**
     * Chuyển đổi chuỗi ngày định dạng yyyy-MM-dd thành Timestamp
     */
    private Timestamp convertStringToTimestamp(String dateStr) throws ParseException {
        LocalDate date = LocalDate.parse(dateStr);
        return Timestamp.valueOf(date.atStartOfDay());
    }
}
