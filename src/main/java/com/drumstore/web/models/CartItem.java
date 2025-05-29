package com.drumstore.web.models;

import com.drumstore.web.dto.CartItemDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartItem {
    private int cartItemId;
    private CartItemDTO cartItem;
    private int quantity;


    public double getTotal() {
        return cartItem.getLowestSalePrice()*quantity;
    }

    public void changeCartItem(CartItemDTO cartItem) {
        this.cartItem = cartItem;
        this.quantity = 1;
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "cartId=" + cartItemId +
                ", cartItem=" + cartItem +
                ", quantity=" + quantity +
                '}';
    }
}