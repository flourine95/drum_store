package com.drumstore.web.dto;

import com.drumstore.web.models.Brand;
import com.drumstore.web.models.Category;
import com.drumstore.web.models.ProductColor;
import com.drumstore.web.models.ProductSale;

import java.sql.Timestamp;
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
    private Brand brand;
    private Category category;
    private List<String> images = new ArrayList<>();
    private List<ProductColor> colors = new ArrayList<>();
    private List<ProductSale> sales = new ArrayList<>();
    private Timestamp createdAt;
    private Timestamp updatedAt;

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

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    public List<ProductColor> getColors() {
        return colors;
    }

    public void setColors(List<ProductColor> colors) {
        this.colors = colors;
    }

    public List<ProductSale> getSales() {
        return sales;
    }

    public void setSales(List<ProductSale> sales) {
        this.sales = sales;
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
                ", brand=" + brand +
                ", category=" + category +
                ", images=" + images +
                ", colors=" + colors +
                ", sales=" + sales +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}