package com.drumstore.web.services;

import com.drumstore.web.models.Category;
import com.drumstore.web.models.Product;
import com.drumstore.web.repositories.CategoryRepository;

import java.util.List;

public class CategoryService {
    private final CategoryRepository categoryRepository = new CategoryRepository();

    public CategoryService(){}

    public List<Category> all() { return categoryRepository.all(); }

    public int create(Category category) { return categoryRepository.save(category); }

    public void update(Category category) { categoryRepository.update(category); }

    public void delete(int id) { categoryRepository.delete(id); }

    public Category show(int id) {return categoryRepository.show(id);}

    public Category find(int id) {
        return categoryRepository.findById(id);
    }

    public Category findById(int i) { return categoryRepository.findById(i); }

    public List<Category> getCategories(int limit) { return categoryRepository.getCategories(limit); }

}
