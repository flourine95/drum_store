package com.drumstore.web.dto;


public class ProductCardDTO {
    private int id;
    private String name;
    private String mainImage;
    private double basePrice;
    private double lowestSalePrice;
    private double averageRating;
    private boolean isFeatured;
    private double discountPercent;
    private int totalViews;
    private int totalReviews;
    private int categoryId;
    private String categoryName;
    private int brandId;
    private String brandName;

    public boolean isIsFeatured() {
        return isFeatured;
    }

    public void setIsFeatured(boolean featured) {
        isFeatured = featured;
    }

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

    public String getMainImage() {
        return mainImage;
    }

    public void setMainImage(String mainImage) {
        this.mainImage = mainImage;
    }

    public double getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(double basePrice) {
        this.basePrice = basePrice;
    }

    public double getLowestSalePrice() {
        return lowestSalePrice;
    }

    public void setLowestSalePrice(double lowestSalePrice) {
        this.lowestSalePrice = lowestSalePrice;
    }

    public double getAverageRating() {
        return averageRating;
    }

    public void setAverageRating(double averageRating) {
        this.averageRating = averageRating;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public int getTotalViews() {
        return totalViews;
    }

    public void setTotalViews(int totalViews) {
        this.totalViews = totalViews;
    }

    public int getTotalReviews() {
        return totalReviews;
    }

    public void setTotalReviews(int totalReviews) {
        this.totalReviews = totalReviews;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    @Override
    public String toString() {
        return "ProductCardDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", mainImage='" + mainImage + '\'' +
                ", basePrice=" + basePrice +
                ", lowestSalePrice=" + lowestSalePrice +
                ", averageRating=" + averageRating +
                ", discountPercent=" + discountPercent +
                ", totalViews=" + totalViews +
                ", totalReviews=" + totalReviews +
                ", categoryId=" + categoryId +
                ", categoryName='" + categoryName + '\'' +
                ", brandId=" + brandId +
                ", brandName='" + brandName + '\'' +
                '}';
    }
}