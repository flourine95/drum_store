package com.drumstore.web.services;

import com.drumstore.web.models.Sale;
import com.drumstore.web.repositories.SaleRepository;

import java.util.List;

public class SaleService {

    private final SaleRepository saleRepository = new SaleRepository();

    public SaleService(){}

    public List<Sale> all() { return saleRepository.all(); }

    public int create(Sale sale) { return saleRepository.save(sale); }

    public void update(Sale sale) { saleRepository.update(sale); }

    public void delete(int id) { saleRepository.delete(id); }

    public Sale show(int id) {return saleRepository.show(id);}

    public Sale findById(int id) { return saleRepository.findById(id); }
}
