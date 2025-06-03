package com.drumstore.web.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BrandDTO implements Serializable {
    private Integer id;
    private String name;
    private String description;
    private String image;
    private int productCount;
    private Timestamp createdAt;
}
