package com.drumstore.web.repositories;

import com.drumstore.web.dto.CartItemDTO;
import com.drumstore.web.models.Cart;
import com.drumstore.web.models.CartContext;
import com.drumstore.web.models.CartItem;
import com.drumstore.web.services.ProductService;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.util.List;

public class CartRepository {
    private final Jdbi jdbi;
    private final ProductRepository productRepository;
    private final ProductService productService;

    public CartRepository() {
        this.jdbi = DBConnection.getJdbi();
        this.productRepository = new ProductRepository();
        this.productService = new ProductService();
    }

    public void createCart(int userId) {
        jdbi.useHandle(handle ->
                handle.createUpdate("INSERT INTO carts (userId) VALUES (:userId)")
                        .bind("userId", userId)
                        .execute()
        );
    }

    public Cart getCart(int userId) {
        return jdbi.withHandle(handle -> handle
                .registerRowMapper(BeanMapper.factory(Cart.class))
                .createQuery("SELECT * FROM carts WHERE userId = :userId")
                .bind("userId", userId)
                .mapTo(Cart.class)
                .findOne()
                .orElse(null)
        );
    }

    public List<CartItem> getCartItems(int cartId) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("SELECT id, productVariantId, quantity FROM cartItems WHERE cartId = :cartId")
                    .bind("cartId", cartId)
                    .map((rs, ctx) -> {
                        int cartItemId = rs.getInt("id");
                        int productVariantId = rs.getInt("productVariantId");
                        int quantity = rs.getInt("quantity");

                        int productId = productRepository.findProductIdByVariantId(productVariantId);
                        CartItemDTO dto = productService.findProductForCartItem(productVariantId,productId);

                        CartItem item = new CartItem();
                        item.setCartItemId(cartItemId);
                        item.setCartItem(dto);
                        item.setQuantity(quantity);
                        return item;
                    })
                    .list();
        });
    }

    public boolean addItem(int productVariantId, int quantity, int cartId) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO cartItems (cartId, productVariantId, quantity) VALUES (:cartId, :productVariantId, :quantity)")
                        .bind("cartId", cartId)
                        .bind("productVariantId", productVariantId)
                        .bind("quantity", quantity)
                        .execute() > 0
        );
    }

    public boolean updateQuantity(int cartItemId, int quantity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE cartItems SET quantity = :quantity WHERE id = :cartItemId")
                        .bind("quantity", quantity)
                        .bind("cartItemId", cartItemId)
                        .execute() > 0
        );
    }

    public boolean removeItem(int cartItemId) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("DELETE FROM cartItems WHERE id = :cartItemId")
                        .bind("cartItemId", cartItemId)
                        .execute() > 0
        );
    }

    public boolean changeVariant(int cartItemId, Integer productVariantId) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE cartItems SET productVariantId = :productVariantId WHERE id = :cartItemId")
                        .bind("productVariantId", productVariantId)
                        .bind("cartItemId", cartItemId)
                        .execute() > 0
        );
    }

    public void removeAllItems(int cartId) {
        jdbi.useHandle(handle ->
                handle.createUpdate("DELETE FROM cartItems WHERE cartId = :cartId")
                .bind("cartId", cartId)
                .execute());
    }
}
