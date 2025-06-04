package com.drumstore.web.services;

import com.drumstore.web.dto.CategoryDTO;
import com.drumstore.web.models.Category;
import com.drumstore.web.repositories.CategoryRepository;

import java.util.List;

public class CategoryService {
    private final CategoryRepository categoryRepository = new CategoryRepository();

    public List<Category> all() {
        return categoryRepository.all();
    }

    public void create(CategoryDTO category) {
        categoryRepository.create(category);
    }

    public CategoryDTO findById(Integer id) {
        return categoryRepository.findById(id);
    }

    public void update(CategoryDTO category) {
        categoryRepository.update(category);
    }

    public boolean hasAssociatedProducts(Integer id) {
        return categoryRepository.hasAssociatedProducts(id);
    }

    public void delete(Integer id) {
        categoryRepository.delete(id);
    }

    public List<CategoryDTO> allWithProductCount() {
        return categoryRepository.allWithProductCount();
    }
}
