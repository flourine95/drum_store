package com.drumstore.web.models;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Product {
    private int id;
    private String name;
    private String description;
    private double price;
    private int stock;
    private int totalViews;
    private boolean isFeatured;
    private int status;
    private double averageRating;
    private String slug;
    private int categoryId;
    private int brandId;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Timestamp deletedAt;

    private List<ProductImage> images;
    private List<ProductColor> colors;
    private Category category;
    private Brand brand;

    public Product(int id, String name, String description, double price, int stock, int totalViews, boolean isFeatured, int status, double averageRating, String slug, int categoryId, int brandId, Timestamp createdAt, Timestamp updatedAt, Timestamp deletedAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.totalViews = totalViews;
        this.isFeatured = isFeatured;
        this.status = status;
        this.averageRating = averageRating;
        this.slug = slug;
        this.categoryId = categoryId;
        this.brandId = brandId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.deletedAt = deletedAt;
    }

    // create product
    public Product(String name, String description, double price, int stock, boolean isFeatured, String slug, int categoryId, int brandId) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.isFeatured = isFeatured;
        this.slug = slug;
        this.categoryId = categoryId;
        this.brandId = brandId;
    }


    public Product() {
        this.images = new ArrayList<>();
        this.colors = new ArrayList<>();
    }

    public void addImage(ProductImage image) {
        this.images.add(image);
    }

    public void addColor(ProductColor color) {
        this.colors.add(color);
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", stock=" + stock +
                ", totalViews=" + totalViews +
                ", isFeatured=" + isFeatured +
                ", status=" + status +
                ", averageRating=" + averageRating +
                ", slug='" + slug + '\'' +
                ", categoryId=" + categoryId +
                ", brandId=" + brandId +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", deletedAt=" + deletedAt +
                ", images=" + images +
                ", colors=" + colors +
                ", category=" + category +
                ", brand=" + brand +
                '}';
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

    public double getAverageRating() {
        return averageRating;
    }

    public void setAverageRating(double averageRating) {
        this.averageRating = averageRating;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Timestamp getDeletedAt() {
        return deletedAt;
    }

    public void setDeletedAt(Timestamp deletedAt) {
        this.deletedAt = deletedAt;
    }

    public void setImages(List<ProductImage> images) {
        this.images = images;
    }

    public void setColors(List<ProductColor> colors) {
        this.colors = colors;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

}