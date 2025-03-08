package com.drumstore.web.repositories;

import com.drumstore.web.dto.*;
import com.drumstore.web.models.*;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;

public class ProductRepository extends BaseRepository<Product> {
    private final Jdbi jdbi;

    public ProductRepository() {
        this.jdbi = DBConnection.getJdbi();
    }

    public List<Product> all() {
        return new ArrayList<>();
//        String sql = """
//                    SELECT
//                        p.id AS p_id, p.name AS p_name, p.price AS p_price, p.description as p_description,
//                        p.stock as p_stock, p.createdAt as p_createdAt,
//                        c.id AS c_id, c.name AS c_name,
//                        b.id AS b_id, b.name AS b_name,
//                        i.id AS i_id, i.image AS i_image, i.isMain AS i_isMain
//                    FROM products p
//                             LEFT JOIN categories c ON p.categoryId = c.id
//                             LEFT JOIN brands b ON p.brandId = b.id
//                             LEFT JOIN product_images i ON p.id = i.productId AND i.isMain = 1
//                """;
//
//        return jdbi.withHandle(handle -> handle.createQuery(sql).registerRowMapper(BeanMapper.factory(Product.class, "p")).registerRowMapper(BeanMapper.factory(Category.class, "c")).registerRowMapper(BeanMapper.factory(ProductImage.class, "i")).registerRowMapper(BeanMapper.factory(Brand.class, "b")).reduceRows(new LinkedHashMap<Integer, Product>(), (map, row) -> {
//            Product product = map.computeIfAbsent(row.getColumn("p_id", Integer.class), _ -> row.getRow(Product.class));
//            if (row.getColumn("c_id", Integer.class) != null) {
//                product.setCategory(row.getRow(Category.class));
//            }
//            if (row.getColumn("i_id", Integer.class) != null) {
//                product.setImages(List.of(row.getRow(ProductImage.class)));
//            }
//            if (row.getColumn("b_id", Integer.class) != null) {
//                product.setBrand(row.getRow(Brand.class));
//            }
//            return map;
//        }).values().stream().toList());
    }

