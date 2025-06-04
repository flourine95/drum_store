package com.drumstore.web.services;

import com.drumstore.web.dto.*;
import com.drumstore.web.repositories.ProductRepository;

import java.util.List;

public class ProductService {
    private final ProductRepository productRepository = new ProductRepository();

    public List<ProductDashboardDTO> all() {
        return productRepository.all();
    }

    public int create(ProductCreateDTO product) {
        return productRepository.store(product);
    }

    public ProductDashboardDetailDTO find(int id) {
        return productRepository.findById(id);
    }

    public int countProducts(String search, String category, String brand, String priceRange) {
        return productRepository.countFilteredProducts(search, category, brand, priceRange);
    }

    public int findProductIdByVariantId(int variantId) {
        return productRepository.findProductIdByVariantId(variantId);
    }

    public List<ProductCardDTO> getProductCards(int page, int limit, String search, String category, String brand, String priceRange, String sortBy) {
        int offset = (page - 1) * limit;
        return productRepository.getFilteredProductCards(offset, limit, search, category, brand, priceRange, sortBy);
    }

    public ProductDetailDTO getProductDetail(int id) {
        ProductDetailDTO product = productRepository.findProductDetail(id);
        if (product != null) {
            productRepository.incrementViewCount(id);
        }
        return product;
    }

    public CartItemDTO findProductForCartItem(int productVariantId, int productId) {
        CartItemDTO cartItemDTO = productRepository.findMainProductVariant(productVariantId);
        cartItemDTO.setVariants(productRepository.findAllVariants(productId));
        return cartItemDTO;
    }

    public CartItemDTO findProductWithVariantForCartItem(int colorId, int addonId, int productId) {
        CartItemDTO cartItemDTO = productRepository.findProductWithVariant(colorId, addonId, productId);
        cartItemDTO.setVariants(productRepository.findAllVariants(productId));
        return cartItemDTO;
    }

    public ProductEditDTO findProductEdit(int id) {
        return productRepository.findProductEdit(id);
    }

    public int createColor(int productId, ProductColorDTO color) {
        return productRepository.storeColor(productId, color);
    }

    public void update(ProductEditDTO productEditDTO) {
        productRepository.update(productEditDTO);
    }

    public void updateVariants(List<ProductVariantDTO> variants) {
        for (ProductVariantDTO variant : variants) {
            productRepository.updateVariant(variant);
        }
    }

    public List<ProductImageDTO> getProductImages(int productId) {
        return productRepository.getProductImages(productId);
    }

    public void deleteImage(int imageId) {
        productRepository.deleteImage(imageId);
    }

    public void addImage(ProductImageDTO imageDTO) {
        productRepository.storeImage(imageDTO.getProductId(), imageDTO);
    }

    public void updateImage(ProductImageDTO imageDTO) {
        productRepository.updateImage(imageDTO);
    }

    public void syncColors(Integer productId, List<ProductColorDTO> colors, List<Integer> currentColorIds) {
        List<Integer> existingIds = productRepository.getColorIdsByProductId(productId);

        List<Integer> toDelete = existingIds.stream()
                .filter(id -> !currentColorIds.contains(id))
                .toList();

        for (Integer id : toDelete) {
            productRepository.deleteColorById(id);
        }

        for (ProductColorDTO color : colors) {
            if (color.getId() == null) {
                productRepository.addColor(color);
            } else {
                productRepository.updateColor(color);
            }
        }
    }

    public void syncAddons(Integer productId, List<ProductAddonDTO> addons, List<Integer> currentAddonIds) {
        List<Integer> existingIds = productRepository.getAddonIdsByProductId(productId);

        List<Integer> toDelete = existingIds.stream()
                .filter(id -> !currentAddonIds.contains(id))
                .toList();

        for (Integer id : toDelete) {
            productRepository.deleteAddonById(id);
        }

        for (ProductAddonDTO addon : addons) {
            if (addon.getId() == null) {
                productRepository.addAddon(addon);
            } else {
                productRepository.updateAddon(addon);
            }
        }
    }

    public void syncVariants(Integer productId, List<ProductVariantDTO> variants, List<Integer> currentVariantIds) {
        List<Integer> existingIds = productRepository.getVariantIdsByProductId(productId);

        List<Integer> toDelete = existingIds.stream()
                .filter(id -> !currentVariantIds.contains(id))
                .toList();

        for (Integer id : toDelete) {
            productRepository.deleteVariantById(id);
        }

        for (ProductVariantDTO variant : variants) {
            if (variant.getId() == null) {
                productRepository.addVariant(variant);
            } else {
                productRepository.updateVariant(variant);
            }
        }
    }
    
    public List<ProductCardDTO> getFeaturedProductCards(int limit) {
        return productRepository.getFeaturedProductCards(limit);
    }
}
