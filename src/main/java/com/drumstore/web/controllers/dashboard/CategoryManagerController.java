package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.models.Category;
import com.drumstore.web.services.CategoryService;
import com.drumstore.web.utils.Utils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/categories/*")
public class CategoryManagerController extends ResourceController {
    private CategoryService categoryService;

    @Override
    public void init() {
        this.categoryService = new CategoryService();
    }

    @Override
    public void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryService.all();
        request.setAttribute("categories", categories);
        request.setAttribute("pageTitle", "Quản lí danh mục");
        request.setAttribute("content", "categories/index.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    @Override
    public void show(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {
        Category category = categoryService.findById(Integer.parseInt(id));
        request.setAttribute("category", category);
        request.setAttribute("pageTitle", "Xem chi tiết danh mục");
        request.setAttribute("content", "categories/show.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    @Override
    public void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "Thêm danh mục");
        request.setAttribute("content", "category/create.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    @Override
    public void store(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!Utils.validateCsrfToken(request, response)) return;

        try {
            Category newCategory = new Category();

            categoryService.create(newCategory);

            response.sendRedirect(request.getContextPath() + "/dashboard/categories");
        } catch (NumberFormatException | NullPointerException e) {
            request.setAttribute("error", "Dữ liệu đầu vào không hợp lệ.");
            create(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Cập nhật thất bại: " + e.getMessage());
            create(request, response);
        }
    }

    @Override
    public void edit(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {
        Category category = categoryService.findById(Integer.parseInt(id));
        request.setAttribute("category", category);
        request.setAttribute("pageTitle", "Chỉnh sửa danh mục");
        request.setAttribute("content", "categories/edit.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    @Override
    public void update(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {
        if (!Utils.validateCsrfToken(request, response)) return;

        try {
            Category category = categoryService.findbyId(Integer.parseInt(id));

            categoryService.update(category);

            response.sendRedirect(request.getContextPath() + "/dashboard/categories");
        } catch (NumberFormatException | NullPointerException e) {
            request.setAttribute("error", "Dữ liệu đầu vào không hợp lệ.");
            edit(request, response, id);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Cập nhật thất bại: " + e.getMessage());
            edit(request, response, id);
        }
    }

    @Override
    public void delete(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {
        if (!Utils.validateCsrfToken(request, response)) return;
        try {
            categoryService.delete(Integer.parseInt(id));

            response.sendRedirect(request.getContextPath() + "/dashboard/categories");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Xóa danh mục thất bại: " + e.getMessage());
            index(request, response);
        }
    }

    @Override
    public void indexNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType) throws ServletException, IOException {

    }

    @Override
    public void showNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws ServletException, IOException {

    }

    @Override
    public void createNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType) throws ServletException, IOException {

    }

    @Override
    public void storeNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType) throws ServletException, IOException {

    }

    @Override
    public void editNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws ServletException, IOException {

    }

    @Override
    public void updateNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws ServletException, IOException {

    }

    @Override
    public void deleteNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws ServletException, IOException {

    }
}
