package com.drumstore.web.dto;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductSaleDTO implements Serializable {
    private Integer id;
    private String name;
    private Integer basePrice;
    private String mainImage;
    private boolean featured;
    private Integer categoryId;
    private String categoryName;
    private Integer brandId;
    private String brandName;
    private List<SaleDTO> sales = new ArrayList<>();
    private Timestamp createdAt;
}
