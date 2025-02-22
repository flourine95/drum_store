package com.drumstore.web.controllers.homepage;

import com.drumstore.web.models.Category;
import com.drumstore.web.models.Post;
import com.drumstore.web.models.Product;
import com.drumstore.web.services.HomeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/")
public class HomeController extends HttpServlet {
    private HomeService homeService;
    private static final int LIMIT = 6;

    @Override
    public void init() {
        this.homeService = new HomeService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> featuredProducts = homeService.getFeaturedProducts(LIMIT);
        List<Category> categories = homeService.getCategories(LIMIT);
        List<Post> latestPosts = homeService.getLatestPosts(LIMIT);
        request.setAttribute("featuredProducts", featuredProducts);
        request.setAttribute("categories", categories);
        request.setAttribute("latestPosts", latestPosts);

        request.setAttribute("title", "Trang chủ");
        request.setAttribute("content", "index.jsp");
        request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);
    }
}

