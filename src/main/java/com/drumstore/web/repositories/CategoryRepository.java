package com.drumstore.web.repositories;

import com.drumstore.web.models.Category;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class CategoryRepository {
    private Jdbi jdbi;

    public CategoryRepository() {
        jdbi = DBConnection.getJdbi();
    }
    public List<Category> getCategories(int limit) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM categories LIMIT :limit")
                        .bind("limit", limit)
                        .mapToBean(Category.class)
                        .list()
        );
    }
}
