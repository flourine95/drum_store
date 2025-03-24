package com.drumstore.web.dto;

import java.time.LocalDateTime;
import java.util.List;

public class ProductDashboardDetailDTO {
    private int id;
    private String name;
    private String description;
    private double basePrice;
    private int totalViews;
    private boolean isFeatured;
    private int status;
    private int stockManagementType;
    private String categoryName;
    private String brandName;
    private List<ProductImageDTO> images;
    private List<ProductSaleDTO> sales;
    private List<ProductColorDTO> colors;
    private List<ProductReviewDTO> reviews;
    private List<ProductVariantDTO> variants;
    private LocalDateTime createdAt;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(double basePrice) {
        this.basePrice = basePrice;
    }

    public int getTotalViews() {
        return totalViews;
    }

    public void setTotalViews(int totalViews) {
        this.totalViews = totalViews;
    }

    public boolean isIsFeatured() {
        return isFeatured;
    }

    public void setIsFeatured(boolean featured) {
        isFeatured = featured;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getStockManagementType() {
        return stockManagementType;
    }

    public void setStockManagementType(int stockManagementType) {
        this.stockManagementType = stockManagementType;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public List<ProductImageDTO> getImages() {
        return images;
    }

    public void setImages(List<ProductImageDTO> images) {
        this.images = images;
    }

    public List<ProductSaleDTO> getSales() {
        return sales;
    }

    public void setSales(List<ProductSaleDTO> sales) {
        this.sales = sales;
    }

    public List<ProductColorDTO> getColors() {
        return colors;
    }

    public void setColors(List<ProductColorDTO> colors) {
        this.colors = colors;
    }

    public List<ProductReviewDTO> getReviews() {
        return reviews;
    }

    public void setReviews(List<ProductReviewDTO> reviews) {
        this.reviews = reviews;
    }

    public List<ProductVariantDTO> getVariants() {
        return variants;
    }

    public void setVariants(List<ProductVariantDTO> variants) {
        this.variants = variants;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "ProductDashboardDetailDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", basePrice=" + basePrice +
                ", totalViews=" + totalViews +
                ", isFeatured=" + isFeatured +
                ", status=" + status +
                ", stockManagementType=" + stockManagementType +
                ", categoryName='" + categoryName + '\'' +
                ", brandName='" + brandName + '\'' +
                ", images=" + images +
                ", sales=" + sales +
                ", colors=" + colors +
                ", reviews=" + reviews +
                ", variants=" + variants +
                ", createdAt=" + createdAt +
                '}';
    }
}
