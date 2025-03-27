package com.drumstore.web.repositories;

import com.drumstore.web.dto.*;
import com.drumstore.web.models.*;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.util.*;

public class ProductRepository {
    private final Jdbi jdbi;

    public ProductRepository() {
        this.jdbi = DBConnection.getJdbi();
    }

    public List<ProductDashboardDTO> all() {
        String sql = """
                    SELECT
                        p.id,
                        p.name,
                        p.basePrice,
                        c.name AS categoryName,
                        b.name AS brandName,
                        p.totalViews,
                        p.isFeatured,
                        p.status,
                        COALESCE(pv.total_stock, 0) as stock,
                        COALESCE(pc.total_colors, 0) as totalColors,
                        COALESCE(pa.total_addons, 0) as totalAddons,
                        COALESCE(pv.total_variants, 0) as totalVariants,
                        COALESCE(pr.total_reviews, 0) as totalReviews,
                        COALESCE(pr.avg_rating, 0) as avgRating,
                        (
                            SELECT image
                            FROM product_images
                            WHERE productId = p.id AND isMain = 1
                            LIMIT 1
                        ) as mainImage,
                        p.createdAt
                    FROM products p
                    LEFT JOIN categories c ON p.categoryId = c.id
                    LEFT JOIN brands b ON p.brandId = b.id
                    LEFT JOIN (
                        SELECT productId, COUNT(*) as total_colors
                        FROM product_colors
                        GROUP BY productId
                    ) pc ON p.id = pc.productId
                    LEFT JOIN (
                        SELECT productId, COUNT(*) as total_addons
                        FROM product_addons
                        GROUP BY productId
                    ) pa ON p.id = pa.productId
                    LEFT JOIN (
                        SELECT
                            productId,
                            COUNT(*) as total_variants,
                            SUM(stock) as total_stock
                        FROM product_variants
                        WHERE status = 1
                        GROUP BY productId
                    ) pv ON p.id = pv.productId
                    LEFT JOIN (
                        SELECT
                            productId,
                            COUNT(*) as total_reviews,
                            AVG(rating) as avg_rating
                        FROM product_reviews
                        WHERE status = 1
                        GROUP BY productId
                    ) pr ON p.id = pr.productId
                """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(ProductDashboardDTO.class)
                        .list()
        );
    }

    public ProductDashboardDetailDTO findById(int id) {
        String sql = """
                WITH ProductColors AS (
                    SELECT * FROM product_colors WHERE productId = :id
                ),
                ProductAddons AS (
                    SELECT * FROM product_addons WHERE productId = :id
                ),
                MaxDiscount AS (
                    SELECT productId, MAX(s.discountPercentage) as maxDiscount
                    FROM product_sales ps
                    JOIN sales s ON ps.saleId = s.id
                    WHERE NOW() BETWEEN s.startDate AND s.endDate
                    GROUP BY productId
                )
                SELECT
                    p.id AS p_id,
                    p.name AS p_name,
                    p.description AS p_description,
                    p.basePrice AS p_basePrice,
                    p.totalViews AS p_totalViews,
                    p.isFeatured AS p_isFeatured,
                    p.status AS p_status,
                    p.stockManagementType AS p_stockManagementType,
                    (SELECT AVG(rating) FROM product_reviews WHERE productId = p.id AND status = 1) AS p_averageRating,
                    (SELECT COUNT(*) FROM product_reviews WHERE productId = p.id AND status = 1) AS p_totalReviews,
                    COALESCE((SELECT SUM(stock) FROM product_variants WHERE productId = p.id AND status = 1), 0) AS p_totalStock,
                    COALESCE((SELECT COUNT(*) FROM product_variants WHERE productId = p.id AND status = 1), 0) AS p_totalVariants,
                    p.createdAt AS p_createdAt,
                    pi.id AS pi_id,
                    pi.image AS pi_image,
                    pi.isMain AS pi_isMain,
                    pi.sortOrder AS pi_sortOrder,
                    pc.id AS pc_id,
                    pc.name AS pc_name,
                    pr.id AS pr_id,
                    pr.rating AS pr_rating,
                    pr.content AS pr_content,
                    pr.status AS pr_status,
                    pr.createdAt AS pr_createdAt,
                    c.name AS c_name,
                    b.name AS b_name,
                    s.id AS s_id,
                    s.name AS s_name,
                    s.discountPercentage AS s_discountPercentage,
                    s.startDate AS s_startDate,
                    s.endDate AS s_endDate
                FROM products p
                LEFT JOIN product_images pi ON p.id = pi.productId
                LEFT JOIN ProductColors pc ON p.id = pc.productId
                LEFT JOIN product_reviews pr ON p.id = pr.productId AND pr.status = 1
                LEFT JOIN categories c ON p.categoryId = c.id
                LEFT JOIN brands b ON p.brandId = b.id
                LEFT JOIN product_sales ps ON p.id = ps.productId
                LEFT JOIN sales s ON ps.saleId = s.id
                    AND NOW() BETWEEN s.startDate AND s.endDate
                WHERE p.id = :id""";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("id", id)
                .registerRowMapper(BeanMapper.factory(ProductDashboardDetailDTO.class, "p"))
                .registerRowMapper(BeanMapper.factory(ProductImageDTO.class, "pi"))
                .registerRowMapper(BeanMapper.factory(ProductColorDTO.class, "pc"))
                .registerRowMapper(BeanMapper.factory(ProductReviewDTO.class, "pr"))
                .registerRowMapper(BeanMapper.factory(ProductSaleDTO.class, "s"))
                .reduceRows(new LinkedHashMap<Integer, ProductDashboardDetailDTO>(), (map, row) -> {
                    ProductDashboardDetailDTO dto = map.computeIfAbsent(
                            row.getColumn("p_id", Integer.class),
                            _ -> {
                                ProductDashboardDetailDTO newDto = row.getRow(ProductDashboardDetailDTO.class);
                                newDto.setImages(new ArrayList<>());
                                newDto.setColors(new ArrayList<>());
                                newDto.setReviews(new ArrayList<>());
                                newDto.setSales(new ArrayList<>());

                                newDto.setCategoryName(row.getColumn("c_name", String.class));
                                newDto.setBrandName(row.getColumn("b_name", String.class));

                                return newDto;
                            }
                    );

                    // Map ProductImage
                    if (row.getColumn("pi_id", Integer.class) != null) {
                        ProductImageDTO image = row.getRow(ProductImageDTO.class);
                        if (dto.getImages().stream().noneMatch(img -> img.getId() == image.getId())) {
                            dto.getImages().add(image);
                        }
                    }

                    // Map ProductColor
                    if (row.getColumn("pc_id", Integer.class) != null) {
                        ProductColorDTO color = row.getRow(ProductColorDTO.class);
                        if (dto.getColors().stream().noneMatch(c -> c.getId() == color.getId())) {
                            dto.getColors().add(color);
                        }
                    }

                    // Map ProductReview
                    if (row.getColumn("pr_id", Integer.class) != null) {
                        ProductReviewDTO review = row.getRow(ProductReviewDTO.class);
                        if (dto.getReviews().stream().noneMatch(r -> r.getId() == review.getId())) {
                            dto.getReviews().add(review);
                        }
                    }

                    // Map Sale
                    if (row.getColumn("s_id", Integer.class) != null) {
                        ProductSaleDTO sale = row.getRow(ProductSaleDTO.class);
                        if (dto.getSales().stream().noneMatch(s -> s.getId() == sale.getId())) {
                            dto.getSales().add(sale);
                        }
                    }

                    return map;
                })
                .values()
                .stream()
                .findFirst()
                .orElse(null));
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

    public List<Product> getLatestProducts(int limit) {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT * FROM products ORDER BY createdAt DESC LIMIT :limit").bind("limit", limit).mapToBean(Product.class).list());
    }

    public List<Product> allWithDetails() {
        return new ArrayList<>();
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
                                    _ -> row.getRow(ProductSale.class)
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
                        p.basePrice AS p_basePrice,
                        p.totalViews AS p_totalViews,
                        p.categoryId AS p_categoryId,
                        p.isFeatured AS p_isFeatured,
                        p.brandId AS p_brandId,
                        p.stockManagementType AS p_stockManagementType,
                        (SELECT MAX(s.discountPercentage)
                         FROM product_sales ps
                                  JOIN sales s ON ps.saleId = s.id
                         WHERE ps.productId = p.id
                           AND CURRENT_DATE BETWEEN s.startDate AND s.endDate) AS max_discount,
                        (SELECT COALESCE(AVG(pr.rating), 0)
                         FROM product_reviews pr
                         WHERE pr.productId = p.id
                           AND pr.status = 1) AS p_averageRating,
                        (SELECT COUNT(*)
                         FROM product_reviews pr
                         WHERE pr.productId = p.id
                           AND pr.status = 1) AS p_totalReviews,
                        (SELECT MIN(
                                        CASE
                                            WHEN p.stockManagementType = 0 THEN p.basePrice
                                            WHEN p.stockManagementType = 1 THEN p.basePrice + COALESCE(pc.additionalPrice, 0)
                                            WHEN p.stockManagementType = 2 THEN p.basePrice + COALESCE(pa.additionalPrice, 0)
                                            ELSE p.basePrice + COALESCE(pc.additionalPrice, 0) + COALESCE(pa.additionalPrice, 0)
                                            END)
                         FROM product_variants pv
                                  LEFT JOIN product_colors pc ON pv.colorId = pc.id
                                  LEFT JOIN product_addons pa ON pv.addonId = pa.id
                         WHERE pv.productId = p.id
                           AND pv.status = 1) AS lowest_variant_price
                    FROM products p
                    WHERE p.status = 1
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
                sql.append(" AND p.basePrice BETWEEN ? AND ?");
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
                    p.p_basePrice AS basePrice,
                    p.p_totalViews AS totalViews,
                    p.p_averageRating AS averageRating,
                    p.p_totalReviews AS totalReviews,
                    p.p_isFeatured AS isFeatured,
                    (SELECT image
                     FROM product_images
                     WHERE productId = p.p_id
                       AND isMain = 1
                     LIMIT 1) AS mainImage,
                    c.id AS categoryId,
                    c.name AS categoryName,
                    b.id AS brandId,
                    b.name AS brandName,
                    p.max_discount AS discountPercent,
                    CASE
                        WHEN p.max_discount IS NOT NULL
                            THEN p.lowest_variant_price * (1 - p.max_discount/100)
                        ELSE p.lowest_variant_price
                        END AS lowestSalePrice
                FROM FilteredProducts p
                         LEFT JOIN categories c ON p.p_categoryId = c.id
                         LEFT JOIN brands b ON p.p_brandId = b.id""");
        return jdbi.withHandle(handle -> {
            var query = handle.createQuery(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                query.bind(i, params.get(i));
            }

            return query.map((rs, _) -> {
                ProductCardDTO dto = new ProductCardDTO();
                dto.setId(rs.getInt("id"));
                dto.setName(rs.getString("name"));
                dto.setMainImage(rs.getString("mainImage"));
                dto.setBasePrice(rs.getDouble("basePrice"));
                dto.setIsFeatured(rs.getBoolean("isFeatured"));
                dto.setLowestSalePrice(rs.getDouble("lowestSalePrice"));
                dto.setAverageRating(rs.getDouble("averageRating"));
                dto.setTotalViews(rs.getInt("totalViews"));
                dto.setTotalReviews(rs.getInt("totalReviews"));
                dto.setCategoryId(rs.getInt("categoryId"));
                dto.setCategoryName(rs.getString("categoryName"));
                dto.setBrandId(rs.getInt("brandId"));
                dto.setBrandName(rs.getString("brandName"));

                Double discountPercent = rs.getObject("discountPercent", Double.class);
                if (discountPercent != null) {
                    dto.setDiscountPercent(discountPercent);
                }

                return dto;
            }).list();
        });
    }

    public ProductDetailDTO findProductDetail(int id) {
        String sql = """
                WITH ProductColors AS (
                    SELECT * FROM product_colors WHERE productId = :id
                ),
                ProductAddons AS (
                    SELECT * FROM product_addons WHERE productId = :id
                ),
                MaxDiscount AS (
                    SELECT productId, MAX(s.discountPercentage) as maxDiscount
                    FROM product_sales ps
                    JOIN sales s ON ps.saleId = s.id
                    WHERE NOW() BETWEEN s.startDate AND s.endDate
                    GROUP BY productId
                )
                SELECT
                    p.id AS p_id,
                    p.name AS p_name,
                    p.description AS p_description,
                    p.basePrice AS p_basePrice,
                    p.totalViews AS p_totalViews,
                    p.isFeatured AS p_isFeatured,
                    p.status AS p_status,
                    p.stockManagementType AS p_stockManagementType,
                    (SELECT AVG(rating) FROM product_reviews WHERE productId = p.id AND status = 1) AS p_averageRating,
                    (SELECT COUNT(*) FROM product_reviews WHERE productId = p.id AND status = 1) AS p_totalReviews,
                    p.createdAt AS p_createdAt,
                    pi.id AS pi_id,
                    pi.image AS pi_image,
                    pi.isMain AS pi_isMain,
                    pi.sortOrder AS pi_sortOrder,
                    pc.id AS pc_id,
                    pc.name AS pc_name,
                    pc.additionalPrice AS pc_additionalPrice,
                    pa.id AS pa_id,
                    pa.name AS pa_name,
                    pa.additionalPrice AS pa_additionalPrice,
                    pv.id AS pv_id,
                    pv.stock AS pv_stock,
                    pv.status AS pv_status,
                    pv.colorId AS pv_colorId,
                    pv.addonId AS pv_addonId,
                    pv.imageId AS pv_imageId,
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
                        WHEN md.maxDiscount IS NOT NULL
                        THEN p.basePrice * (1 - md.maxDiscount/100)
                        ELSE p.basePrice
                    END AS p_salePrice,
                    COALESCE(md.maxDiscount, 0) AS p_discountPercent
                FROM products p
                LEFT JOIN product_images pi ON p.id = pi.productId
                LEFT JOIN product_variants pv ON p.id = pv.productId AND pv.status = 1
                LEFT JOIN ProductColors pc ON pc.id = pv.colorId
                LEFT JOIN ProductAddons pa ON pa.id = pv.addonId
                LEFT JOIN product_reviews pr ON p.id = pr.productId AND pr.status = 1
                LEFT JOIN users u ON pr.userId = u.id
                LEFT JOIN categories c ON p.categoryId = c.id
                LEFT JOIN brands b ON p.brandId = b.id
                LEFT JOIN product_sales ps ON p.id = ps.productId
                LEFT JOIN sales s ON ps.saleId = s.id
                    AND NOW() BETWEEN s.startDate AND s.endDate
                LEFT JOIN MaxDiscount md ON md.productId = p.id
                WHERE p.id = :id AND p.status = 1
                """;

        return jdbi.withHandle(handle -> {
            Map<Integer, ProductColorDTO> colorMap = new HashMap<>();
            Map<Integer, ProductAddonDTO> addonMap = new HashMap<>();
            Map<Integer, ProductVariantDTO> variantMap = new HashMap<>();

            return handle.createQuery(sql)
                    .bind("id", id)
                    .registerRowMapper(BeanMapper.factory(ProductDetailDTO.class, "p"))
                    .registerRowMapper(BeanMapper.factory(ProductImageDTO.class, "pi"))
                    .registerRowMapper(BeanMapper.factory(ProductColorDTO.class, "pc"))
                    .registerRowMapper(BeanMapper.factory(ProductAddonDTO.class, "pa"))
                    .registerRowMapper(BeanMapper.factory(ProductVariantDTO.class, "pv"))
                    .registerRowMapper(BeanMapper.factory(ProductReviewDTO.class, "pr"))
                    .registerRowMapper(BeanMapper.factory(ProductSaleDTO.class, "s"))
                    .reduceRows(new LinkedHashMap<Integer, ProductDetailDTO>(), (map, row) -> {
                        ProductDetailDTO dto = map.computeIfAbsent(
                                row.getColumn("p_id", Integer.class),
                                _ -> {
                                    ProductDetailDTO newDto = row.getRow(ProductDetailDTO.class);
                                    newDto.setImages(new ArrayList<>());
                                    newDto.setVariants(new ArrayList<>());
                                    newDto.setReviews(new ArrayList<>());
                                    newDto.setSales(new ArrayList<>());

                                    newDto.setCategoryId(row.getColumn("c_id", Integer.class));
                                    newDto.setCategoryName(row.getColumn("c_name", String.class));
                                    newDto.setBrandId(row.getColumn("b_id", Integer.class));
                                    newDto.setBrandName(row.getColumn("b_name", String.class));

                                    return newDto;
                                }
                        );

                        // Map ProductImage
                        if (row.getColumn("pi_id", Integer.class) != null) {
                            ProductImageDTO image = row.getRow(ProductImageDTO.class);
                            if (dto.getImages().stream().noneMatch(img -> img.getId() == image.getId())) {
                                dto.getImages().add(image);
                            }
                        }

                        // Map ProductColor
                        if (row.getColumn("pc_id", Integer.class) != null) {
                            ProductColorDTO color = row.getRow(ProductColorDTO.class);
                            colorMap.put(color.getId(), color);
                        }

                        // Map ProductAddon
                        if (row.getColumn("pa_id", Integer.class) != null) {
                            ProductAddonDTO addon = row.getRow(ProductAddonDTO.class);
                            addonMap.put(addon.getId(), addon);
                        }

                        // Map ProductVariant
                        if (row.getColumn("pv_id", Integer.class) != null) {
                            Integer variantId = row.getColumn("pv_id", Integer.class);

                            // Chỉ tạo variant mới nếu chưa tồn tại trong map
                            if (!variantMap.containsKey(variantId)) {
                                ProductVariantDTO v = row.getRow(ProductVariantDTO.class);

                                // Set color và addon ngay khi tạo variant
                                Integer colorId = row.getColumn("pv_colorId", Integer.class);
                                Integer addonId = row.getColumn("pv_addonId", Integer.class);

                                if (colorId != null && colorMap.containsKey(colorId)) {
                                    v.setColor(colorMap.get(colorId));
                                }

                                if (addonId != null && addonMap.containsKey(addonId)) {
                                    v.setAddon(addonMap.get(addonId));
                                }

                                variantMap.put(variantId, v);
                                dto.getVariants().add(v);
                            }
                        }

                        // Map ProductReview
                        if (row.getColumn("pr_id", Integer.class) != null) {
                            ProductReviewDTO review = row.getRow(ProductReviewDTO.class);
                            if (dto.getReviews().stream().noneMatch(r -> r.getId() == review.getId())) {
                                review.setUserName(row.getColumn("pr_userName", String.class));
                                review.setUserAvatar(row.getColumn("pr_userAvatar", String.class));
                                dto.getReviews().add(review);
                            }
                        }

                        // Map Sale
                        if (row.getColumn("s_id", Integer.class) != null) {
                            ProductSaleDTO sale = row.getRow(ProductSaleDTO.class);
                            if (dto.getSales().stream().noneMatch(s -> s.getId() == sale.getId())) {
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

    public void incrementViewCount(int id) {
    }
    public List<ProductDashboardDTO> getProductDashboards(int offset, int limit, String search, String category, String sortColumn, String sortDir) {
        StringBuilder sql = new StringBuilder("""
                    SELECT
                        p.id,
                        p.name,
                        p.basePrice,
                        c.name AS categoryName,
                        b.name AS brandName,
                        p.totalViews,
                        p.isFeatured,
                        p.status,
                        COALESCE(pv.total_stock, 0) as stock,
                        COALESCE(pc.total_colors, 0) as totalColors,
                        COALESCE(pa.total_addons, 0) as totalAddons,
                        COALESCE(pv.total_variants, 0) as totalVariants,
                        COALESCE(pr.total_reviews, 0) as totalReviews,
                        COALESCE(pr.avg_rating, 0) as avgRating,
                        (
                            SELECT image
                            FROM product_images
                            WHERE productId = p.id AND isMain = 1
                            LIMIT 1
                        ) as mainImage,
                        p.createdAt
                    FROM products p
                    LEFT JOIN categories c ON p.categoryId = c.id
                    LEFT JOIN brands b ON p.brandId = b.id
                    LEFT JOIN (
                        SELECT productId, COUNT(*) as total_colors
                        FROM product_colors
                        GROUP BY productId
                    ) pc ON p.id = pc.productId
                    LEFT JOIN (
                        SELECT productId, COUNT(*) as total_addons
                        FROM product_addons
                        GROUP BY productId
                    ) pa ON p.id = pa.productId
                    LEFT JOIN (
                        SELECT
                            productId,
                            COUNT(*) as total_variants,
                            SUM(stock) as total_stock
                        FROM product_variants
                        WHERE status = 1
                        GROUP BY productId
                    ) pv ON p.id = pv.productId
                    LEFT JOIN (
                        SELECT
                            productId,
                            COUNT(*) as total_reviews,
                            AVG(rating) as avg_rating
                        FROM product_reviews
                        WHERE status = 1
                        GROUP BY productId
                    ) pr ON p.id = pr.productId
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

        // Thêm sắp xếp
        if (sortColumn != null && !sortColumn.isEmpty()) {
            String sortField = switch (sortColumn) {
                case "name" -> "p.name";
                case "basePrice" -> "p.basePrice";
                case "categoryName" -> "c.name";
                case "brandName" -> "b.name";
                case "totalViews" -> "p.totalViews";
                case "stock" -> "COALESCE(pv.total_stock, 0)";
                case "totalColors" -> "COALESCE(pc.total_colors, 0)";
                case "totalAddons" -> "COALESCE(pa.total_addons, 0)";
                case "totalVariants" -> "COALESCE(pv.total_variants, 0)";
                case "totalReviews" -> "COALESCE(pr.total_reviews, 0)";
                case "avgRating" -> "COALESCE(pr.avg_rating, 0)";
                default -> "p.id";
            };

            sql.append(" ORDER BY ").append(sortField);
            if ("desc".equalsIgnoreCase(sortDir)) {
                sql.append(" DESC");
            } else {
                sql.append(" ASC");
            }
        } else {
            sql.append(" ORDER BY p.id DESC");
        }

        // Thêm phân trang
        sql.append(" LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        return jdbi.withHandle(handle -> {
            var query = handle.createQuery(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                query.bind(i, params.get(i));
            }
            return query.mapToBean(ProductDashboardDTO.class).list();
        });
    }

    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM products";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public CartItemDTO findMainProductVariant(int productVariantId) {
        String sql = """
                WITH MaxDiscount AS (
                    SELECT productId, MAX(s.discountPercentage) as maxDiscount
                    FROM product_sales ps
                    JOIN sales s ON ps.saleId = s.id
                    WHERE NOW() BETWEEN s.startDate AND s.endDate
                    GROUP BY productId
                )
                SELECT
                    p.id AS p_productId,
                    p.name AS p_name,
                    p.basePrice AS p_basePrice,
                    pi.image AS pi_image,
                    COALESCE(md.maxDiscount, 0) AS p_discountPercent,
                    pv.id AS pv_id,
                    pv.stock AS pv_stock,
                    pv.status AS pv_status,
                    pv.colorId AS pv_colorId,
                    pv.addonId AS pv_addonId,
                    pv.imageId AS pv_imageId,
                    pc.name AS pc_colorName,
                    pc.additionalPrice AS pc_additionalPrice,
                    pa.name AS pa_addonName,
                    pa.additionalPrice AS pa_additionalPrice
                FROM products p
                LEFT JOIN product_images pi ON p.id = pi.productId AND pi.isMain = 1
                LEFT JOIN product_variants pv ON p.id = pv.productId AND pv.status = 1
                LEFT JOIN product_colors pc ON pc.id = pv.colorId
                LEFT JOIN product_addons pa ON pa.id = pv.addonId
                LEFT JOIN MaxDiscount md ON md.productId = p.id
                WHERE pv.id = :productVariantId AND p.status = 1
                """;

        return jdbi.withHandle(handle ->
                        handle.createQuery(sql)
                                .bind("productVariantId", productVariantId)
                                .map((rs, ctx) -> {
                                    // Tạo CartItemDTO
                                    CartItemDTO dto = new CartItemDTO();
                                    dto.setProductId(rs.getInt("p_productId"));
                                    dto.setName(rs.getString("p_name"));
                                    dto.setBasePrice(rs.getDouble("p_basePrice"));
                                    dto.setDiscountPercent(rs.getDouble("p_discountPercent"));
                                    dto.setMainImage(rs.getString("pi_image"));
//                            dto.setVariants(new ArrayList<>());

                                    // Tạo ProductVariantDTO
                                    ProductVariantDTO variant = new ProductVariantDTO();
                                    variant.setId(rs.getInt("pv_id"));
                                    variant.setStock(rs.getInt("pv_stock"));
                                    variant.setStatus(rs.getInt("pv_status"));
                                    variant.setImageId(rs.getInt("pv_imageId"));

                                    // Ánh xạ ProductColorDTO
                                    Integer colorId = rs.getObject("pv_colorId", Integer.class);
                                    if (colorId != null) {
                                        ProductColorDTO color = new ProductColorDTO();
                                        color.setId(colorId);
                                        color.setName(rs.getString("pc_colorName"));
                                        color.setAdditionalPrice(rs.getDouble("pc_additionalPrice"));
                                        variant.setColor(color);
                                    }

                                    // Ánh xạ ProductAddonDTO
                                    Integer addonId = rs.getObject("pv_addonId", Integer.class);
                                    if (addonId != null) {
                                        ProductAddonDTO addon = new ProductAddonDTO();
                                        addon.setId(addonId);
                                        addon.setName(rs.getString("pa_addonName"));
                                        addon.setAdditionalPrice(rs.getDouble("pa_additionalPrice"));
                                        variant.setAddon(addon);
                                    }

                                    // Gán variant vào CartItemDTO
                                    dto.setProductVariant(variant);
                                    return dto;
                                })
                                .findFirst()
                                .orElse(null)
        );
    }

    public Map<String, List<Object>> findAllVariants(int productId) {
        String colorSql = """
                SELECT id AS pc_id, name AS pc_colorName, additionalPrice AS pc_additionalPrice 
                FROM product_colors WHERE productId = :productId
                """;

        String addonSql = """
                SELECT id AS pa_id, name AS pa_addonName, additionalPrice AS pa_additionalPrice 
                FROM product_addons WHERE productId = :productId
                """;

        return jdbi.withHandle(handle -> {
            List<ProductColorDTO> colorList = new ArrayList<>();
            List<ProductAddonDTO> addonList = new ArrayList<>();
            Map<String, List<Object>> variantMap = new LinkedHashMap<>();

            List<Map<String, Object>> colorResults = handle.createQuery(colorSql)
                    .bind("productId", productId)
                    .mapToMap()
                    .list();

            for (Map<String, Object> row : colorResults) {
                Integer colorId = (Integer) row.get("pc_id");
                String colorName = (String) row.get("pc_colorname");
                Double additionalPriceColor = row.get("pc_additionalprice") != null ? ((Number) row.get("pc_additionalprice")).doubleValue() : 0.0;
                if (colorId != null && colorName != null) {
                    ProductColorDTO color = new ProductColorDTO();
                    color.setId(colorId);
                    color.setName(colorName);
                    color.setAdditionalPrice(additionalPriceColor);
                    colorList.add(color);
                }
            }

            List<Map<String, Object>> addonResults = handle.createQuery(addonSql)
                    .bind("productId", productId)
                    .mapToMap()
                    .list();

            for (Map<String, Object> row : addonResults) {
                Integer addonId = (Integer) row.get("pa_id");
                String addonName = (String) row.get("pa_addonname");
                Double additionalPriceAddon = row.get("pa_additionalprice") != null ? ((Number) row.get("pa_additionalprice")).doubleValue() : 0.0;
                if (addonId != null && addonName != null) {
                    ProductAddonDTO addon = new ProductAddonDTO();
                    addon.setId(addonId);
                    addon.setName(addonName);
                    addon.setAdditionalPrice(additionalPriceAddon);
                    addonList.add(addon);
                }
            }

            variantMap.put("color", new ArrayList<>(colorList));
            variantMap.put("addon", new ArrayList<>(addonList));

            return variantMap;
        });
    }

    public CartItemDTO findProductWithVariant(int colorId, int addonId, int productId) {
        System.out.println("colorId = " + colorId + ", addonId = " + addonId + ", productId = " + productId);
        String sql = """
                WITH MaxDiscount AS (
                    SELECT productId, MAX(s.discountPercentage) as maxDiscount
                    FROM product_sales ps
                    JOIN sales s ON ps.saleId = s.id
                    WHERE NOW() BETWEEN s.startDate AND s.endDate
                    GROUP BY productId
                )
                SELECT
                    p.id AS p_productId,
                    p.name AS p_name,
                    p.basePrice AS p_basePrice,
                    pi.image AS pi_image,
                    COALESCE(md.maxDiscount, 0) AS p_discountPercent,
                    pv.id AS pv_id,
                    pv.stock AS pv_stock,
                    pv.status AS pv_status,
                    pv.colorId AS pv_colorId,
                    pv.addonId AS pv_addonId,
                    pv.imageId AS pv_imageId,
                    pc.name AS pc_colorName,
                    pc.additionalPrice AS pc_additionalPrice,
                    pa.name AS pa_addonName,
                    pa.additionalPrice AS pa_additionalPrice
                FROM products p
                LEFT JOIN product_images pi ON p.id = pi.productId AND pi.isMain = 1
                LEFT JOIN product_variants pv ON p.id = pv.productId AND pv.status = 1
                LEFT JOIN product_colors pc ON pc.id = pv.colorId
                LEFT JOIN product_addons pa ON pa.id = pv.addonId
                LEFT JOIN MaxDiscount md ON md.productId = p.id
                WHERE p.id = :productId
                    AND p.status = 1
                    AND (pv.colorId = NULLIF(:colorId, 0) OR (pv.colorId IS NULL AND :colorId = 0))
                    AND (pv.addonId = NULLIF(:addonId, 0) OR (pv.addonId IS NULL AND :addonId = 0))
                """;

        return jdbi.withHandle(handle ->
                        handle.createQuery(sql)
                                .bind("productId", productId)
                                .bind("colorId", colorId)
                                .bind("addonId", addonId)
                                .map((rs, ctx) -> {
                                    // Tạo CartItemDTO
                                    CartItemDTO dto = new CartItemDTO();
                                    dto.setProductId(rs.getInt("p_productId"));
                                    dto.setName(rs.getString("p_name"));
                                    dto.setBasePrice(rs.getDouble("p_basePrice"));
                                    dto.setDiscountPercent(rs.getDouble("p_discountPercent"));
                                    dto.setMainImage(rs.getString("pi_image"));

                                    // Tạo ProductVariantDTO
                                    ProductVariantDTO variant = new ProductVariantDTO();
                                    variant.setId(rs.getInt("pv_id"));
                                    variant.setStock(rs.getInt("pv_stock"));
                                    variant.setStatus(rs.getInt("pv_status"));
                                    variant.setImageId(rs.getInt("pv_imageId"));

                                    // Ánh xạ ProductColorDTO
                                    Integer currentColorId = rs.getObject("pv_colorId", Integer.class);
                                    if (currentColorId != null) {
                                        ProductColorDTO color = new ProductColorDTO();
                                        color.setId(currentColorId);
                                        color.setName(rs.getString("pc_colorName"));
                                        color.setAdditionalPrice(rs.getDouble("pc_additionalPrice"));
                                        variant.setColor(color);
                                    }

                                    // Ánh xạ ProductAddonDTO
                                    Integer currentAddonId = rs.getObject("pv_addonId", Integer.class);
                                    if (currentAddonId != null) {
                                        ProductAddonDTO addon = new ProductAddonDTO();
                                        addon.setId(currentAddonId);
                                        addon.setName(rs.getString("pa_addonName"));
                                        addon.setAdditionalPrice(rs.getDouble("pa_additionalPrice"));
                                        variant.setAddon(addon);
                                    }

                                    // Gán variant vào CartItemDTO
                                    dto.setProductVariant(variant);
                                    return dto;
                                })
                                .findFirst()
                                .orElse(null)
        );
    }


}