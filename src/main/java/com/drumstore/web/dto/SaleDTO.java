package com.drumstore.web.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SaleDTO implements Serializable {
    private Integer id;
    private String name;
    private String description;
    private double discountPercentage;
    private Timestamp startDate;
    private Timestamp endDate;
}
