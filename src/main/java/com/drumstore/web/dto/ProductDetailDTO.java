package com.drumstore.web.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ProductDetailDTO {
    private int id;
    private String name;
    private String description;
    private double price;
    private int stock;
    private int totalViews;
    private boolean isFeatured;
    private int status;
    private double averageRating;
    private String mainImage;
    private double discountPercent;
    private double salePrice;
    private List<ProductImageDTO> images = new ArrayList<>();
    private List<ProductSaleDTO> sales = new ArrayList<>();
    private List<ProductColorDTO> colors = new ArrayList<>();
    private BrandDTO brand;
    private CategoryDTO category;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
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

    public BrandDTO getBrand() {
        return brand;
    }

    public void setBrand(BrandDTO brand) {
        this.brand = brand;
    }

    public CategoryDTO getCategory() {
        return category;
    }

    public void setCategory(CategoryDTO category) {
        this.category = category;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "ProductDetailDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", stock=" + stock +
                ", totalViews=" + totalViews +
                ", isFeatured=" + isFeatured +
                ", status=" + status +
                ", averageRating=" + averageRating +
                ", imageMain='" + mainImage + '\'' +
                ", discountPercent=" + discountPercent +
                ", salePrice=" + salePrice +
                ", images=" + images +
                ", sales=" + sales +
                ", colors=" + colors +
                ", brand=" + brand +
                ", category=" + category +
                ", createdAt=" + createdAt +
                '}';
    }
}