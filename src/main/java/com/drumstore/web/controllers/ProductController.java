package com.drumstore.web.controllers;


import com.drumstore.web.models.Product;
import com.drumstore.web.repositories.ProductColorRepository;
import com.drumstore.web.repositories.ProductImageRepository;
import com.drumstore.web.services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductController extends HttpServlet {
    private ProductService productService;

    public ProductController() {
        ProductColorRepository productColorRepository = new ProductColorRepository();
        ProductImageRepository productImageRepository = new ProductImageRepository();
        this.productService = new ProductService(productImageRepository, productColorRepository);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                List<Product> products = productService.all();
                req.setAttribute("products", products);
                req.getRequestDispatcher("/pages/dashboard/products/index.jsp").forward(req, resp);
                break;

            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                Product product = productService.find(id);
                req.setAttribute("product", product);
                req.getRequestDispatcher("/pages/dashboard/products/edit.jsp").forward(req, resp);
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/products?action=list");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");

        switch (action) {
            case "save":
                String name = req.getParameter("name");
                String description = req.getParameter("description");
                double price = Double.parseDouble(req.getParameter("price"));

                Product product = new Product();
                productService.create(product);
                break;

            case "delete":
                int id = Integer.parseInt(req.getParameter("id"));
                productService.delete(id);
                break;

            case "update":
                int updateId = Integer.parseInt(req.getParameter("id"));
                String updateName = req.getParameter("name");
                String updateDescription = req.getParameter("description");
                double updatePrice = Double.parseDouble(req.getParameter("price"));

                Product updateProduct = new Product();
                productService.update(updateProduct);
                break;
        }
        resp.sendRedirect(req.getContextPath() + "/products?action=list");
    }
}

