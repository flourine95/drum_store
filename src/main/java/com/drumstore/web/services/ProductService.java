package com.drumstore.web.services;

import com.drumstore.web.dto.*;
import com.drumstore.web.models.Product;
import com.drumstore.web.models.ProductSale;
import com.drumstore.web.repositories.ProductRepository;

import java.util.List;

public class ProductService {
    private final ProductRepository productRepository = new ProductRepository();

    public List<ProductDashboardDTO> all() {
        return productRepository.all();
    }

    public int create(ProductCreateDTO product) {
        return productRepository.store(product);
    }

    public int createImage(int productId, ProductImageDTO productImage) {
        return productRepository.storeImage(productId, productImage);
    }

    public ProductDashboardDetailDTO find(int id) {
        return productRepository.findById(id);
    }

    public int countProducts(String search, String category, String brand, String priceRange) {
        return productRepository.countFilteredProducts(search, category, brand, priceRange);
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

    public CartItemDTO findProductForCartItem(int productVariantId, int productId) {
        CartItemDTO cartItemDTO = productRepository.findMainProductVariant(productVariantId);
        cartItemDTO.setVariants(productRepository.findAllVariants(productId));
        return cartItemDTO;
    }

    public CartItemDTO findProductWithVariantForCartItem(int colorId, int addonId, int productId) {
        CartItemDTO cartItemDTO = productRepository.findProductWithVariant(colorId, addonId, productId);
        cartItemDTO.setVariants(productRepository.findAllVariants(productId));
        return cartItemDTO;
    }

    public ProductEditDTO findProductEdit(int id) {
        return productRepository.findProductEdit(id);
    }

    public int createColor(int productId, ProductColorDTO color) {
        return productRepository.storeColor(productId, color);
    }

    public int createAddon(int productId, ProductAddonDTO addon) {
        return productRepository.storeAddon(productId, addon);
    }

    public int createVariant(int productId, ProductVariantDTO variant) {
        return productRepository.storeVariant(productId, variant);
    }
}
