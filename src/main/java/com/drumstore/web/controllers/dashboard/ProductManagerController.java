package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.models.Product;
import com.drumstore.web.services.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/products/*")
public class ProductManagerController extends ResourceController  {
    private ProductService productService;

    @Override
    public void init() {
        this.productService = new ProductService();
    }

    @Override
    public void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = productService.all();
//        products.forEach(System.out::println);
        request.setAttribute("products", products);
        request.setAttribute("pageTitle", "Quản lí sản phẩm");
        request.setAttribute("content", "products/index.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    @Override
    public void show(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {
        Product product = productService.findWithDetails(Integer.parseInt(id));
        System.out.println(product);
        request.setAttribute("product", product);
        request.setAttribute("pageTitle", "Xem chi tiết sản phẩm");
        request.setAttribute("content", "products/show.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    @Override
    public void create(HttpServletRequest request, HttpServletResponse response) {

    }

    @Override
    public void store(HttpServletRequest request, HttpServletResponse response) {

    }

    @Override
    public void edit(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {
        Product product = productService.findWithDetails(Integer.parseInt(id));
        System.out.println(product);
        request.setAttribute("product", product);
        request.setAttribute("pageTitle", "Chỉnh sửa sản phẩm");
        request.setAttribute("content", "products/edit.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    @Override
    public void update(HttpServletRequest request, HttpServletResponse response, String id) {

    }

    @Override
    public void delete(HttpServletRequest request, HttpServletResponse response, String id) {

    }

    @Override
    public void indexNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType) {

    }

    @Override
    public void showNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) {

    }

    @Override
    public void createNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType) {

    }

    @Override
    public void storeNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType) {

    }

    @Override
    public void editNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws ServletException, IOException {

    }

    @Override
    public void updateNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws ServletException, IOException {

    }

    @Override
    public void deleteNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) {

    }
}