    public Product findById(int id) {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT * FROM products WHERE id = :id")
                .bind("id", id).mapToBean(Product.class).findFirst().orElse(null));
    }

    public void save(Product product) {
        jdbi.useHandle(handle -> handle.createUpdate("""
                INSERT INTO products (name, description, price, stock, total_views, is_feature, status,
                average_rating, category_id, brand_id, created_at) VALUES (:name, :description,
                :price, :stock, :total_views, :is_feature, :status, :average_rating, :categoryId,
                :brandId, CURRENT_TIMESTAMP)
                """
        ).bindBean(product).execute());
    }

    public void update(Product product) {
        jdbi.useHandle(handle -> handle.createUpdate("""
                UPDATE products SET name = :name, description = :description, price = :price, stock = :stock,
                isFeatured = :isFeatured, status = :status WHERE id = :id
                """
        ).bindBean(product).execute());
    }

    public void delete(int id) {
        jdbi.useHandle(handle -> handle.createUpdate("DELETE FROM products WHERE id = :id").bind("id", id).execute());
    }

    public Product find(int id) {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT * FROM products WHERE id = :id").bind("id", id)
                .mapToBean(Product.class).findFirst().orElse(null));
    }

    public Product show(int id) {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT * FROM products WHERE id = :id")
                .bind("id", id).mapToBean(Product.class).findFirst().orElse(null));
    }

    public Product findWithDetails(int id) {
        String sql = """
                    SELECT
                        p.id AS p_id, p.name AS p_name, p.description AS p_description,
                        p.price AS p_price, p.stock AS p_stock, p.totalViews AS p_totalViews,
                        p.isFeatured AS p_isFeatured, p.status AS p_status, p.averageRating AS p_averageRating,
                        p.createdAt AS p_createdAt,
                        pi.id AS pi_id, pi.image AS pi_image, pi.isMain AS pi_isMain,
                        pc.id AS pc_id, pc.colorCode AS pc_colorCode, pc.colorName AS pc_colorName,
                        c.id AS c_id, c.name AS c_name, c.image AS c_image, c.description AS c_description,
                        c.createdAt AS c_createdAt,
                        b.id AS b_id, b.name AS b_name, b.image AS b_image, b.description AS b_description,
                        b.createdAt AS b_createdAt
                    FROM products p
                        LEFT JOIN product_images pi ON p.id = pi.productId
                        LEFT JOIN product_colors pc ON p.id = pc.productId
                        LEFT JOIN categories c ON p.categoryId = c.id
                        LEFT JOIN brands b ON p.brandId = b.id
                    WHERE p.id = :id;
                """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .registerRowMapper(BeanMapper.factory(Product.class, "p"))
                        .registerRowMapper(BeanMapper.factory(ProductImage.class, "pi"))
                        .registerRowMapper(BeanMapper.factory(ProductColor.class, "pc"))
                        .registerRowMapper(BeanMapper.factory(Category.class, "c"))
                        .registerRowMapper(BeanMapper.factory(Brand.class, "b"))
                        .reduceRows(new LinkedHashMap<Integer, Product>(), (map, row) -> {
                            Product product = map.computeIfAbsent(row.getColumn("p_id", Integer.class), _ -> row.getRow(Product.class));

                            // Map ProductImage
                            if (row.getColumn("pi_id", Integer.class) != null) {
                                ProductImage image = row.getRow(ProductImage.class);
                                if (product.getImages().stream().noneMatch(img -> img.getId() == image.getId())) {
                                    product.addImage(row.getRow(ProductImage.class));
                                }
                            }

                            // Map ProductColor
                            if (row.getColumn("pc_id", Integer.class) != null) {
                                ProductColor color = row.getRow(ProductColor.class);
                                if (product.getColors().stream().noneMatch(cl -> cl.getId() == color.getId())) {
                                    product.addColor(row.getRow(ProductColor.class));
                                }
                            }

                            // Map Category
                            if (row.getColumn("c_id", Integer.class) != null && product.getCategory() == null) {
                                product.setCategory(row.getRow(Category.class));
                            }

                            // Map Brand
                            if (row.getColumn("b_id", Integer.class) != null && product.getBrand() == null) {
                                product.setBrand(row.getRow(Brand.class));
                            }

                            return map;
                        }).values().stream().findFirst().orElse(null)
        );

    }

    public List<ProductCardDTO> getFeaturedProducts(int limit) {
        String sql = """
                SELECT
                    p.id,
                    p.name,
                    p.price AS originalPrice,
                    p.stock,
                    p.averageRating,
                    pi.image AS mainImage,
                    c.id AS categoryId,
                    c.name AS categoryName,
                    b.id AS brandId,
                    b.name AS brandName,
                    (SELECT MAX(s.discountPercentage)
                     FROM product_sales ps
                     JOIN sales s ON ps.saleId = s.id
                     WHERE ps.productId = p.id
                     AND NOW() BETWEEN s.startDate AND s.endDate) AS discountPercent
                FROM products p
                LEFT JOIN (
                    SELECT productId, image
                    FROM product_images
                    WHERE isMain = true
                ) pi ON p.id = pi.productId
                LEFT JOIN categories c ON p.categoryId = c.id
                LEFT JOIN brands b ON p.brandId = b.id
                WHERE p.isFeatured = true
                ORDER BY p.createdAt DESC
                LIMIT :limit
                """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("limit", limit)
                        .map((rs, ctx) -> {
                            ProductCardDTO dto = new ProductCardDTO();
                            dto.setId(rs.getInt("id"));
                            dto.setName(rs.getString("name"));
                            dto.setMainImage(rs.getString("mainImage"));
                            dto.setOriginalPrice(rs.getDouble("originalPrice"));
                            dto.setStock(rs.getInt("stock"));
                            dto.setAverageRating(rs.getDouble("averageRating"));
                            dto.setCategoryId(rs.getInt("categoryId"));
                            dto.setCategoryName(rs.getString("categoryName"));
                            dto.setBrandId(rs.getInt("brandId"));
                            dto.setBrandName(rs.getString("brandName"));

                            Double discountPercent = rs.getObject("discountPercent", Double.class);
                            if (discountPercent != null) {
                                dto.setDiscountPercent(discountPercent);
                                dto.setSalePrice(dto.getOriginalPrice() * (1 - discountPercent / 100));
                            }

                            return dto;
                        })
                        .list()
        );
    }


    public List<Product> getLatestProducts(int limit) {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT * FROM products ORDER BY createdAt DESC LIMIT :limit").bind("limit", limit).mapToBean(Product.class).list());
    }

    public List<Product> allWithDetails() {
        return new ArrayList<>();
//        String sql = """
//                SELECT
//                    p.id AS p_id, p.name AS p_name, p.description AS p_description,
//                    p.price AS p_price, p.stock AS p_stock, p.totalViews AS p_totalViews,
//                    p.isFeatured AS p_isFeatured, p.status AS p_status,
//                    p.averageRating AS p_averageRating,
//                    p.categoryId AS p_categoryId, p.brandId AS p_brandId,
//                    p.createdAt AS p_createdAt,
//
//                    c.id AS c_id, c.name AS c_name, c.image AS c_image, c.description AS c_description,
//                    c.createdAt AS c_createdAt,
//
//                    b.id AS b_id, b.name AS b_name, b.image AS b_image, b.description AS b_description,
//                    b.createdAt AS b_createdAt,
//
//                    pi.id AS pi_id, pi.productId AS pi_productId, pi.image AS pi_image, pi.isMain AS pi_isMain,
//
//                    pc.id AS pc_id, pc.colorCode AS pc_colorCode, pc.colorName AS pc_colorName
//                FROM products p
//                         LEFT JOIN categories c ON p.categoryId = c.id
//                         LEFT JOIN brands b ON p.brandId = b.id
//                         LEFT JOIN product_images pi ON p.id = pi.productId
//                         LEFT JOIN product_colors pc ON p.id = pc.productId
//
//                """;
//
//        return jdbi.withHandle(handle -> handle.createQuery(sql).registerRowMapper(BeanMapper.factory(Product.class, "p")).registerRowMapper(BeanMapper.factory(Category.class, "c")).registerRowMapper(BeanMapper.factory(Brand.class, "b")).registerRowMapper(BeanMapper.factory(ProductImage.class, "pi")).registerRowMapper(BeanMapper.factory(ProductColor.class, "pc")).reduceRows(new LinkedHashMap<Integer, Product>(), (map, row) -> {
//            Product product = map.computeIfAbsent(row.getColumn("p_id", Integer.class), _ -> row.getRow(Product.class));
//
//            if (row.getColumn("c_id", Integer.class) != null) {
//                product.setCategory(row.getRow(Category.class));
//            }
//
//            if (row.getColumn("b_id", Integer.class) != null) {
//                product.setBrand(row.getRow(Brand.class));
//            }
//
//            if (row.getColumn("pi_id", Integer.class) != null) {
//                ProductImage image = row.getRow(ProductImage.class);
//                if (product.getImages().stream().noneMatch(img -> img.getId() == image.getId())) {
//                    product.addImage(image); // Chỉ thêm nếu chưa tồn tại
//                }
//            }
//
//            if (row.getColumn("pc_id", Integer.class) != null) {
//                ProductColor color = row.getRow(ProductColor.class);
//                if (product.getColors().stream().noneMatch(col -> col.getId() == color.getId())) {
//                    product.addColor(color); // Chỉ thêm nếu chưa tồn tại
//                }
//            }
//
//            return map;
//        }).values().stream().toList());
    }

    public int countFilteredProducts(String search, String category, String brand, String priceRange) {
        StringBuilder sql = new StringBuilder("""
                    SELECT COUNT(*) FROM products p
                    WHERE 1=1
                """);
        List<Object> params = new ArrayList<>();

        // Thêm điều kiện tìm kiếm
        if (search != null && !search.isEmpty()) {
            sql.append(" AND (p.name LIKE ? OR p.description LIKE ?)");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }

        // Thêm điều kiện category
        if (category != null && !category.isEmpty()) {
            sql.append(" AND p.categoryId = ?");
            params.add(Integer.parseInt(category));
        }

        // Thêm điều kiện brand
        if (brand != null && !brand.isEmpty()) {
            sql.append(" AND p.brandId = ?");
            params.add(Integer.parseInt(brand));
        }

        // Thêm điều kiện khoảng giá
        if (priceRange != null && !priceRange.isEmpty()) {
            String[] prices = priceRange.split("-");
            if (prices.length == 2) {
                sql.append(" AND p.price BETWEEN ? AND ?");
                params.add(Double.parseDouble(prices[0]));
                params.add(Double.parseDouble(prices[1]));
            }
        }

        return jdbi.withHandle(handle -> {
            var query = handle.createQuery(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                query.bind(i, params.get(i));
            }
            return query.mapTo(Integer.class).one();
        });
    }

