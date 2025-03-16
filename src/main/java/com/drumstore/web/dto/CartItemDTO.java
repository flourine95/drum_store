package com.drumstore.web.dto;

import java.util.List;

public class CartItemDTO {
    private int productId;
    private String name;
    private double basePrice;
    private String mainImage;
    private double discountPercent;
    private List<ProductSaleDTO> sales;
    private ProductVariantDTO variants;

    public double getLowestSalePrice() {
        double discountedBasePrice = basePrice * (1 - discountPercent / 100.0);

        if (variants == null ) {
            return discountedBasePrice;
        }

        double minAdditionalPrice = Double.MAX_VALUE;
        minAdditionalPrice = Math.min(minAdditionalPrice, variants.getAdditionalPrice());

        return (basePrice + minAdditionalPrice) * (1 - discountPercent / 100.0);
    }


    public ProductVariantDTO getVariants() {
        return variants;
    }

    public void setVariants(ProductVariantDTO variants) {
        this.variants = variants;
    }

    public List<ProductSaleDTO> getSales() {
        return sales;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public String getMainImage() {
        return mainImage;
    }

    public double getBasePrice() {
        return basePrice;
    }

    public String getName() {
        return name;
    }

    public int getProductId() {
        return productId;
    }




    public void setSales(List<ProductSaleDTO> sales) {
        this.sales = sales;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public void setMainImage(String mainImage) {
        this.mainImage = mainImage;
    }

    public void setBasePrice(double basePrice) {
        this.basePrice = basePrice;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }


    @Override
    public String toString() {
        return "CartItemDTO{" +
                "productId=" + productId +
                ", name='" + name + '\'' +
                ", basePrice=" + basePrice +
                ", mainImage='" + mainImage + '\'' +
                ", discountPercent=" + discountPercent +
                ", sales=" + sales +
                ", variants=" + variants +
                '}';
    }
}
