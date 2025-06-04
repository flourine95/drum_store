package com.drumstore.web.repositories;

import com.drumstore.web.dto.SaleDTO;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class SaleRepository {
    private final Jdbi jdbi = DBConnection.getJdbi();

    public List<SaleDTO> all() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM sales")
                        .mapToBean(SaleDTO.class)
                        .list()
        );
    }

    public void create(SaleDTO sale) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("INSERT INTO sales (name, description, discountPercentage, startDate, endDate) VALUES (:name, :description, :discountPercentage, :startDate, :endDate)")
                    .bindBean(sale)
                    .execute();
        });
    }

    public SaleDTO findById(Integer id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM sales WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(SaleDTO.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public void update(SaleDTO sale) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("UPDATE sales SET name = :name, description = :description, discountPercentage = :discountPercentage, startDate = :startDate, endDate = :endDate WHERE id = :id")
                    .bindBean(sale)
                    .execute();
        });
    }

    public void delete(Integer id) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("DELETE FROM sales WHERE id = :id")
                    .bind("id", id)
                    .execute();
        });
    }
}
