package com.drumstore.web.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductVariantDTO implements Serializable {
    private Integer id;
    private Integer imageId;
    private Integer colorId;
    private Integer addonId;
    private ProductColorDTO color;
    private ProductAddonDTO addon;
    private Integer productId;
    private int stock;
    private int status;

    public double getAdditionalPrice() {
        double colorPrice = (color != null) ? color.getAdditionalPrice() : 0.0;
        double addonPrice = (addon != null) ? addon.getAdditionalPrice() : 0.0;
        return colorPrice + addonPrice;
    }

}
