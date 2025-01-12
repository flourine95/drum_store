package com.drumstore.web.services;

import com.drumstore.web.models.Product;
import com.drumstore.web.repositories.ProductColorRepository;
import com.drumstore.web.repositories.ProductImageRepository;
import com.drumstore.web.repositories.ProductRepository;

import java.util.List;

public class ProductService {
    private ProductRepository productRepository = new ProductRepository();
    private ProductImageRepository productImageRepository;
    private ProductColorRepository productColorRepository;

    public ProductService(ProductImageRepository productImageRepository,
                          ProductColorRepository productColorRepository) {
        this.productRepository = new ProductRepository();
        this.productImageRepository = productImageRepository;
        this.productColorRepository = productColorRepository;
    }

    public ProductService() {
    }

    public List<Product> all() {
        return productRepository.all();
    }

    public void createProduct(Product product) {
        productRepository.save(product);
    }

    public void updateProduct(Product product) {
        productRepository.update(product);
    }

    public void deleteProduct(int id) {
        productRepository.delete(id);
    }

    public Product find(int id) {
        return productRepository.findById(id);
    }

    public Product show(int id) {
        return productRepository.show(id);
    }

    public Product getProductDetails(int productId) {
        Product product = productRepository.findById(productId);
        if (product != null) {
            product.setImages(productImageRepository.getImagesForProduct(productId));
            product.setColors(productColorRepository.getColorsForProduct(productId));
        }
        return product;
    }

    public Product findWithDetails(int id) {
        return productRepository.findWithDetails(id);
    }

}
