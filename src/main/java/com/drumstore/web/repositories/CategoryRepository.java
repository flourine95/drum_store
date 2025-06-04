package com.drumstore.web.repositories;

import com.drumstore.web.dto.CategoryDTO;
import com.drumstore.web.models.Category;
import com.drumstore.web.models.Product;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class CategoryRepository {
    private final Jdbi jdbi = DBConnection.getJdbi();

    public List<CategoryDTO> all() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM categories")
                        .mapToBean(CategoryDTO.class)
                        .list()
        );
    }

    public void create(CategoryDTO category) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("INSERT INTO categories (name, description, image) VALUES (:name, :description, :image)")
                    .bindBean(category)
                    .execute();
        });
    }

    public CategoryDTO findById(Integer id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM categories WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(CategoryDTO.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public void update(CategoryDTO category) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("UPDATE categories SET name = :name, description = :description, image = :image WHERE id = :id")
                    .bindBean(category)
                    .execute();
        });
    }

    public boolean hasAssociatedProducts(Integer id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM products WHERE categoryId = :id")
                        .bind("id", id)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }

    public void delete(Integer id) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("DELETE FROM categories WHERE id = :id")
                    .bind("id", id)
                    .execute();
        });
    }

    public List<CategoryDTO> allWithProductCount() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT c.*, COUNT(p.id) AS productCount FROM categories c LEFT JOIN products p ON c.id = p.categoryId GROUP BY c.id")
                        .mapToBean(CategoryDTO.class)
                        .list()
        );
    }
}
