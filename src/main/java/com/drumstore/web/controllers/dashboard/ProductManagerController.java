package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.dto.ProductDashboardDetailDTO;
import com.drumstore.web.dto.ProductDashboardDTO;
import com.drumstore.web.services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/products/*")
public class ProductManagerController extends ResourceController {
    private final ProductService productService = new ProductService();

    @Override
    public void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ProductDashboardDTO> products = productService.all();
        setPageTitle("Quản lý sản phẩm");
        setViewData(products);
    }

    @Override
    public void show(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {
        ProductDashboardDetailDTO product = productService.find(Integer.parseInt(id));
        setPageTitle("Chi tiết sản phẩm");
        setViewPath("products/show.jsp");
        addViewAttribute("product", product);
    }

    @Override
    public void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    public void store(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    public void edit(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {

    }

    @Override
    public void update(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {

    }

    @Override
    public void delete(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {

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