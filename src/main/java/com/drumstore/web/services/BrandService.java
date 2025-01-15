package com.drumstore.web.services;

import com.drumstore.web.models.Brand;
import com.drumstore.web.repositories.BrandRepository;

import java.util.List;

public class BrandService {
    private final BrandRepository brandRepository = new BrandRepository();

    public BrandService(){}

    public List<Brand> all() { return brandRepository.all(); }

    public int create(Brand brand) { return brandRepository.save(brand); }

    public void update(Brand brand) { brandRepository.update(brand); }

    public void delete(int id) { brandRepository.delete(id); }

    public Brand show(int id) {return brandRepository.show(id);}

    public Brand findById(int id) {
        return brandRepository.findById(id);
    }

}
