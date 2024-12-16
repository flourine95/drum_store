package com.drumstore.web.repositories;

import com.drumstore.web.models.ProductColor;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class ProductColorRepository {
    private final Jdbi jdbi;

    public ProductColorRepository() {
        this.jdbi = DBConnection.getJdbi();
    }

    public void insertColor(ProductColor productColor) {
        jdbi.useHandle(handle ->
                handle.createUpdate("INSERT INTO product_colors (colorCode, colorName, productId) VALUES (?, ?, ?)")
                        .bind(0, productColor.getColorCode())
                        .bind(1, productColor.getColorName())
                        .bind(2, productColor.getProductId())
                        .execute());
    }

    public List<ProductColor> getColorsForProduct(int productId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM product_colors WHERE productId = ?")
                        .bind(0, productId)
                        .mapToBean(ProductColor.class)
                        .list());
    }
}
