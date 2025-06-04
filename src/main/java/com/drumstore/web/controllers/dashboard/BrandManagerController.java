package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.dto.BrandDTO;
import com.drumstore.web.services.BrandService;
import com.drumstore.web.utils.ParseHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/brands/*")
@MultipartConfig
public class BrandManagerController extends HttpServlet {
    private static final String DASHBOARD_LAYOUT = "/pages/dashboard/layout.jsp";
    private static final String MODULE_PATH = "brands/";
    private static final String BASE_URL = "/dashboard/brands";

    private static final String TITLE_INDEX = "Danh sách thương hiệu";
    private static final String TITLE_CREATE = "Tạo mới thương hiệu";
    private static final String TITLE_EDIT = "Chỉnh sửa thương hiệu";

    private final BrandService brandService = new BrandService();

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
        List<BrandDTO> brands = brandService.allWithProductCount();

        long brandWithProductCount = brands.stream()
                .filter(b -> b.getProductCount() > 0)
                .count();

        long brandWithImageCount = brands.stream()
                .filter(b -> b.getImage() != null && !b.getImage().isBlank())
                .count();

        request.setAttribute("brandWithProductCount", brandWithProductCount);
        request.setAttribute("brandWithImageCount", brandWithImageCount);
        request.setAttribute("brands", brands);
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
        String brandId = request.getParameter("id");

        if (brandId == null || brandId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + BASE_URL);
            return;
        }

        try {
            Integer id = ParseHelper.tryParseInt(brandId);
            BrandDTO brand = brandService.findById(id);

            if (brand == null) {
                response.sendRedirect(request.getContextPath() + BASE_URL);
                return;
            }

            request.setAttribute("brand", brand);
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
        String image = request.getParameter("image");

        if (name == null || name.isEmpty() || image == null || image.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"Tên và ảnh là bắt buộc\"}");
            return;
        }

        BrandDTO brand = BrandDTO.builder()
                .name(name)
                .description(description)
                .image(image)
                .build();

        try {
            brandService.create(brand);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Tạo thương hiệu thành công\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi khi tạo thương hiệu: " + e.getMessage() + "\"}");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String brandId = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String image = request.getParameter("image");

        if (brandId == null || brandId.isEmpty() || name == null || name.isEmpty() || image == null || image.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"Thiếu thông tin cần thiết\"}");
            return;
        }

        try {
            Integer id = ParseHelper.tryParseInt(brandId);

            BrandDTO brand = BrandDTO.builder()
                    .id(id)
                    .name(name)
                    .description(description)
                    .image(image)
                    .build();

            brandService.update(brand);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Cập nhật thương hiệu thành công\", \"redirectUrl\": \"" +
                    request.getContextPath() + BASE_URL + "\"}");
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"ID thương hiệu không hợp lệ\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi khi cập nhật thương hiệu: " + e.getMessage() + "\"}");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String brandId = request.getParameter("id");

        if (brandId == null || brandId.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"ID thương hiệu không được cung cấp\"}");
            return;
        }

        try {
            Integer id = ParseHelper.tryParseInt(brandId);

            BrandDTO brand = brandService.findById(id);
            if (brand == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"success\": false, \"message\": \"Không tìm thấy thương hiệu\"}");
                return;
            }

            if (brandService.hasAssociatedProducts(id)) {
                response.setStatus(HttpServletResponse.SC_CONFLICT);
                response.getWriter().write("{\"success\": false, \"message\": \"Không thể xóa thương hiệu vì đang có sản phẩm liên kết\"}");
                return;
            }

            brandService.delete(id);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Xóa thương hiệu thành công\"}");
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"ID không hợp lệ\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi khi xóa thương hiệu: " + e.getMessage() + "\"}");
        }
    }
}
