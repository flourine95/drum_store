package com.drumstore.web.dto;

import java.time.LocalDateTime;

public class ProductDashboardDTO {
    private int id;
    private String name;
    private double basePrice;
    private String categoryName;
    private String brandName;
    private int totalViews;
    private boolean isFeatured;
    private int status;
    private int stock;
    private int totalColors;
    private int totalAddons;
    private int totalVariants;
    private int totalReviews;
    private double avgRating;
    private String mainImage;
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

    public double getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(double basePrice) {
        this.basePrice = basePrice;
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

    public int getTotalViews() {
        return totalViews;
    }

    public void setTotalViews(int totalViews) {
        this.totalViews = totalViews;
    }

    public boolean isFeatured() {
        return isFeatured;
    }

    public void setFeatured(boolean featured) {
        isFeatured = featured;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getTotalColors() {
        return totalColors;
    }

    public void setTotalColors(int totalColors) {
        this.totalColors = totalColors;
    }

    public int getTotalAddons() {
        return totalAddons;
    }

    public void setTotalAddons(int totalAddons) {
        this.totalAddons = totalAddons;
    }

    public int getTotalVariants() {
        return totalVariants;
    }

    public void setTotalVariants(int totalVariants) {
        this.totalVariants = totalVariants;
    }

    public int getTotalReviews() {
        return totalReviews;
    }

    public void setTotalReviews(int totalReviews) {
        this.totalReviews = totalReviews;
    }

    public double getAvgRating() {
        return avgRating;
    }

    public void setAvgRating(double avgRating) {
        this.avgRating = avgRating;
    }

    public String getMainImage() {
        return mainImage;
    }

    public void setMainImage(String mainImage) {
        this.mainImage = mainImage;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "ProductDashboardDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", basePrice=" + basePrice +
                ", categoryName='" + categoryName + '\'' +
                ", brandName='" + brandName + '\'' +
                ", totalViews=" + totalViews +
                ", isFeatured=" + isFeatured +
                ", status=" + status +
                ", stock=" + stock +
                ", totalColors=" + totalColors +
                ", totalAddons=" + totalAddons +
                ", totalVariants=" + totalVariants +
                ", totalReviews=" + totalReviews +
                ", avgRating=" + avgRating +
                ", mainImage='" + mainImage + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
