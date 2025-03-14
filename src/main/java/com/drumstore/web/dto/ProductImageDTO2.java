package com.drumstore.web.dto;

import java.io.Serializable;
import java.time.LocalDateTime;

public class ProductImageDTO2 implements Serializable {
    private int id;
    private String image;
    private boolean isMain;
    private int sortOrder;
    private LocalDateTime createdAt;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public boolean isIsMain() {
        return isMain;
    }

    public void setIsMain(boolean main) {
        isMain = main;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "ProductImageDTO2{" +
                "id=" + id +
                ", image='" + image + '\'' +
                ", isMain=" + isMain +
                ", sortOrder=" + sortOrder +
                ", createdAt=" + createdAt +
                '}';
    }
}
