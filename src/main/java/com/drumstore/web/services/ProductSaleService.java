package com.drumstore.web.services;

import com.drumstore.web.dto.ProductSaleDTO;
import com.drumstore.web.repositories.ProductSaleRepository;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

public class ProductSaleService {
    private final ProductSaleRepository productSaleRepository = new ProductSaleRepository();

    public List<ProductSaleDTO> all() {
        return productSaleRepository.all();
    }

    public List<ProductSaleDTO> getFilteredProducts(String search, String brandId, String categoryId, String status, int page, int limit) {
        return productSaleRepository.getFilteredProducts(search, brandId, categoryId, status, page, limit);
    }

    public int getTotalFilteredProducts(String search, String brandId, String categoryId, String status) {
        return productSaleRepository.getTotalFilteredProducts(search, brandId, categoryId, status);
    }

    public ProductSaleDTO findById(Integer id) {
        return productSaleRepository.findById(id);
    }

    public void create(Integer productId, String name, String description, Double discountPercentage, String startDate, String endDate) {
        validateSaleData(name, description, discountPercentage, startDate, endDate);
        productSaleRepository.create(productId, name, description, discountPercentage, startDate, endDate);
    }

    public void update(Integer saleId, String name, String description, Double discountPercentage, String startDate, String endDate) {
        validateSaleData(name, description, discountPercentage, startDate, endDate);
        productSaleRepository.update(saleId, name, description, discountPercentage, startDate, endDate);
    }

    public void delete(Integer saleId) {
        productSaleRepository.delete(saleId);
    }

    private void validateSaleData(String name, String description, Double discountPercentage, String startDate, String endDate) {
        if (name == null || name.isEmpty()) {
            throw new IllegalArgumentException("Tên chương trình khuyến mãi không được để trống");
        }

        if (discountPercentage == null || discountPercentage <= 0) {
            throw new IllegalArgumentException("Phần trăm giảm giá phải lớn hơn 0");
        }

        if (discountPercentage > 100) {
            throw new IllegalArgumentException("Phần trăm giảm giá không được vượt quá 100%");
        }

        if (startDate == null || startDate.isEmpty()) {
            throw new IllegalArgumentException("Ngày bắt đầu không được để trống");
        }

        if (endDate == null || endDate.isEmpty()) {
            throw new IllegalArgumentException("Ngày kết thúc không được để trống");
        }

        try {
            LocalDate start = LocalDate.parse(startDate);
            LocalDate end = LocalDate.parse(endDate);

            if (end.isBefore(start)) {
                throw new IllegalArgumentException("Ngày kết thúc phải sau ngày bắt đầu");
            }

            if (start.isBefore(LocalDate.now())) {
                throw new IllegalArgumentException("Ngày bắt đầu không được trong quá khứ");
            }
        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException("Định dạng ngày không hợp lệ");
        }
    }
}
