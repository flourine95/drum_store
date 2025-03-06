package com.drumstore.web.services;

import com.drumstore.web.dto.ProductCardDTO;
import com.drumstore.web.models.Category;
import com.drumstore.web.models.Post;
import com.drumstore.web.models.Product;

import java.util.List;

public class HomeService {
    private final ProductService productService;
    private final CategoryService categoryService;
    private final PostService postService;

    public HomeService() {
        this.productService = new ProductService();
        this.categoryService = new CategoryService();
        this.postService = new PostService();
    }

    public List<Post> getLatestPosts(int limit) {
        return postService.getLatestPosts(limit);
    }

    public List<ProductCardDTO> getFeaturedProducts(int limit) {
        return productService.getFeaturedProducts(limit);
    }

    public List<Category> getCategories(int limit) {
        return categoryService.getCategories(limit);
    }

    public List<Product> getLatestProducts(int limit) {
        return productService.getLatestProducts(limit);
    }


    public List<Product> getProducts() {
        return productService.getProducts();
    }
}
