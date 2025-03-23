package com.drumstore.web.constants;

public class PermissionConstants {
    public enum Permission {
        // Product permissions
        PRODUCT_VIEW("product:view", "Xem sản phẩm"),
        PRODUCT_CREATE("product:create", "Thêm sản phẩm"),
        PRODUCT_UPDATE("product:update", "Sửa sản phẩm"),
        PRODUCT_DELETE("product:delete", "Xóa sản phẩm"),

        // Order permissions
        ORDER_VIEW("order:view", "Xem đơn hàng"),
        ORDER_UPDATE("order:update", "Cập nhật đơn hàng"),
        ORDER_DELETE("order:delete", "Xóa đơn hàng");

        private final String value;
        private final String description;

        Permission(String value, String description) {
            this.value = value;
            this.description = description;
        }

        public String getValue() {
            return value;
        }

        public String getDescription() {
            return description;
        }
    }
} 