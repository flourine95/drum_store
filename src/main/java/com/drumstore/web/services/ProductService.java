package com.drumstore.web.services;

import com.drumstore.web.dto.CartItemDTO;
import com.drumstore.web.dto.ProductDashboardDetailDTO;
import com.drumstore.web.dto.ProductCardDTO;
import com.drumstore.web.dto.ProductDashboardDTO;
import com.drumstore.web.dto.ProductDetailDTO;
import com.drumstore.web.models.Product;
import com.drumstore.web.models.ProductSale;
import com.drumstore.web.repositories.ProductRepository;

import java.util.List;

public class ProductService {
    private ProductRepository productRepository = new ProductRepository();

    public List<ProductDashboardDTO> all() {
        return productRepository.all();
    }

    public List<ProductDashboardDTO> all2() {
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

    public ProductDashboardDetailDTO find(int id) {
        return productRepository.findById(id);
    }

    public Product show(int id) {
        return productRepository.show(id);
    }

    public Product findWithDetails(int id) {
        return productRepository.findWithDetails(id);
    }


    public List<Product> getLatestProducts(int limit) {
        return productRepository.getLatestProducts(limit);
    }

    public List<Product> getProducts() {
        return productRepository.allWithDetails();
    }


    public int countProducts(String search, String category, String brand, String priceRange) {
        return productRepository.countFilteredProducts(search, category, brand, priceRange);
    }


    public Product findWithDetailsAndSale(int id) {
        Product product = productRepository.findWithDetails(id);
        if (product != null) {
            ProductSale sale = productRepository.getCurrentSale(id);
            product.setProductSale(sale);
        }
        return product;
    }

    public List<ProductCardDTO> getProductCards(int page, int limit, String search, String category, String brand, String priceRange, String sortBy) {
        int offset = (page - 1) * limit;
        return productRepository.getFilteredProductCards(offset, limit, search, category, brand, priceRange, sortBy);
    }

    public ProductDetailDTO getProductDetail(int id) {
        ProductDetailDTO product = productRepository.findProductDetail(id);
        if (product != null) {
            productRepository.incrementViewCount(id);
        }
        return product;
    }

    public List<ProductDashboardDTO> getProductDashboards(int page, int limit, String search, String category, String sortColumn, String sortDir) {
        int offset = (page - 1) * limit;
        return productRepository.getProductDashboards(offset, limit, search, category, sortColumn, sortDir);
    }

    public int getTotalProducts() {
        return productRepository.getTotalProducts();
    }

    public CartItemDTO findProductForCartItem(int productVariantId , int productId){
        CartItemDTO cartItemDTO =  productRepository.findMainProductVariant(productVariantId);
        cartItemDTO.setVariants(productRepository.findAllVariants(productId));
        return cartItemDTO;
    }

    public CartItemDTO findProductWithVariantForCartItem( int colorId , int addonId ,int productId){
       CartItemDTO cartItemDTO = productRepository.findProductWithVariant(colorId, addonId, productId);
       cartItemDTO.setVariants(productRepository.findAllVariants(productId));
        return cartItemDTO;
    };
}
