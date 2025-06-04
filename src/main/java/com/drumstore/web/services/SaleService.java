package com.drumstore.web.services;

import com.drumstore.web.dto.SaleDTO;
import com.drumstore.web.repositories.SaleRepository;

import java.util.List;

public class SaleService {
    private final SaleRepository saleRepository = new SaleRepository();

    public List<SaleDTO> all() {
        return saleRepository.all();
    }

    public void create(SaleDTO brand) {
        saleRepository.create(brand);
    }

    public SaleDTO findById(Integer id) {
        return saleRepository.findById(id);
    }

    public void update(SaleDTO brand) {
        saleRepository.update(brand);
    }

    public void delete(Integer id) {
        saleRepository.delete(id);
    }

}
