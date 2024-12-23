package com.drumstore.web.repositories;

import com.drumstore.web.models.Product;
import com.drumstore.web.models.User;
import com.drumstore.web.models.UserAddress;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class ProductRepository {
    private final Jdbi jdbi;

    public ProductRepository() {
        this.jdbi = DBConnection.getJdbi();
    }

    public List<Product> all() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products")
                        .mapToBean(Product.class)
                        .list()
        );
    }

    public Product findById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Product.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public void save(Product product) {
        jdbi.useHandle(handle ->
                handle.createUpdate("INSERT INTO products (name, description, price, stock, total_views, is_feature, status, average_rating, slug, category_id, brand_id, created_at) VALUES (:name, :description, :price, :stock, :total_views, :is_feature, :status, :average_rating, :slug, :categoryId, :brandId, CURRENT_TIMESTAMP)")
                        .bindBean(product)
                        .execute()
        );
    }

    public void update(Product product) {
        jdbi.useHandle(handle ->
                handle.createUpdate("UPDATE products SET name = :name, description = :description, price = :price, stock = :stock, is_feature = :is_feature, status = :status WHERE id = :id")
                        .bindBean(product)
                        .execute()
        );
    }

    public void delete(int id) {
        jdbi.useHandle(handle ->
                handle.createUpdate("DELETE FROM products WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
    }

    public Product find(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Product.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public Product show(int id) {
        Product product = jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Product.class)
                        .findFirst()
                        .orElse(null)
        );

        //show product
        if (product != null) {
            //to-do
        }

        return product;
    }

}
