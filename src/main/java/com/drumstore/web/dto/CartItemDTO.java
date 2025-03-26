package com.drumstore.web.dto;

import java.util.List;
import java.util.Map;

public class CartItemDTO {
    private int productId;
    private String name;
    private double basePrice;
    private String mainImage;
    private double discountPercent;
   private ProductVariantDTO productVariant; // varient chính
    private Map<String,List<Object>> variants; // varient phục vụ cho update

    public CartItemDTO() {}

    public double getLowestSalePrice() {
        double discountedBasePrice = basePrice * (1 - discountPercent / 100.0);

        if (productVariant == null) {
            return discountedBasePrice;
        }

        double colorAdditionalPrice = (productVariant.getColor() != null) ? productVariant.getColor().getAdditionalPrice() : 0.0;
        double addonAdditionalPrice = (productVariant.getAddon() != null) ? productVariant.getAddon().getAdditionalPrice() : 0.0;

        double totalAdditionalPrice = colorAdditionalPrice + addonAdditionalPrice;

        return (basePrice + totalAdditionalPrice) * (1 - discountPercent / 100.0);
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(double basePrice) {
        this.basePrice = basePrice;
    }

    public String getMainImage() {
        return mainImage;
    }

    public void setMainImage(String mainImage) {
        this.mainImage = mainImage;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public ProductVariantDTO getProductVariant() {
        return productVariant;
    }

    public void setProductVariant(ProductVariantDTO productVariant) {
        this.productVariant = productVariant;
    }

    public Map<String, List<Object>> getVariants() {
        return variants;
    }

    public void setVariants(Map<String, List<Object>> variants) {
        this.variants = variants;
    }

    @Override
    public String toString() {
        return "CartItemDTO{" +
                "productId=" + productId +
                ", name='" + name + '\'' +
                ", basePrice=" + basePrice +
                ", mainImage='" + mainImage + '\'' +
                ", discountPercent=" + discountPercent +
                ", productVariant=" + productVariant +
                ", variants=" + variants +
                '}';
    }
}
