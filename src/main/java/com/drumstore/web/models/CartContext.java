package com.drumstore.web.models;

import com.drumstore.web.dto.CartItemDTO;
import com.drumstore.web.dto.VoucherDTO;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class CartContext {
    private int cartId;
    private List<CartItem> items;
    private VoucherDTO voucher;

    @Override
    public String toString() {
        return "Cart{" +
                "items=" + items +
                '}';
    }

    public VoucherDTO getVoucher() {
        return voucher;
    }

    public void setVoucher(VoucherDTO voucher) {
        this.voucher = voucher;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }

    public CartContext() {
        this.items = new ArrayList<>();
    }

  public CartItem getCartItem(int cartItemId) {
      for (CartItem item : items) {
          if (item.getCartItemId() == cartItemId) {
              return item;
          }
      }
      return null;
  }

    public double getPriceItem(int cartItemId) {
        for (CartItem item : items) {
            if (item.getCartItemId() == cartItemId) {
                return item.getTotal();
            }
        }
        return 0;
    }



    public List<CartItem> getItems() {
        return items;
    }

    public double getTotal() {
        return items.stream()
                .mapToDouble(CartItem::getTotal)
                .sum() ;
    }
    public double getDiscountTotal(){
        if (voucher == null) {
            return 0;
        }
        return voucher.calculateDiscount(getTotal());
    }

    public int getItemCount() {
        return items.stream()
                .mapToInt(CartItem::getQuantity)
                .sum();
    }

    // cập nhật lại item khi người dùng chọn biến thể khác
    public CartItem changeVariant(int cartId ,CartItemDTO cartItemDTO) {
        for (CartItem item : items) {
            if (item.getCartItemId() == cartId) {
                item.changeCartItem(cartItemDTO);
                return item;
            }
        }
        return null;
    }


}