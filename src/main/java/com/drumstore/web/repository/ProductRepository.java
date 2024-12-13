package com.drumstore.web.repository;

import com.drumstore.web.model.Product;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class ProductRepository {
    private Jdbi jdbi;

    public ProductRepository() {
        this.jdbi = DBConnection.getJdbi();
    }

    public List<Product> getAllProducts() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products")
                        .mapToBean(Product.class)
                        .list()
        );
    }

    public Product getProductById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Product.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public void saveProduct(Product product) {
        jdbi.useHandle(handle ->
                handle.createUpdate("INSERT INTO products (name, description, price) VALUES (:name, :description, :price)")
                        .bindBean(product)
                        .execute()
        );
    }

    public void updateProduct(Product product) {
        jdbi.useHandle(handle ->
                handle.createUpdate("UPDATE products SET name = :name, description = :description, price = :price WHERE id = :id")
                        .bindBean(product)
                        .execute()
        );
    }

    public void deleteProduct(int id) {
        jdbi.useHandle(handle ->
                handle.createUpdate("DELETE FROM products WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
    }
    
}
