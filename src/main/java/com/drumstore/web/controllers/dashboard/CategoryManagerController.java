package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.dto.CategoryDTO;
import com.drumstore.web.services.CategoryService;
import com.drumstore.web.utils.ParseHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/categories/*")
@MultipartConfig
public class CategoryManagerController extends HttpServlet {
    private static final String DASHBOARD_LAYOUT = "/pages/dashboard/layout.jsp";
    private static final String MODULE_PATH = "categories/";
    private static final String BASE_URL = "/dashboard/categories";

    private static final String TITLE_INDEX = "Quản lí danh mục";
    private static final String TITLE_CREATE = "Tạo mới danh mục";
    private static final String TITLE_EDIT = "Chỉnh sửa danh mục";

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

    private void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryId = request.getParameter("id");

        if (categoryId == null || categoryId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + BASE_URL);
            return;
        }

        try {
            Integer id = ParseHelper.tryParseInt(categoryId);
            CategoryDTO category = categoryService.findById(id);

            if (category == null) {
                response.sendRedirect(request.getContextPath() + BASE_URL);
                return;
            }

            request.setAttribute("category", category);
            request.setAttribute("title", TITLE_EDIT);
            request.setAttribute("content", MODULE_PATH + "edit.jsp");
            request.getRequestDispatcher(DASHBOARD_LAYOUT).forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + BASE_URL);
        }
    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("title", TITLE_CREATE);
        request.setAttribute("content", MODULE_PATH + "create.jsp");
        request.getRequestDispatcher(DASHBOARD_LAYOUT).forward(request, response);
    }

    private void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<CategoryDTO> categories = categoryService.allWithProductCount();

        long categoryWithProductCount = categories.stream()
                .filter(c -> c.getProductCount() > 0)
                .count();

        long categoryWithImageCount = categories.stream()
                .filter(c -> c.getImage() != null && !c.getImage().isBlank())
                .count();

        request.setAttribute("categoryWithProductCount", categoryWithProductCount);
        request.setAttribute("categoryWithImageCount", categoryWithImageCount);
        request.setAttribute("categories", categories);
        request.setAttribute("title", TITLE_INDEX);
        request.setAttribute("content", MODULE_PATH + "index.jsp");
        request.getRequestDispatcher(DASHBOARD_LAYOUT).forward(request, response);
    }


    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String categoryId = request.getParameter("id");

        if (categoryId == null || categoryId.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"ID danh mục không được cung cấp\"}");
            return;
        }

        try {
            Integer id = ParseHelper.tryParseInt(categoryId);

            CategoryDTO category = categoryService.findById(id);
            if (category == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"success\": false, \"message\": \"Không tìm thấy danh mục\"}");
                return;
            }

            boolean hasProducts = categoryService.hasAssociatedProducts(id);
            if (hasProducts) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"message\": \"Không thể xóa danh mục đang có sản phẩm liên kết\"}");
                return;
            }

            categoryService.delete(id);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Xóa danh mục thành công\"}");
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"ID danh mục không hợp lệ\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi khi xóa danh mục: " + e.getMessage() + "\"}");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String categoryId = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String image = request.getParameter("image");

        if (categoryId == null || categoryId.isEmpty() || name == null || name.isEmpty() || image == null || image.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"Thiếu thông tin cần thiết\"}");
            return;
        }

        try {
            Integer id = ParseHelper.tryParseInt(categoryId);

            CategoryDTO category = CategoryDTO.builder()
                    .id(id)
                    .name(name)
                    .description(description)
                    .image(image)
                    .build();

            categoryService.update(category);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Cập nhật danh mục thành công\", \"redirectUrl\": \"" +
                    request.getContextPath() + "/dashboard/categories\"}");
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"ID danh mục không hợp lệ\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Đã xảy ra lỗi khi cập nhật danh mục. Vui lòng thử lại sau.\"}");
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

        CategoryDTO category = CategoryDTO.builder()
                .name(name)
                .description(description)
                .image(image)
                .build();

        try {
            categoryService.create(category);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Tạo danh mục thành công\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi khi tạo danh mục: " + e.getMessage() + "\"}");
        }
    }

}
