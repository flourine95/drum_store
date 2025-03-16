package com.drumstore.web.models;

import com.drumstore.web.dto.CartItemDTO;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<CartItem> items;

    @Override
    public String toString() {
        return "Cart{" +
                "items=" + items +
                '}';
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }

    public Cart() {
        this.items = new ArrayList<>();
    }

    public void addItem(CartItemDTO item , int quantity) {
        // Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng chưa
        for (CartItem existingItem : items) {
            if (existingItem.getCartItem().getVariants().getId() == item.getVariants().getId()) {
                existingItem.setQuantity(existingItem.getQuantity() + quantity);
                return;
            }
        }
        items.add(new CartItem(items.size()+1, quantity ,item ));
    }

    public void removeItem(int cartId) {
        items.removeIf(item -> item.getCartId() == cartId
                            );
    }

//    public void updateQuantity(int productId, String color, int quantity) {
//        for (CartItem item : items) {
//            if (item.getProduct().getId() == productId
//                && item.getColor().equals(color)) {
//                item.setQuantity(quantity);
//                return;
//            }
//        }
//    }

    public List<CartItem> getItems() {
        return items;
    }

    public double getTotal() {
        return items.stream()
                   .mapToDouble(CartItem::getQuantity)
                   .sum();
    }

    public int getItemCount() {
        return items.stream()
                   .mapToInt(CartItem::getQuantity)
                   .sum();
    }


}