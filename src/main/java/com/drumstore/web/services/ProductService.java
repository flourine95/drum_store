package com.drumstore.web.services;

import com.drumstore.web.dto.ProductCardDTO;
import com.drumstore.web.dto.ProductDetailDTO;
import com.drumstore.web.dto.ProductDetailDTO2;
import com.drumstore.web.models.Product;
import com.drumstore.web.models.ProductSale;
import com.drumstore.web.repositories.ProductRepository;

import java.util.List;

public class ProductService {
    private ProductRepository productRepository = new ProductRepository();

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

    public List<ProductCardDTO> getFeaturedProducts(int limit) {
        return productRepository.getFeaturedProducts(limit);
    }

    public List<Product> getLatestProducts(int limit) {
        return productRepository.getLatestProducts(limit);
    }

    public List<Product> getProducts() {
        return productRepository.allWithDetails();
    }

//    public List<Product> getProducts(int page, int limit, String search, String category, String brand, String priceRange, String sortBy) {
//        int offset = (page - 1) * limit;
//        return productRepository.getFilteredProducts(offset, limit, search, category, brand, priceRange, sortBy);
//    }

    public int countProducts(String search, String category, String brand, String priceRange) {
        return productRepository.countFilteredProducts(search, category, brand, priceRange);
    }

//    public List<Product> getRelatedProducts(int productId, int categoryId, int limit) {
//        return productRepository.getRelatedProducts(productId, categoryId, limit);
//    }

    public Product findWithDetailsAndSale(int id) {
        Product product = productRepository.findWithDetails(id);
        if (product != null) {
            // Lấy thông tin sale nếu có
            ProductSale sale = productRepository.getCurrentSale(id);
            product.setProductSale(sale);

        }
        return product;
    }

//    public List<Product> getRelatedProductsWithSale(int productId, int categoryId, int limit) {
//        List<Product> products = productRepository.getRelatedProducts(productId, categoryId, limit);
//        for (Product product : products) {
//            ProductSale sale = productRepository.getCurrentSale(product.getId());
//            product.setProductSale(sale);
//        }
//        return products;
//    }

    public List<ProductCardDTO> getProductCards(int page, int limit, String search, String category, String brand, String priceRange, String sortBy) {
        int offset = (page - 1) * limit;
        return productRepository.getFilteredProductCards(offset, limit, search, category, brand, priceRange, sortBy);
    }

    public ProductDetailDTO2 getProductDetail(int id) {
        ProductDetailDTO2 product = productRepository.findProductDetail(id);
        if (product != null) {
            productRepository.incrementViewCount(id);
        }
        return product;
    }

    public List<ProductCardDTO> getRelatedProductCards(int productId, int categoryId, int limit) {
        return productRepository.getRelatedProductCards(productId, categoryId, limit);
    }
}
