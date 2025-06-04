package com.drumstore.web.repositories;

import com.drumstore.web.dto.ProductSaleDTO;
import com.drumstore.web.dto.SaleDTO;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.sql.Timestamp;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

public class ProductSaleRepository {
    private final Jdbi jdbi = DBConnection.getJdbi();

    public List<ProductSaleDTO> all() {
        String sql = """
                SELECT
                    p.id AS p_id,
                    p.name AS p_name,
                    p.basePrice AS p_basePrice,
                    pi.image AS pi_image,
                    p.featured AS p_featured,
                    p.categoryId AS p_categoryId,
                    c.name AS c_name,
                    p.brandId AS p_brandId,
                    b.name AS b_name,
                    p.createdAt AS p_createdAt,
                
                    s.id AS s_id,
                    s.name AS s_name,
                    s.description AS s_description,
                    s.discountPercentage AS s_discountPercentage,
                    s.startDate AS s_startDate,
                    s.endDate AS s_endDate
                
                FROM products p
                         LEFT JOIN product_sales ps ON p.id = ps.productId
                         LEFT JOIN sales s ON ps.saleId = s.id
                         LEFT JOIN product_images pi ON p.id = pi.productId AND pi.main = true
                         LEFT JOIN categories c ON p.categoryId = c.id
                         LEFT JOIN brands b ON p.brandId = b.id
                """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .registerRowMapper(BeanMapper.factory(ProductSaleDTO.class, "p"))
                        .reduceRows(new LinkedHashMap<Integer, ProductSaleDTO>(), (map, row) -> {
                            int productId = row.getColumn("p_id", Integer.class);

                            ProductSaleDTO productSaleDTO = map.computeIfAbsent(productId, _ -> {
                                ProductSaleDTO dto = new ProductSaleDTO();
                                dto.setId(productId);
                                dto.setName(row.getColumn("p_name", String.class));
                                dto.setBasePrice(row.getColumn("p_basePrice", Integer.class));
                                dto.setMainImage(row.getColumn("pi_image", String.class));
                                dto.setFeatured(row.getColumn("p_featured", Boolean.class));
                                dto.setCategoryId(row.getColumn("p_categoryId", Integer.class));
                                dto.setCategoryName(row.getColumn("c_name", String.class));
                                dto.setBrandId(row.getColumn("p_brandId", Integer.class));
                                dto.setBrandName(row.getColumn("b_name", String.class));
                                dto.setCreatedAt(row.getColumn("p_createdAt", Timestamp.class));
                                return dto;
                            });

                            if (row.getColumn("s_id", Integer.class) != null) {
                                SaleDTO sale = new SaleDTO();
                                sale.setId(row.getColumn("s_id", Integer.class));
                                sale.setName(row.getColumn("s_name", String.class));
                                sale.setDescription(row.getColumn("s_description", String.class));
                                sale.setDiscountPercentage(row.getColumn("s_discountPercentage", Double.class));
                                sale.setStartDate(row.getColumn("s_startDate", Timestamp.class));
                                sale.setEndDate(row.getColumn("s_endDate", Timestamp.class));

                                if (productSaleDTO.getSales().stream().noneMatch(s -> s.getId().equals(sale.getId()))) {
                                    productSaleDTO.getSales().add(sale);
                                }
                            }

                            return map;
                        })
                        .values()
                        .stream()
                        .toList()
        );
    }

    public List<ProductSaleDTO> getFilteredProducts(String search, String brandId, String categoryId, String status, int page, int limit) {
        StringBuilder sql = new StringBuilder("""
                SELECT
                    p.id AS p_id,
                    p.name AS p_name,
                    p.basePrice AS p_basePrice,
                    pi.image AS pi_image,
                    p.featured AS p_featured,
                    p.categoryId AS p_categoryId,
                    c.name AS c_name,
                    p.brandId AS p_brandId,
                    b.name AS b_name,
                    p.createdAt AS p_createdAt,
                
                    s.id AS s_id,
                    s.name AS s_name,
                    s.description AS s_description,
                    s.discountPercentage AS s_discountPercentage,
                    s.startDate AS s_startDate,
                    s.endDate AS s_endDate
                
                FROM products p
                         LEFT JOIN product_sales ps ON p.id = ps.productId
                         LEFT JOIN sales s ON ps.saleId = s.id
                         LEFT JOIN product_images pi ON p.id = pi.productId AND pi.main = true
                         LEFT JOIN categories c ON p.categoryId = c.id
                         LEFT JOIN brands b ON p.brandId = b.id
                WHERE 1=1
                """);

        if (search != null && !search.isEmpty()) {
            sql.append(" AND p.name LIKE :search");
        }
        if (brandId != null && !brandId.isEmpty()) {
            sql.append(" AND p.brandId = :brandId");
        }
        if (categoryId != null && !categoryId.isEmpty()) {
            sql.append(" AND p.categoryId = :categoryId");
        }
        if (status != null && !status.isEmpty()) {
            if (status.equals("active")) {
                sql.append(" AND s.startDate <= CURRENT_DATE AND s.endDate >= CURRENT_DATE");
            } else if (status.equals("inactive")) {
                sql.append(" AND (s.startDate > CURRENT_DATE OR s.endDate < CURRENT_DATE)");
            }
        }

        sql.append(" ORDER BY p.createdAt DESC");
        sql.append(" LIMIT :limit OFFSET :offset");

        return jdbi.withHandle(handle -> {
            var query = handle.createQuery(sql.toString())
                    .registerRowMapper(BeanMapper.factory(ProductSaleDTO.class, "p"));

            if (search != null && !search.isEmpty()) {
                query.bind("search", "%" + search + "%");
            }
            if (brandId != null && !brandId.isEmpty()) {
                query.bind("brandId", Integer.parseInt(brandId));
            }
            if (categoryId != null && !categoryId.isEmpty()) {
                query.bind("categoryId", Integer.parseInt(categoryId));
            }

            query.bind("limit", limit)
                    .bind("offset", (page - 1) * limit);

            return query.reduceRows(new LinkedHashMap<Integer, ProductSaleDTO>(), (map, row) -> {
                int productId = row.getColumn("p_id", Integer.class);

                ProductSaleDTO productSaleDTO = map.computeIfAbsent(productId, _ -> {
                    ProductSaleDTO dto = new ProductSaleDTO();
                    dto.setId(productId);
                    dto.setName(row.getColumn("p_name", String.class));
                    dto.setBasePrice(row.getColumn("p_basePrice", Integer.class));
                    dto.setMainImage(row.getColumn("pi_image", String.class));
                    dto.setFeatured(row.getColumn("p_featured", Boolean.class));
                    dto.setCategoryId(row.getColumn("p_categoryId", Integer.class));
                    dto.setCategoryName(row.getColumn("c_name", String.class));
                    dto.setBrandId(row.getColumn("p_brandId", Integer.class));
                    dto.setBrandName(row.getColumn("b_name", String.class));
                    dto.setCreatedAt(row.getColumn("p_createdAt", Timestamp.class));
                    return dto;
                });

                if (row.getColumn("s_id", Integer.class) != null) {
                    SaleDTO sale = new SaleDTO();
                    sale.setId(row.getColumn("s_id", Integer.class));
                    sale.setName(row.getColumn("s_name", String.class));
                    sale.setDescription(row.getColumn("s_description", String.class));
                    sale.setDiscountPercentage(row.getColumn("s_discountPercentage", Double.class));
                    sale.setStartDate(row.getColumn("s_startDate", Timestamp.class));
                    sale.setEndDate(row.getColumn("s_endDate", Timestamp.class));

                    if (productSaleDTO.getSales().stream().noneMatch(s -> s.getId().equals(sale.getId()))) {
                        productSaleDTO.getSales().add(sale);
                    }
                }

                return map;
            }).values().stream().toList();
        });
    }

    public int getTotalFilteredProducts(String search, String brandId, String categoryId, String status) {
        StringBuilder sql = new StringBuilder("""
                SELECT COUNT(DISTINCT p.id)
                FROM products p
                         LEFT JOIN product_sales ps ON p.id = ps.productId
                         LEFT JOIN sales s ON ps.saleId = s.id
                         LEFT JOIN categories c ON p.categoryId = c.id
                         LEFT JOIN brands b ON p.brandId = b.id
                WHERE 1=1
                """);

        if (search != null && !search.isEmpty()) {
            sql.append(" AND p.name LIKE :search");
        }
        if (brandId != null && !brandId.isEmpty()) {
            sql.append(" AND p.brandId = :brandId");
        }
        if (categoryId != null && !categoryId.isEmpty()) {
            sql.append(" AND p.categoryId = :categoryId");
        }
        if (status != null && !status.isEmpty()) {
            if (status.equals("active")) {
                sql.append(" AND s.startDate <= CURRENT_DATE AND s.endDate >= CURRENT_DATE");
            } else if (status.equals("inactive")) {
                sql.append(" AND (s.startDate > CURRENT_DATE OR s.endDate < CURRENT_DATE)");
            }
        }

        return jdbi.withHandle(handle -> {
            var query = handle.createQuery(sql.toString());

            if (search != null && !search.isEmpty()) {
                query.bind("search", "%" + search + "%");
            }
            if (brandId != null && !brandId.isEmpty()) {
                query.bind("brandId", Integer.parseInt(brandId));
            }
            if (categoryId != null && !categoryId.isEmpty()) {
                query.bind("categoryId", Integer.parseInt(categoryId));
            }

            return query.mapTo(Integer.class).one();
        });
    }

    public ProductSaleDTO findById(Integer id) {
        String sql = """
                SELECT
                    p.id AS p_id,
                    p.name AS p_name,
                    p.basePrice AS p_basePrice,
                    pi.image AS pi_image,
                    p.featured AS p_featured,
                    p.categoryId AS p_categoryId,
                    c.name AS c_name,
                    p.brandId AS p_brandId,
                    b.name AS b_name,
                    p.createdAt AS p_createdAt,
                
                    s.id AS s_id,
                    s.name AS s_name,
                    s.description AS s_description,
                    s.discountPercentage AS s_discountPercentage,
                    s.startDate AS s_startDate,
                    s.endDate AS s_endDate
                
                FROM products p
                         LEFT JOIN product_sales ps ON p.id = ps.productId
                         LEFT JOIN sales s ON ps.saleId = s.id
                         LEFT JOIN product_images pi ON p.id = pi.productId AND pi.main = true
                         LEFT JOIN categories c ON p.categoryId = c.id
                         LEFT JOIN brands b ON p.brandId = b.id
                WHERE s.id = :id
                """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .registerRowMapper(BeanMapper.factory(ProductSaleDTO.class, "p"))
                        .reduceRows(new LinkedHashMap<Integer, ProductSaleDTO>(), (map, row) -> {
                            int productId = row.getColumn("p_id", Integer.class);

                            ProductSaleDTO productSaleDTO = map.computeIfAbsent(productId, _ -> {
                                ProductSaleDTO dto = new ProductSaleDTO();
                                dto.setId(productId);
                                dto.setName(row.getColumn("p_name", String.class));
                                dto.setBasePrice(row.getColumn("p_basePrice", Integer.class));
                                dto.setMainImage(row.getColumn("pi_image", String.class));
                                dto.setFeatured(row.getColumn("p_featured", Boolean.class));
                                dto.setCategoryId(row.getColumn("p_categoryId", Integer.class));
                                dto.setCategoryName(row.getColumn("c_name", String.class));
                                dto.setBrandId(row.getColumn("p_brandId", Integer.class));
                                dto.setBrandName(row.getColumn("b_name", String.class));
                                dto.setCreatedAt(row.getColumn("p_createdAt", Timestamp.class));
                                return dto;
                            });

                            if (row.getColumn("s_id", Integer.class) != null) {
                                SaleDTO sale = new SaleDTO();
                                sale.setId(row.getColumn("s_id", Integer.class));
                                sale.setName(row.getColumn("s_name", String.class));
                                sale.setDescription(row.getColumn("s_description", String.class));
                                sale.setDiscountPercentage(row.getColumn("s_discountPercentage", Double.class));
                                sale.setStartDate(row.getColumn("s_startDate", Timestamp.class));
                                sale.setEndDate(row.getColumn("s_endDate", Timestamp.class));

                                if (productSaleDTO.getSales().stream().noneMatch(s -> s.getId().equals(sale.getId()))) {
                                    productSaleDTO.getSales().add(sale);
                                }
                            }

                            return map;
                        })
                        .values()
                        .stream()
                        .findFirst()
                        .orElse(null)
        );
    }

    public void create(Integer productId, String name, String description, Double discountPercentage, String startDate, String endDate) {
        jdbi.useTransaction(handle -> {
            // Insert into sales table
            String saleSql = """
                    INSERT INTO sales (name, description, discountPercentage, startDate, endDate)
                    VALUES (:name, :description, :discountPercentage, :startDate, :endDate)
                    """;
            
            int saleId = handle.createUpdate(saleSql)
                    .bind("name", name)
                    .bind("description", description)
                    .bind("discountPercentage", discountPercentage)
                    .bind("startDate", Timestamp.valueOf(startDate))
                    .bind("endDate", Timestamp.valueOf(endDate))
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(Integer.class)
                    .one();

            // Insert into product_sales table
            String productSaleSql = """
                    INSERT INTO product_sales (productId, saleId)
                    VALUES (:productId, :saleId)
                    """;
            
            handle.createUpdate(productSaleSql)
                    .bind("productId", productId)
                    .bind("saleId", saleId)
                    .execute();
        });
    }

    public void update(Integer saleId, String name, String description, Double discountPercentage, String startDate, String endDate) {
        String sql = """
                UPDATE sales
                SET name = :name,
                    description = :description,
                    discountPercentage = :discountPercentage,
                    startDate = :startDate,
                    endDate = :endDate
                WHERE id = :id
                """;

        jdbi.useHandle(handle ->
                handle.createUpdate(sql)
                        .bind("id", saleId)
                        .bind("name", name)
                        .bind("description", description)
                        .bind("discountPercentage", discountPercentage)
                        .bind("startDate", Timestamp.valueOf(startDate))
                        .bind("endDate", Timestamp.valueOf(endDate))
                        .execute()
        );
    }

    public void delete(Integer saleId) {
        jdbi.useTransaction(handle -> {
            // Delete from product_sales table
            String productSaleSql = "DELETE FROM product_sales WHERE saleId = :saleId";
            handle.createUpdate(productSaleSql)
                    .bind("saleId", saleId)
                    .execute();

            // Delete from sales table
            String saleSql = "DELETE FROM sales WHERE id = :saleId";
            handle.createUpdate(saleSql)
                    .bind("saleId", saleId)
                    .execute();
        });
    }
}
