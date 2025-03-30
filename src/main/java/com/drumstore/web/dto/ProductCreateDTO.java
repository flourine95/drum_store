package com.drumstore.web.dto;

import java.io.Serializable;

public class ProductCreateDTO implements Serializable {
    private int id;
    private String name;
    private String description;
    private double basePrice;
    private int categoryId;
    private int brandId;
    private int stockManagementType;
    private boolean isFeatured;

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

    public int getStockManagementType() {
        return stockManagementType;
    }

    public void setStockManagementType(int stockManagementType) {
        this.stockManagementType = stockManagementType;
    }

    public boolean isIsFeatured() {
        return isFeatured;
    }

    public void setIsFeatured(boolean featured) {
        isFeatured = featured;
    }
}
