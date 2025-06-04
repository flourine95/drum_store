package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.dto.BrandDTO;
import com.drumstore.web.dto.CategoryDTO;
import com.drumstore.web.dto.ProductSaleDTO;
import com.drumstore.web.services.BrandService;
import com.drumstore.web.services.CategoryService;
import com.drumstore.web.services.ProductSaleService;
import com.drumstore.web.utils.ParseHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/product-sales/*")
public class ProductSaleManagerController extends HttpServlet {
    private static final String DASHBOARD_LAYOUT = "/pages/dashboard/layout.jsp";
    private static final String MODULE_PATH = "product-sales/";
    private static final String BASE_URL = "/dashboard/product-sales";

    private static final String TITLE_INDEX = "Danh sách giảm giá sản phẩm";
    private static final String TITLE_CREATE = "Tạo mới giảm giá sản phẩm";
    private static final String TITLE_EDIT = "Chỉnh sửa giảm giá sản phẩm";

    private final ProductSaleService productSaleService = new ProductSaleService();
    private final BrandService brandService = new BrandService();
    private final CategoryService categoryService = new CategoryService();

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
        // Get filter parameters
        String search = request.getParameter("search");
        String brandId = request.getParameter("brand");
        String categoryId = request.getParameter("category");
        String status = request.getParameter("status");

        // Get page parameters
        Integer pageParam = ParseHelper.tryParseInt(request.getParameter("page"));
        int page = (pageParam != null && pageParam > 0) ? pageParam : 1;
        int limit = 10;
        
        // Get filtered products
        List<ProductSaleDTO> products = productSaleService.getFilteredProducts(search, brandId, categoryId, status, page, limit);
        int totalProducts = productSaleService.getTotalFilteredProducts(search, brandId, categoryId, status);
        int totalPages = (int) Math.ceil((double) totalProducts / limit);
        
        // Get brands and categories for filter dropdowns
        List<BrandDTO> brands = brandService.all();
        List<CategoryDTO> categories = categoryService.all();

        request.setAttribute("products", products);
        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);
        request.setAttribute("search", search);
        request.setAttribute("brandFilter", brandId);
        request.setAttribute("categoryFilter", categoryId);
        request.setAttribute("statusFilter", status);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("title", TITLE_INDEX);
        request.setAttribute("content", MODULE_PATH + "index.jsp");
        request.getRequestDispatcher(DASHBOARD_LAYOUT).forward(request, response);
    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<BrandDTO> brands = brandService.all();
        List<CategoryDTO> categories = categoryService.all();
        
        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);
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
            ProductSaleDTO sale = productSaleService.findById(id);
            
            if (sale == null) {
                response.sendRedirect(request.getContextPath() + BASE_URL);
                return;
            }
            
            List<BrandDTO> brands = brandService.all();
            List<CategoryDTO> categories = categoryService.all();
            
            request.setAttribute("sale", sale);
            request.setAttribute("brands", brands);
            request.setAttribute("categories", categories);
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

        try {
            Integer productId = ParseHelper.tryParseInt(request.getParameter("productId"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            Double discountPercentage = ParseHelper.tryParseDouble(request.getParameter("discountPercentage"));
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");

            if (productId == null || name == null || discountPercentage == null || 
                startDate == null || endDate == null) {
                throw new IllegalArgumentException("Thiếu thông tin cần thiết");
            }

            productSaleService.create(productId, name, description, discountPercentage, startDate, endDate);
            
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Tạo giảm giá thành công\"}");
        } catch (IllegalArgumentException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi khi tạo giảm giá: " + e.getMessage() + "\"}");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            Integer saleId = ParseHelper.tryParseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            Double discountPercentage = ParseHelper.tryParseDouble(request.getParameter("discountPercentage"));
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");

            if (saleId == null || name == null || discountPercentage == null || 
                startDate == null || endDate == null) {
                throw new IllegalArgumentException("Thiếu thông tin cần thiết");
            }

            productSaleService.update(saleId, name, description, discountPercentage, startDate, endDate);
            
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Cập nhật giảm giá thành công\"}");
        } catch (IllegalArgumentException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi khi cập nhật giảm giá: " + e.getMessage() + "\"}");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            Integer saleId = ParseHelper.tryParseInt(request.getParameter("id"));
            
            if (saleId == null) {
                throw new IllegalArgumentException("ID giảm giá không được cung cấp");
            }

            productSaleService.delete(saleId);
            
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Xóa giảm giá thành công\"}");
        } catch (IllegalArgumentException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi khi xóa giảm giá: " + e.getMessage() + "\"}");
        }
    }
}
