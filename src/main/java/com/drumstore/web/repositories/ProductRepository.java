package com.drumstore.web.repositories;

import com.drumstore.web.models.*;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.util.LinkedHashMap;
import java.util.List;

public class ProductRepository extends BaseRepository<Product> {
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
                .registerRowMapper(BeanMapper.factory(ProductImage.class, "i"))
                .registerRowMapper(BeanMapper.factory(Brand.class, "b"))
                .reduceRows(new LinkedHashMap<Integer, Product>(), (map, row) -> {
                    Product product = map.computeIfAbsent(row.getColumn("p_id", Integer.class), _ -> row.getRow(Product.class));
                    if (row.getColumn("c_id", Integer.class) != null) {
                        product.setCategory(row.getRow(Category.class));
                    }
                    if (row.getColumn("i_id", Integer.class) != null) {
                        product.setImages(List.of(row.getRow(ProductImage.class)));
                    }
                    if (row.getColumn("b_id", Integer.class) != null) {
                        product.setBrand(row.getRow(Brand.class));
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

    public void save(Product product) {
        jdbi.useHandle(handle ->
                handle.createUpdate("INSERT INTO products (name, description, price, stock, total_views, is_feature, status, average_rating, slug, category_id, brand_id, created_at) VALUES (:name, :description, :price, :stock, :total_views, :is_feature, :status, :average_rating, :slug, :categoryId, :brandId, CURRENT_TIMESTAMP)")
                        .bindBean(product)
                        .execute()
        );
    }

    public void update(Product product) {
        jdbi.useHandle(handle ->
                handle.createUpdate("UPDATE products SET name = :name, description = :description, price = :price, stock = :stock, isFeatured = :isFeatured, status = :status, slug = :slug WHERE id = :id")
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

    public Product findWithDetails(int id) {
        String sql = """
            SELECT
                p.id AS p_id, p.name AS p_name, p.description AS p_description,
                p.price AS p_price, p.stock AS p_stock, p.totalViews AS p_totalViews,
                p.isFeatured AS p_isFeatured, p.status AS p_status,
                p.averageRating AS p_averageRating, p.slug AS p_slug,
                p.createdAt AS p_createdAt, p.updatedAt AS p_updatedAt,
                p.deletedAt AS p_deletedAt,
                pi.id AS pi_id, pi.image AS pi_image, pi.isMain AS pi_isMain,
                pc.id AS pc_id, pc.colorCode AS pc_colorCode, pc.colorName AS pc_colorName,
                c.id AS c_id, c.name AS c_name, c.image AS c_image, c.description AS c_description,
                c.createdAt AS c_createdAt, c.updatedAt AS c_updatedAt, c.deletedAt AS c_deletedAt,
                b.id AS b_id, b.name AS b_name, b.image AS b_image, b.description AS b_description,
                b.createdAt AS b_createdAt, b.updatedAt AS b_updatedAt, b.deletedAt AS b_deletedAt
            FROM products p
                     LEFT JOIN product_images pi ON p.id = pi.productId
                     LEFT JOIN product_colors pc ON p.id = pc.productId
                     LEFT JOIN categories c ON p.categoryId = c.id
                     LEFT JOIN brands b ON p.brandId = b.id
            WHERE p.id = :id
            """;
        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("id", id)
                .registerRowMapper(BeanMapper.factory(Product.class, "p"))
                .registerRowMapper(BeanMapper.factory(ProductImage.class, "pi"))
                .registerRowMapper(BeanMapper.factory(ProductColor.class, "pc"))
                .registerRowMapper(BeanMapper.factory(Category.class, "c"))
                .registerRowMapper(BeanMapper.factory(Brand.class, "b"))
                .reduceRows(new LinkedHashMap<Integer, Product>(), (map, row) -> {
                    Product product = map.computeIfAbsent(row.getColumn("p_id", Integer.class), _ -> row.getRow(Product.class));
                    if (row.getColumn("pi_id", Integer.class) != null) {
                        product.addImage(row.getRow(ProductImage.class));
                    }
                    if (row.getColumn("pc_id", Integer.class) != null) {
                        product.addColor(row.getRow(ProductColor.class));
                    }
                    if (row.getColumn("c_id", Integer.class) != null && product.getCategory() == null) {
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
                .orElse(null)
        );
    }

    public List<Product> getFeaturedProducts(int limit) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE isFeatured = 1 LIMIT :limit")
                        .bind("limit", limit)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    public List<Product> getLatestProducts(int limit) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products ORDER BY createdAt DESC LIMIT :limit")
                        .bind("limit", limit)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    public List<Product> allWithDetails() {
        String sql = """
                SELECT
                    p.id AS p_id, p.name AS p_name, p.description AS p_description,
                    p.price AS p_price, p.stock AS p_stock, p.totalViews AS p_totalViews,
                    p.isFeatured AS p_isFeatured, p.status AS p_status,
                    p.averageRating AS p_averageRating, p.slug AS p_slug,
                    p.categoryId AS p_categoryId, p.brandId AS p_brandId,
                    p.createdAt AS p_createdAt, p.updatedAt AS p_updatedAt, p.deletedAt AS p_deletedAt,
                
                    c.id AS c_id, c.name AS c_name, c.image AS c_image, c.description AS c_description,
                    c.createdAt AS c_createdAt, c.updatedAt AS c_updatedAt, c.deletedAt AS c_deletedAt,
                
                    b.id AS b_id, b.name AS b_name, b.image AS b_image, b.description AS b_description,
                    b.createdAt AS b_createdAt, b.updatedAt AS b_updatedAt, b.deletedAt AS b_deletedAt,
                
                    pi.id AS pi_id, pi.productId AS pi_productId, pi.image AS pi_image, pi.isMain AS pi_isMain,
                
                    pc.id AS pc_id, pc.colorCode AS pc_colorCode, pc.colorName AS pc_colorName
                FROM products p
                         LEFT JOIN categories c ON p.categoryId = c.id
                         LEFT JOIN brands b ON p.brandId = b.id
                         LEFT JOIN product_images pi ON p.id = pi.productId
                         LEFT JOIN product_colors pc ON p.id = pc.productId
                
                """;

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .registerRowMapper(BeanMapper.factory(Product.class, "p"))
                .registerRowMapper(BeanMapper.factory(Category.class, "c"))
                .registerRowMapper(BeanMapper.factory(Brand.class, "b"))
                .registerRowMapper(BeanMapper.factory(ProductImage.class, "pi"))
                .registerRowMapper(BeanMapper.factory(ProductColor.class, "pc"))
                .reduceRows(new LinkedHashMap<Integer, Product>(), (map, row) -> {
                    Product product = map.computeIfAbsent(row.getColumn("p_id", Integer.class), _ -> row.getRow(Product.class));

                    if (row.getColumn("c_id", Integer.class) != null) {
                        product.setCategory(row.getRow(Category.class));
                    }

                    if (row.getColumn("b_id", Integer.class) != null) {
                        product.setBrand(row.getRow(Brand.class));
                    }

                    if (row.getColumn("pi_id", Integer.class) != null) {
                        ProductImage image = row.getRow(ProductImage.class);
                        if (product.getImages().stream().noneMatch(img -> img.getId() == image.getId())) {
                            product.addImage(image); // Chỉ thêm nếu chưa tồn tại
                        }
                    }

                    if (row.getColumn("pc_id", Integer.class) != null) {
                        ProductColor color = row.getRow(ProductColor.class);
                        if (product.getColors().stream().noneMatch(col -> col.getId() == color.getId())) {
                            product.addColor(color); // Chỉ thêm nếu chưa tồn tại
                        }
                    }

                    return map;
                })
                .values()
                .stream()
                .toList());
    }

}
