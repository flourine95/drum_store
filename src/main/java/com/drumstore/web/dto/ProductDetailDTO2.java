package com.drumstore.web.dto;

import java.time.LocalDateTime;
import java.util.List;

public class ProductDetailDTO2 {
    private int id;
    private String name;
    private String description;
    private double basePrice;
    private boolean isFeatured;
    private int status;
    private double averageRating;
    private int totalViews;
    private int totalReviews;
    private int stockManagementType;
    private int categoryId;
    private String categoryName;
    private int brandId;
    private String brandName;
    private String mainImage;
    private double discountPercent;
    private double salePrice;
    private LocalDateTime createdAt;
    private List<ProductImageDTO2> images;
    private List<ProductColorDTO2> colors;
    private List<ProductAddonDTO> addons;
    private List<ProductReviewDTO> reviews;
    private List<ProductSaleDTO2> sales;
    private List<ProductVariantDTO> variants;

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

    public double getAverageRating() {
        return averageRating;
    }

    public void setAverageRating(double averageRating) {
        this.averageRating = averageRating;
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

    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public List<ProductImageDTO2> getImages() {
        return images;
    }

    public void setImages(List<ProductImageDTO2> images) {
        this.images = images;
    }

    public List<ProductColorDTO2> getColors() {
        return colors;
    }

    public void setColors(List<ProductColorDTO2> colors) {
        this.colors = colors;
    }

    public List<ProductAddonDTO> getAddons() {
        return addons;
    }

    public void setAddons(List<ProductAddonDTO> addons) {
        this.addons = addons;
    }

    public List<ProductReviewDTO> getReviews() {
        return reviews;
    }

    public void setReviews(List<ProductReviewDTO> reviews) {
        this.reviews = reviews;
    }

    public List<ProductSaleDTO2> getSales() {
        return sales;
    }

    public void setSales(List<ProductSaleDTO2> sales) {
        this.sales = sales;
    }

    public List<ProductVariantDTO> getVariants() {
        return variants;
    }

    public void setVariants(List<ProductVariantDTO> variants) {
        this.variants = variants;
    }

    public int getStockManagementType() {
        return stockManagementType;
    }

    public void setStockManagementType(int stockManagementType) {
        this.stockManagementType = stockManagementType;
    }

    @Override
    public String toString() {
        return "ProductDetailDTO2{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", basePrice=" + basePrice +
                ", totalViews=" + totalViews +
                ", isFeatured=" + isFeatured +
                ", status=" + status +
                ", averageRating=" + averageRating +
                ", totalReviews=" + totalReviews +
                ", categoryId=" + categoryId +
                ", categoryName='" + categoryName + '\'' +
                ", brandId=" + brandId +
                ", brandName='" + brandName + '\'' +
                ", mainImage='" + mainImage + '\'' +
                ", discountPercent=" + discountPercent +
                ", salePrice=" + salePrice +
                ", createdAt=" + createdAt +
                ", images=" + images +
                ", colors=" + colors +
                ", addons=" + addons +
                ", reviews=" + reviews +
                ", sales=" + sales +
                '}';
    }
}
