package com.drumstore.web.dto;

import java.io.Serializable;
import java.time.LocalDateTime;

public class ProductVariantDTO implements Serializable {
    private int id;
    private int imageId;
    private ProductColorDTO2 color;
    private ProductAddonDTO addon;
    private int stock;
    private int status;
    private LocalDateTime createdAt;

    public double getAdditionalPrice() {
        double colorPrice = (color != null) ? color.getAdditionalPrice() : 0.0;
        double addonPrice = (addon != null) ? addon.getAdditionalPrice() : 0.0;
        return colorPrice + addonPrice;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public ProductColorDTO2 getColor() {
        return color;
    }

    public void setColor(ProductColorDTO2 color) {
        this.color = color;
    }

    public ProductAddonDTO getAddon() {
        return addon;
    }

    public void setAddon(ProductAddonDTO addon) {
        this.addon = addon;
    }

    @Override
    public String toString() {
        return "ProductVariantDTO{" +
                "id=" + id +
                ", imageId=" + imageId +
                ", color=" + color +
                ", addon=" + addon +
                ", stock=" + stock +
                ", status=" + status +
                ", createdAt=" + createdAt +
                '}';
    }

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }
}
