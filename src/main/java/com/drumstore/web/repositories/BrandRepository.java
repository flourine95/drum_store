package com.drumstore.web.repositories;

import com.drumstore.web.dto.BrandDTO;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class BrandRepository {
    private final Jdbi jdbi = DBConnection.getJdbi();

    public List<BrandDTO> all() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM brands")
                        .mapToBean(BrandDTO.class)
                        .list()
        );
    }

    public void create(BrandDTO brand) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("INSERT INTO brands (name, description, image) VALUES (:name, :description, :image)")
                    .bindBean(brand)
                    .execute();
        });
    }

    public BrandDTO findById(Integer id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM brands WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(BrandDTO.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public void update(BrandDTO brand) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("UPDATE brands SET name = :name, description = :description, image = :image WHERE id = :id")
                    .bindBean(brand)
                    .execute();
        });
    }

    public boolean hasAssociatedProducts(Integer id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM products WHERE brandId = :id")
                        .bind("id", id)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }

    public void delete(Integer id) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("DELETE FROM brands WHERE id = :id")
                    .bind("id", id)
                    .execute();
        });
    }

    public List<BrandDTO> allWithProductCount() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT b.*, COUNT(p.id) AS productCount FROM brands b LEFT JOIN products p ON b.id = p.brandId GROUP BY b.id")
                        .mapToBean(BrandDTO.class)
                        .list()
        );
    }
}
