package com.drumstore.web.dto;

public class ProductImageDTO {
    private int id;
    private String image;
    private boolean isMain;

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
}
