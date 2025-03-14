package com.drumstore.web.dto;

import java.io.Serializable;

public class ProductColorDTO2 implements Serializable {
    private int id;
    private String name;
    private double additionalPrice;

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

    public double getAdditionalPrice() {
        return additionalPrice;
    }

    public void setAdditionalPrice(double additionalPrice) {
        this.additionalPrice = additionalPrice;
    }

    @Override
    public String toString() {
        return "ProductColorDTO2{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", additionalPrice=" + additionalPrice +
                '}';
    }
}
