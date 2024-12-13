package com.drumstore.web.service;

import com.drumstore.web.model.Product;
import com.drumstore.web.repository.ProductRepository;

import java.util.List;

public class ProductService {
    private ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public List<Product> getAllProducts() {
        return productRepository.getAllProducts();
    }

    public Product getProductById(int id) {
        return productRepository.getProductById(id);
    }

    public void saveProduct(Product product) {
        productRepository.saveProduct(product);
    }

    public void updateProduct(Product product) {
        productRepository.updateProduct(product);
    }

    public void deleteProduct(int id) {
        productRepository.deleteProduct(id);
    }
}
