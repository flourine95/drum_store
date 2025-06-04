package com.drumstore.web.services;

import com.drumstore.web.dto.BrandDTO;
import com.drumstore.web.models.Brand;
import com.drumstore.web.repositories.BrandRepository;

import java.util.List;

public class BrandService {
    private final BrandRepository brandRepository = new BrandRepository();

    public List<BrandDTO> all() {
        return brandRepository.all();
    }

    public void create(BrandDTO brand) {
        brandRepository.create(brand);
    }

    public BrandDTO findById(Integer id) {
        return brandRepository.findById(id);
    }

    public void update(BrandDTO brand) {
        brandRepository.update(brand);
    }

    public boolean hasAssociatedProducts(Integer id) {
        return brandRepository.hasAssociatedProducts(id);
    }

    public void delete(Integer id) {
        brandRepository.delete(id);
    }


    public List<BrandDTO> allWithProductCount() {
        return brandRepository.allWithProductCount();
    }
}
