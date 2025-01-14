package com.drumstore.web.services;

import com.drumstore.web.models.ProductColor;
import com.drumstore.web.repositories.ProductColorRepository;

import java.util.List;

public class ProductColorService {
    private final ProductColorRepository productColorRepository = new ProductColorRepository();

    public List<ProductColor> all() {
        return productColorRepository.all();
    }

    public boolean create(ProductColor productColor) {return productColorRepository.create(productColor);}

    public int update(ProductColor productColor) {
        return productColorRepository.update(productColor);
    }

    public int delete(int id) {
        return productColorRepository.delete(id);
    }

    public ProductColor find(int id) {
        return productColorRepository.find(id);
    }

}
