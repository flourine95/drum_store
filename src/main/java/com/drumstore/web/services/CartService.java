package com.drumstore.web.services;

import com.drumstore.web.dto.UserDTO;
import com.drumstore.web.models.Cart;
import com.drumstore.web.models.CartContext;
import com.drumstore.web.models.CartItem;
import com.drumstore.web.repositories.CartRepository;
import com.drumstore.web.repositories.UserRepository;

import java.util.List;

public class CartService {
    private final UserRepository userRepository = new UserRepository();
    private  final CartRepository cartRepository = new CartRepository();


    public CartContext getCartContext( int userId) {
        Cart cart = cartRepository.getCart(userId);
        CartContext cartContext = new CartContext();
        cartContext.setCartId(cart.getId());
        List<CartItem> cartItems = cartRepository.getCartItems(cart.getId());
        cartContext.setItems(cartItems);
        return cartContext;

    }

    public void createCart(String email){
        UserDTO user = userRepository.findUser("email", email);
        cartRepository.createCart(user.getId());
    }

    public boolean addItem(int productVariantId, int quantity , int cartId) {
        return cartRepository.addItem(productVariantId,quantity,cartId);
    }

    public boolean updateQuantity(int cartItemId, int quantity) {
        return cartRepository.updateQuantity(cartItemId, quantity);
    }
    public boolean removeItem(int cartItemId) {
        return cartRepository.removeItem(cartItemId);
    }

    public boolean changeVariant(int cartItemId, int productVariantId) {
        return cartRepository.changeVariant(cartItemId, productVariantId);
    }

    public void removeAllItems( int cartId) {
         cartRepository.removeAllItems(cartId);
    }
}
