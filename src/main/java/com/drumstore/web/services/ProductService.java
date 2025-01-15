package com.drumstore.web.services;

import com.drumstore.web.models.Product;
import com.drumstore.web.repositories.ProductRepository;

import java.util.List;

public class ProductService {
    private ProductRepository productRepository = new ProductRepository();

    public ProductService() {
    }

    public List<Product> all() {
        return productRepository.all();
    }

    public void create(Product product) {
        productRepository.save(product);
    }

    public void update(Product product) {
        productRepository.update(product);
    }

    public void delete(int id) {
        productRepository.delete(id);
    }

    public Product find(int id) {
        return productRepository.findById(id);
    }

    public Product show(int id) {
        return productRepository.show(id);
    }

    public Product findWithDetails(int id) {
        return productRepository.findWithDetails(id);
    }

    public List<Product> getFeaturedProducts(int limit) {
        return productRepository.getFeaturedProducts(limit);
    }

    public List<Product> getLatestProducts(int limit) {
        return productRepository.getLatestProducts(limit);
    }

    public List<Product> getProducts() {
        return productRepository.allWithDetails();
    }

    public List<Product> getProducts(int page, int limit, String search, String category, String brand, String priceRange, String sortBy) {
        int offset = (page - 1) * limit;
        return productRepository.getFilteredProducts(offset, limit, search, category, brand, priceRange, sortBy);
    }

    public int countProducts(String search, String category, String brand, String priceRange) {
        return productRepository.countFilteredProducts(search, category, brand, priceRange);
    }

    public List<Product> getRelatedProducts(int productId, int categoryId, int limit) {
        return productRepository.getRelatedProducts(productId, categoryId, limit);
    }
}
