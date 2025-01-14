package com.drumstore.web.controllers.homepage;

import com.drumstore.web.models.Product;
import com.drumstore.web.services.BrandService;
import com.drumstore.web.services.CategoryService;
import com.drumstore.web.services.ProductService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductController extends HttpServlet {
    private ProductService productService;
    private CategoryService categoryService;
    private BrandService brandService;
    private static final int PRODUCTS_PER_PAGE = 9;

    @Override
    public void init() {
        this.productService = new ProductService();
        this.categoryService = new CategoryService();
        this.brandService = new BrandService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Lấy các tham số từ request
            int page = getPage(request);
            String searchKeyword = request.getParameter("search");
            String category = request.getParameter("category");
            String brand = request.getParameter("brand");
            String priceRange = request.getParameter("priceRange");
            String sortBy = request.getParameter("sortBy");

            // Tính toán phân trang
            int totalProducts = productService.countProducts(searchKeyword, category, brand, priceRange);
            int totalPages = (int) Math.ceil((double) totalProducts / PRODUCTS_PER_PAGE);

            // Lấy danh sách sản phẩm theo điều kiện lọc
            List<Product> products = productService.getProducts(
                    page,
                    PRODUCTS_PER_PAGE,
                    searchKeyword,
                    category,
                    brand,
                    priceRange,
                    sortBy
            );
            products.forEach(System.out::println);

            // Set attributes cho view
            request.setAttribute("products", products);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("searchKeyword", searchKeyword);
            request.setAttribute("selectedCategory", category);
            request.setAttribute("selectedBrand", brand);
            request.setAttribute("selectedPriceRange", priceRange);
            request.setAttribute("sortBy", sortBy);

            // Lấy danh sách categories và brands cho filter
            request.setAttribute("categories", categoryService.all());
            request.setAttribute("brands", brandService.all());

            request.setAttribute("title", "Danh sách sản phẩm");
            request.setAttribute("content", "products.jsp");
            request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private int getPage(HttpServletRequest request) {
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                return Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                return 1;
            }
        }
        return 1;
    }
}

