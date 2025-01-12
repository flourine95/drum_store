package com.drumstore.web.repositories;

import com.drumstore.web.models.*;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.util.LinkedHashMap;
import java.util.List;

public class ProductRepository {
    private final Jdbi jdbi;

    public ProductRepository() {
        this.jdbi = DBConnection.getJdbi();
    }

    public List<Product> all() {
        String sql = """
            SELECT
                p.id AS p_id, p.name AS p_name, p.price AS p_price, p.description as p_description, 
                p.stock as p_stock, p.createdAt as p_createdAt, p.updatedAt as p_updatedAt,
                c.id AS c_id, c.name AS c_name,
                b.id AS b_id, b.name AS b_name,
                i.id AS i_id, i.image AS i_image, i.isMain AS i_isMain
            FROM products p
                     LEFT JOIN categories c ON p.categoryId = c.id
                     LEFT JOIN brands b ON p.brandId = b.id
                     LEFT JOIN product_images i ON p.id = i.productId AND i.isMain = 1
            """;

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .registerRowMapper(BeanMapper.factory(Product.class, "p"))
                .registerRowMapper(BeanMapper.factory(Category.class, "c"))
                .registerRowMapper(BeanMapper.factory(Brand.class, "b"))
                .registerRowMapper(BeanMapper.factory(ProductImage.class, "i"))
                .reduceRows(new LinkedHashMap<Integer, Product>(), (map, row) -> {
                    Product product = map.computeIfAbsent(row.getColumn("p_id", Integer.class), _ -> row.getRow(Product.class));
                    if (row.getColumn("c_id", Integer.class) != null) {
                        product.setCategory(row.getRow(Category.class));
                    }
                    if (row.getColumn("b_id", Integer.class) != null) {
                        product.setBrand(row.getRow(Brand.class));
                    }
                    if (row.getColumn("i_id", Integer.class) != null) {
                        product.setImages(List.of(row.getRow(ProductImage.class)));
                    }
                    return map;
                })
                .values()
                .stream()
                .toList()
        );
    }

    public Product findById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Product.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public void store(Product product) {
        jdbi.useHandle(handle ->
                handle.createUpdate("INSERT INTO products (name, description, price, stock, total_views, is_feature, status, average_rating, slug, category_id, brand_id, created_at) VALUES (:name, :description, :price, :stock, :total_views, :is_feature, :status, :average_rating, :slug, :categoryId, :brandId, CURRENT_TIMESTAMP)")
                        .bindBean(product)
                        .execute()
        );
    }

    public void update(Product product) {
        jdbi.useHandle(handle ->
                handle.createUpdate("UPDATE products SET name = :name, description = :description, price = :price, stock = :stock, is_feature = :is_feature, status = :status WHERE id = :id")
                        .bindBean(product)
                        .execute()
        );
    }

    public void delete(int id) {
        jdbi.useHandle(handle ->
                handle.createUpdate("DELETE FROM products WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
    }

    public Product find(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Product.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public Product show(int id) {
        Product product = jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Product.class)
                        .findFirst()
                        .orElse(null)
        );

        //show product
        if (product != null) {
            //to-do
        }

        return product;
    }

    public Product detail(int id) {
        String sql = """
            SELECT
                p.id AS p_id, p.name AS p_name, p.description AS p_description,
                p.price AS p_price, p.stock AS p_stock, p.totalViews AS p_totalViews,
                p.isFeatured AS p_isFeatured, p.status AS p_status,
                p.averageRating AS p_averageRating, p.slug AS p_slug,
                p.createdAt AS p_createdAt, p.updatedAt AS p_updatedAt, p.deletedAt AS p_deletedAt,
                i.id AS i_id, i.productId AS i_productId, i.imageUrl AS i_imageUrl,
                c.id AS c_id, c.productId AS c_productId, c.colorCode AS c_colorCode,
                cat.id AS cat_id, cat.name AS cat_name, cat.slug AS cat_slug,
                b.id AS b_id, b.name AS b_name, b.slug AS b_slug
            FROM products p
                     LEFT JOIN product_images i ON p.id = i.productId AND i.isMain = 1
                     LEFT JOIN product_colors c ON p.id = c.productId
                     LEFT JOIN categories cat ON p.categoryId = cat.id
                     LEFT JOIN brands b ON p.brandId = b.id
            WHERE p.id = :id
            """;

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("id", id)
                .registerRowMapper(BeanMapper.factory(Product.class, "p"))
                .registerRowMapper(BeanMapper.factory(ProductImage.class, "i"))
                .registerRowMapper(BeanMapper.factory(ProductColor.class, "c"))
                .registerRowMapper(BeanMapper.factory(Category.class, "cat"))
                .registerRowMapper(BeanMapper.factory(Brand.class, "b"))
                .reduceRows(new LinkedHashMap<Integer, Product>(), (map, row) -> {
                    Product product = map.computeIfAbsent(row.getColumn("p_id", Integer.class), _ -> row.getRow(Product.class));

                    if (row.getColumn("i_id", Integer.class) != null) {
                        product.getImages().add(row.getRow(ProductImage.class));
                    }

                    if (row.getColumn("c_id", Integer.class) != null) {
                        product.getColors().add(row.getRow(ProductColor.class));
                    }

                    if (row.getColumn("cat_id", Integer.class) != null && product.getCategory() == null) {
                        product.setCategory(row.getRow(Category.class));
                    }

                    if (row.getColumn("b_id", Integer.class) != null && product.getBrand() == null) {
                        product.setBrand(row.getRow(Brand.class));
                    }

                    return map;
                })
                .values()
                .stream()
                .findFirst()
                .orElse(null));
    }


}