//    public List<Product> getRelatedProducts(int productId, int categoryId, int limit) {
//        String sql = """
//                    SELECT
//                        p.*,
//                        pi.id AS pi_id,
//                        pi.image AS pi_image,
//                        pi.isMain AS pi_isMain,
//                        c.id AS c_id,
//                        c.name AS c_name,
//                        b.id AS b_id,
//                        b.name AS b_name,
//                        s.id AS s_id,
//                        s.name AS s_name,
//                        s.discountPercentage AS s_discountPercentage,
//                        s.startDate AS s_startDate,
//                        s.endDate AS s_endDate
//                    FROM products p
//                    LEFT JOIN product_images pi ON p.id = pi.productId
//                    LEFT JOIN categories c ON p.categoryId = c.id
//                    LEFT JOIN brands b ON p.brandId = b.id
//                    LEFT JOIN product_sales ps ON p.id = ps.productId
//                    LEFT JOIN sales s ON ps.saleId = s.id AND NOW() BETWEEN s.startDate AND s.endDate
//                    WHERE p.categoryId = ? AND p.id != ?
//                    ORDER BY RAND()
//                    LIMIT ?
//                """;
//
//        return jdbi.withHandle(handle -> handle.createQuery(sql)
//                .bind(0, categoryId)
//                .bind(1, productId)
//                .bind(2, limit)
//                .registerRowMapper(BeanMapper.factory(Product.class))
//                .registerRowMapper(BeanMapper.factory(ProductImage.class, "pi"))
//                .registerRowMapper(BeanMapper.factory(Category.class, "c"))
//                .registerRowMapper(BeanMapper.factory(Brand.class, "b"))
//                .registerRowMapper(BeanMapper.factory(Sale.class, "s"))
//                .reduceRows(new LinkedHashMap<Integer, Product>(), (map, row) -> {
//                    Product product = map.computeIfAbsent(
//                            row.getColumn("id", Integer.class),
//                            id -> row.getRow(Product.class)
//                    );
//
//                    if (row.getColumn("pi_id", Integer.class) != null) {
//                        product.addImage(row.getRow(ProductImage.class));
//                    }
//
//                    if (row.getColumn("c_id", Integer.class) != null) {
//                        product.setCategory(row.getRow(Category.class));
//                    }
//
//                    if (row.getColumn("b_id", Integer.class) != null) {
//                        product.setBrand(row.getRow(Brand.class));
//                    }
//
//                    if (row.getColumn("s_id", Integer.class) != null) {
//                        Sale sale = row.getRow(Sale.class);
//                        ProductSale productSale = new ProductSale();
//                        productSale.setSale(sale);
//                        product.setProductSale(productSale);
//                    }
//
//                    return map;
//                })
//                .values()
//                .stream()
//                .toList());
//    }

    public ProductSale getCurrentSale(int productId) {
        String sql = """
                    SELECT 
                        ps.id AS ps_id,
                        ps.productId AS ps_productId,
                        ps.saleId AS ps_saleId,
                        s.id AS s_id,
                        s.name AS s_name,
                        s.discountPercentage AS s_discountPercentage,
                        s.startDate AS s_startDate,
                        s.endDate AS s_endDate
                    FROM product_sales ps
                    JOIN sales s ON ps.saleId = s.id
                    WHERE ps.productId = ? 
                    AND NOW() BETWEEN s.startDate AND s.endDate
                    AND s.discountPercentage = (
                        SELECT MAX(s2.discountPercentage)
                        FROM product_sales ps2
                        JOIN sales s2 ON ps2.saleId = s2.id
                        WHERE ps2.productId = ps.productId
                        AND NOW() BETWEEN s2.startDate AND s2.endDate
                    )
                """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind(0, productId)
                        .registerRowMapper(BeanMapper.factory(ProductSale.class, "ps"))
                        .registerRowMapper(BeanMapper.factory(Sale.class, "s"))
                        .reduceRows(new LinkedHashMap<Integer, ProductSale>(), (map, row) -> {
                            ProductSale productSale = map.computeIfAbsent(
                                    row.getColumn("ps_id", Integer.class),
                                    id -> row.getRow(ProductSale.class)
                            );

                            if (row.getColumn("s_id", Integer.class) != null) {
                                Sale sale = row.getRow(Sale.class);
                                productSale.setSale(sale);
                            }

                            return map;
                        })
                        .values()
                        .stream()
                        .findFirst()
                        .orElse(null)
        );
    }

    public List<ProductCardDTO> getFilteredProductCards(int offset, int limit, String search, String category, String brand, String priceRange, String sortBy) {
        StringBuilder sql = new StringBuilder("""
                WITH FilteredProducts AS (
                    SELECT
                        p.id AS p_id,
                        p.name AS p_name,
                        p.price AS p_price,
                        p.stock AS p_stock,
                        p.averageRating AS p_averageRating,
                        p.categoryId AS p_categoryId,
                        p.brandId AS p_brandId,
                        (SELECT MAX(s.discountPercentage)
                         FROM product_sales ps
                         JOIN sales s ON ps.saleId = s.id
                         WHERE ps.productId = p.id
                         AND NOW() BETWEEN s.startDate AND s.endDate) AS max_discount
                    FROM products p
                    WHERE 1=1
                """);

        List<Object> params = new ArrayList<>();

        // Thêm các điều kiện tìm kiếm
        if (search != null && !search.isEmpty()) {
            sql.append(" AND (p.name LIKE ? OR p.description LIKE ?)");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }

        if (category != null && !category.isEmpty()) {
            sql.append(" AND p.categoryId = ?");
            params.add(Integer.parseInt(category));
        }

        if (brand != null && !brand.isEmpty()) {
            sql.append(" AND p.brandId = ?");
            params.add(Integer.parseInt(brand));
        }

        if (priceRange != null && !priceRange.isEmpty()) {
            String[] prices = priceRange.split("-");
            if (prices.length == 2) {
                sql.append(" AND p.price BETWEEN ? AND ?");
                params.add(Double.parseDouble(prices[0]));
                params.add(Double.parseDouble(prices[1]));
            }
        }

        // Thêm ORDER BY và LIMIT
        if (sortBy != null && !sortBy.isEmpty()) {
            switch (sortBy) {
                case "name_asc" -> sql.append(" ORDER BY p.name ASC");
                case "name_desc" -> sql.append(" ORDER BY p.name DESC");
                case "price_asc" -> sql.append(" ORDER BY p.price ASC");
                case "price_desc" -> sql.append(" ORDER BY p.price DESC");
                default -> sql.append(" ORDER BY p.createdAt DESC");
            }
        } else {
            sql.append(" ORDER BY p.createdAt DESC");
        }

        sql.append(" LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        // JOIN với các bảng liên quan
        sql.append("""
                )
                SELECT
                    p.p_id AS id,
                    p.p_name AS name,
                    p.p_price AS originalPrice,
                    p.p_stock AS stock,
                    p.p_averageRating AS averageRating,
                    pi.image AS mainImage,
                    c.id AS categoryId,
                    c.name AS categoryName,
                    b.id AS brandId,
                    b.name AS brandName,
                    p.max_discount AS discountPercent
                FROM FilteredProducts p
                LEFT JOIN (
                    SELECT productId, image
                    FROM product_images
                    WHERE isMain = true
                ) pi ON p.p_id = pi.productId
                LEFT JOIN categories c ON p.p_categoryId = c.id
                LEFT JOIN brands b ON p.p_brandId = b.id
                """);
        return jdbi.withHandle(handle -> {
            var query = handle.createQuery(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                query.bind(i, params.get(i));
            }

            return query.map((rs, ctx) -> {
                ProductCardDTO dto = new ProductCardDTO();
                dto.setId(rs.getInt("id"));
                dto.setName(rs.getString("name"));
                dto.setMainImage(rs.getString("mainImage"));
                dto.setOriginalPrice(rs.getDouble("originalPrice"));
                dto.setStock(rs.getInt("stock"));
                dto.setAverageRating(rs.getDouble("averageRating"));
                dto.setCategoryId(rs.getInt("categoryId"));
                dto.setCategoryName(rs.getString("categoryName"));
                dto.setBrandId(rs.getInt("brandId"));
                dto.setBrandName(rs.getString("brandName"));

                Double discountPercent = rs.getObject("discountPercent", Double.class);
                if (discountPercent != null) {
                    dto.setDiscountPercent(discountPercent);
                    dto.setSalePrice(dto.getOriginalPrice() * (1 - discountPercent / 100));
                }

                return dto;
            }).list();
        });
    }

//    public ProductDetailDTO findProductDetail(int id) {
//        String sql = """
//                SELECT
//                    p.id AS p_id,
//                    p.name AS p_name,
//                    p.description AS p_description,
//                    p.price AS p_price,
//                    p.stock AS p_stock,
//                    p.totalViews AS p_totalViews,
//                    p.isFeatured AS p_isFeatured,
//                    p.status AS p_status,
//                    p.averageRating AS p_averageRating,
//                    p.createdAt AS p_createdAt,
//                    pi.id AS pi_id,
//                    pi.image AS pi_image,
//                    pi.isMain AS pi_isMain,
//                    pc.id AS pc_id,
//                    pc.colorCode AS pc_code,
//                    pc.colorName AS pc_name,
//                    c.id AS c_id,
//                    c.name AS c_name,
//                    c.image AS c_image,
//                    c.description AS c_description,
//                    b.id AS b_id,
//                    b.name AS b_name,
//                    b.image AS b_image,
//                    b.description AS b_description,
//                    s.id AS s_id,
//                    s.name AS s_name,
//                    s.discountPercentage AS s_discountPercentage,
//                    s.startDate AS s_startDate,
//                    s.endDate AS s_endDate,
//                    CASE
//                        WHEN s.discountPercentage IS NOT NULL
//                        THEN p.price * (1 - s.discountPercentage/100)
//                        ELSE p.price
//                    END AS p_salePrice,
//                    COALESCE(s.discountPercentage, 0) AS p_discountPercent
//                FROM products p
//                LEFT JOIN product_images pi ON p.id = pi.productId
//                LEFT JOIN product_colors pc ON p.id = pc.productId
//                LEFT JOIN categories c ON p.categoryId = c.id
//                LEFT JOIN brands b ON p.brandId = b.id
//                LEFT JOIN product_sales ps ON p.id = ps.productId
//                LEFT JOIN sales s ON ps.saleId = s.id
//                    AND NOW() BETWEEN s.startDate AND s.endDate
//                WHERE p.id = :id
//                """;
//
//        return jdbi.withHandle(handle -> handle.createQuery(sql)
//                .bind("id", id)
//                .registerRowMapper(BeanMapper.factory(ProductDetailDTO.class, "p"))
//                .registerRowMapper(BeanMapper.factory(ProductImageDTO.class, "pi"))
//                .registerRowMapper(BeanMapper.factory(ProductColorDTO.class, "pc"))
//                .registerRowMapper(BeanMapper.factory(CategoryDTO.class, "c"))
//                .registerRowMapper(BeanMapper.factory(BrandDTO.class, "b"))
//                .registerRowMapper(BeanMapper.factory(ProductSaleDTO.class, "s"))
//                .reduceRows(new LinkedHashMap<Integer, ProductDetailDTO>(), (map, row) -> {
//                    ProductDetailDTO product = map.computeIfAbsent(
//                            row.getColumn("p_id", Integer.class),
//                            _ -> {
//                                ProductDetailDTO dto = row.getRow(ProductDetailDTO.class);
//                                dto.setImages(new ArrayList<>());
//                                dto.setColors(new ArrayList<>());
//                                dto.setSales(new ArrayList<>());
//                                return dto;
//                            }
//                    );
//
//                    // Map ProductImage
//                    if (row.getColumn("pi_id", Integer.class) != null) {
//                        ProductImageDTO image = row.getRow(ProductImageDTO.class);
//                        if (image.isIsMain()) {
//                            product.setMainImage(image.getImage());
//                        }
//                        if (product.getImages().stream()
//                                .noneMatch(img -> img.getId() == image.getId())) {
//                            product.getImages().add(image);
//                        }
//                    }
//
//                    // Map ProductColor
//                    if (row.getColumn("pc_id", Integer.class) != null) {
//                        ProductColorDTO color = row.getRow(ProductColorDTO.class);
//                        if (product.getColors().stream()
//                                .noneMatch(c -> c.getId() == color.getId())) {
//                            product.getColors().add(color);
//                        }
//                    }
//
//                    // Map Category
//                    if (row.getColumn("c_id", Integer.class) != null && product.getCategory() == null) {
//                        product.setCategory(row.getRow(CategoryDTO.class));
//                    }
//
//                    // Map Brand
//                    if (row.getColumn("b_id", Integer.class) != null && product.getBrand() == null) {
//                        product.setBrand(row.getRow(BrandDTO.class));
//                    }
//
//                    // Map Sale
//                    if (row.getColumn("s_id", Integer.class) != null) {
//                        ProductSaleDTO sale = row.getRow(ProductSaleDTO.class);
//                        if (product.getSales().stream()
//                                .noneMatch(s -> s.getSaleId() == sale.getSaleId())) {
//                            product.getSales().add(sale);
//                        }
//                    }
//
//                    return map;
//                })
//                .values()
//                .stream()
//                .findFirst()
//                .orElse(null)
//        );
//    }

    public void incrementViewCount(int id) {
    }

    public List<ProductCardDTO> getRelatedProductCards(int productId, int categoryId, int limit) {
        String sql = """
                    SELECT
                        p.id,
                        p.name,
                        p.price AS originalPrice,
                        p.stock,
                        p.averageRating,
                        pi.image AS mainImage,
                        c.id AS categoryId,
                        c.name AS categoryName,
                        b.id AS brandId,
                        b.name AS brandName,
                        (SELECT MAX(s.discountPercentage)
                         FROM product_sales ps
                         JOIN sales s ON ps.saleId = s.id
                         WHERE ps.productId = p.id
                         AND NOW() BETWEEN s.startDate AND s.endDate) AS discountPercent
                    FROM products p
                    LEFT JOIN (
                        SELECT productId, image
                        FROM product_images
                        WHERE isMain = true
                    ) pi ON p.id = pi.productId
                    LEFT JOIN categories c ON p.categoryId = c.id
                    LEFT JOIN brands b ON p.brandId = b.id
                    WHERE p.categoryId = :categoryId 
                    AND p.id != :productId
                    ORDER BY RAND()
                    LIMIT :limit
                """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("categoryId", categoryId)
                        .bind("productId", productId)
                        .bind("limit", limit)
                        .map((rs, ctx) -> {
                            ProductCardDTO dto = new ProductCardDTO();
                            dto.setId(rs.getInt("id"));
                            dto.setName(rs.getString("name"));
                            dto.setMainImage(rs.getString("mainImage"));
                            dto.setOriginalPrice(rs.getDouble("originalPrice"));
                            dto.setStock(rs.getInt("stock"));
                            dto.setAverageRating(rs.getDouble("averageRating"));
                            dto.setCategoryId(rs.getInt("categoryId"));
                            dto.setCategoryName(rs.getString("categoryName"));
                            dto.setBrandId(rs.getInt("brandId"));
                            dto.setBrandName(rs.getString("brandName"));

                            Double discountPercent = rs.getObject("discountPercent", Double.class);
                            if (discountPercent != null) {
                                dto.setDiscountPercent(discountPercent);
                                dto.setSalePrice(dto.getOriginalPrice() * (1 - discountPercent / 100));
                            }

                            return dto;
                        })
                        .list()
        );
    }

    public ProductDetailDTO2 findProductDetail(int id) {
        String sql = """
            SELECT
                p.id AS p_id,
                p.name AS p_name,
                p.description AS p_description,
                p.basePrice AS p_basePrice,
                p.stock AS p_stock,
                p.hasColorOptions AS p_hasColorOptions,
                p.hasAddonOptions AS p_hasAddonOptions,
                p.totalViews AS p_totalViews,
                p.isFeatured AS p_isFeatured,
                p.status AS p_status,
                (SELECT AVG(rating) FROM product_reviews WHERE productId = p.id AND status = 1) AS p_averageRating,
                (SELECT COUNT(*) FROM product_reviews WHERE productId = p.id AND status = 1) AS p_totalReviews,
                p.createdAt AS p_createdAt,
                pi.id AS pi_id,
                pi.image AS pi_image,
                pi.isMain AS pi_isMain,
                pi.sortOrder AS pi_sortOrder,
                pc.id AS pc_id,
                pc.name AS pc_name,
                pc.code AS pc_code,
                pc.image AS pc_image,
                pc.additionalPrice AS pc_additionalPrice,
                pc.stock AS pc_stock,
                pc.status AS pc_status,
                pc.sort_order AS pc_sortOrder,
                pa.id AS pa_id,
                pa.name AS pa_name,
                pa.description AS pa_description,
                pa.additionalPrice AS pa_additionalPrice,
                pa.stock AS pa_stock,
                pa.status AS pa_status,
                pa.isDefault AS pa_isDefault,
                pa.sortOrder AS pa_sortOrder,
                pr.id AS pr_id,
                pr.userId AS pr_userId,
                pr.orderId AS pr_orderId,
                pr.rating AS pr_rating,
                pr.content AS pr_content,
                pr.status AS pr_status,
                pr.createdAt AS pr_createdAt,
                u.fullname AS pr_userName,
                u.avatar AS pr_userAvatar,
                c.id AS c_id,
                c.name AS c_name,
                b.id AS b_id,
                b.name AS b_name,
                s.id AS s_id,
                s.name AS s_name,
                s.discountPercentage AS s_discountPercentage,
                s.startDate AS s_startDate,
                s.endDate AS s_endDate,
                CASE
                    WHEN s.discountPercentage IS NOT NULL
                    THEN p.basePrice * (1 - s.discountPercentage/100)
                    ELSE p.basePrice
                END AS p_salePrice,
                COALESCE(s.discountPercentage, 0) AS p_discountPercent
            FROM products p
            LEFT JOIN product_images pi ON p.id = pi.productId
            LEFT JOIN product_colors pc ON p.id = pc.productId
            LEFT JOIN product_addons pa ON p.id = pa.productId
            LEFT JOIN product_reviews pr ON p.id = pr.productId
            LEFT JOIN users u ON pr.userId = u.id
            LEFT JOIN categories c ON p.categoryId = c.id
            LEFT JOIN brands b ON p.brandId = b.id
            LEFT JOIN product_sales ps ON p.id = ps.productId
            LEFT JOIN sales s ON ps.saleId = s.id
                AND NOW() BETWEEN s.startDate AND s.endDate
            WHERE p.id = :id
            """;

        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind("id", id)
                    .registerRowMapper(BeanMapper.factory(ProductDetailDTO2.class, "p"))
                    .registerRowMapper(BeanMapper.factory(ProductImageDTO2.class, "pi"))
                    .registerRowMapper(BeanMapper.factory(ProductColorDTO2.class, "pc"))
                    .registerRowMapper(BeanMapper.factory(ProductAddonDTO.class, "pa"))
                    .registerRowMapper(BeanMapper.factory(ProductReviewDTO.class, "pr"))
                    .registerRowMapper(BeanMapper.factory(ProductSaleDTO2.class, "s"))
                    .reduceRows(new LinkedHashMap<Integer, ProductDetailDTO2>(), (map, row) -> {
                        ProductDetailDTO2 dto = map.computeIfAbsent(
                                row.getColumn("p_id", Integer.class),
                                _ -> {
                                    ProductDetailDTO2 newDto = row.getRow(ProductDetailDTO2.class);
                                    newDto.setImages(new ArrayList<>());
                                    newDto.setColors(new ArrayList<>());
                                    newDto.setAddons(new ArrayList<>());
                                    newDto.setReviews(new ArrayList<>());
                                    newDto.setSales(new ArrayList<>());

                                    newDto.setCategoryId(row.getColumn("c_id", Integer.class));
                                    newDto.setCategoryName(row.getColumn("c_name", String.class));
                                    newDto.setBrandId(row.getColumn("b_id", Integer.class));
                                    newDto.setBrandName(row.getColumn("b_name", String.class));

                                    return newDto;
                                }
                        );

                        if (row.getColumn("pi_id", Integer.class) != null) {
                            ProductImageDTO2 image = row.getRow(ProductImageDTO2.class);
                            if (image.isMain()) {
                                dto.setMainImage(image.getImage());
                            }
                            if (dto.getImages().stream()
                                    .noneMatch(img -> img.getId() == image.getId())) {
                                dto.getImages().add(image);
                            }
                        }

                        if (row.getColumn("pc_id", Integer.class) != null) {
                            ProductColorDTO2 color = row.getRow(ProductColorDTO2.class);
                            if (dto.getColors().stream()
                                    .noneMatch(c -> c.getId() == color.getId())) {
                                List<String> colorImages = handle.createQuery(
                                                "SELECT image FROM product_color_images WHERE colorId = :colorId ORDER BY sortOrder")
                                        .bind("colorId", color.getId())
                                        .mapTo(String.class)
                                        .list();
                                color.setImages(colorImages);
                                dto.getColors().add(color);
                            }
                        }

                        if (row.getColumn("pa_id", Integer.class) != null) {
                            ProductAddonDTO addon = row.getRow(ProductAddonDTO.class);
                            if (dto.getAddons().stream()
                                    .noneMatch(a -> a.getId() == addon.getId())) {
                                List<String> addonImages = handle.createQuery(
                                                "SELECT image FROM product_addon_images WHERE addonId = :addonId ORDER BY sortOrder")
                                        .bind("addonId", addon.getId())
                                        .mapTo(String.class)
                                        .list();
                                addon.setImages(addonImages);
                                dto.getAddons().add(addon);
                            }
                        }

                        if (row.getColumn("pr_id", Integer.class) != null) {
                            ProductReviewDTO review = row.getRow(ProductReviewDTO.class);
                            if (dto.getReviews().stream()
                                    .noneMatch(r -> r.getId() == review.getId())) {
                                List<String> reviewImages = handle.createQuery(
                                                "SELECT image FROM review_images WHERE reviewId = :reviewId ORDER BY sortOrder")
                                        .bind("reviewId", review.getId())
                                        .mapTo(String.class)
                                        .list();
                                review.setImages(reviewImages);
                                dto.getReviews().add(review);
                            }
                        }
                        if (row.getColumn("s_id", Integer.class) != null) {
                            ProductSaleDTO2 sale = row.getRow(ProductSaleDTO2.class);
                            if (dto.getSales().stream()
                                    .noneMatch(s -> s.getId() == sale.getId())) {
                                dto.getSales().add(sale);
                            }
                        }
                        return map;
                    })
                    .values()
                    .stream()
                    .findFirst()
                    .orElse(null);
        });
    }
}
