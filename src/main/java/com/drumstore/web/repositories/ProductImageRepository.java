package com.drumstore.web.repositories;

import com.drumstore.web.models.ProductImage;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class ProductImageRepository {
    private final Jdbi jdbi;

    public ProductImageRepository() {
        this.jdbi = DBConnection.getJdbi();
    }

    public void insertImage(ProductImage productImage) {
        jdbi.useHandle(handle ->
                handle.createUpdate("INSERT INTO product_images (image, isMain, productId) VALUES (?, ?, ?)")
                        .bind(0, productImage.getImage())
                        .bind(1, productImage.isIsMain())
                        .bind(2, productImage.getProductId())
                        .execute());
    }

    public List<ProductImage> getImagesForProduct(int productId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM product_images WHERE productId = ?")
                        .bind(0, productId)
                        .mapToBean(ProductImage.class)
                        .list());
    }
}
