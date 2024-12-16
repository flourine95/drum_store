package com.drumstore.web.services;

import com.drumstore.web.models.Product;
import com.drumstore.web.repositories.ProductColorRepository;
import com.drumstore.web.repositories.ProductImageRepository;
import com.drumstore.web.repositories.ProductRepository;

import java.util.List;

public class ProductService {
    private ProductRepository productRepository;
    private ProductImageRepository productImageRepository;
    private ProductColorRepository productColorRepository;


    public ProductService(ProductRepository productRepository,
                          ProductImageRepository productImageRepository,
                          ProductColorRepository productColorRepository) {
        this.productRepository = productRepository;
        this.productImageRepository = productImageRepository;
        this.productColorRepository = productColorRepository;
    }

    public List<Product> getProducts() {
        return productRepository.getProducts();
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

    public Product getProductDetails(int productId) {
        Product product = productRepository.getProductById(productId);
        if (product != null) {
            product.setImages(productImageRepository.getImagesForProduct(productId));
            product.setColors(productColorRepository.getColorsForProduct(productId));
        }
        return product;
    }
    public List<Product> getProductsFull() {
        List<Product> products = productRepository.getProducts();
        for (Product product : products) {
            product.setImages(productImageRepository.getImagesForProduct(product.getId()));
            product.setColors(productColorRepository.getColorsForProduct(product.getId()));
        }
        return products;
        
    }

}
