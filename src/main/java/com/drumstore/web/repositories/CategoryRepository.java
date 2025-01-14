package com.drumstore.web.repositories;

import com.drumstore.web.models.Category;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class CategoryRepository extends BaseRepository<Category> {
    private Jdbi jdbi = DBConnection.getJdbi();

    public Category findById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM categories WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Category.class)
                        .findFirst()
                        .orElse(null)
        );
    }
}
