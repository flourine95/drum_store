package com.drumstore.web.services;

import com.drumstore.web.models.Product;
import com.drumstore.web.models.User;
import com.drumstore.web.models.WishList;
import com.drumstore.web.repositories.WishListRepository;

import java.util.ArrayList;
import java.util.List;

public class WishlistService {
    private final WishListRepository wishListRepository = new WishListRepository();
    private final ProductService productService = new ProductService();

    public List<Product> getAll(User user){
        return wishListRepository.getAll(user).stream()
                .map(wishList -> productService.findWithDetails(wishList.getProductId()))
                .toList();
    }

    public boolean isExitsInWishlist(int productId , int userId){return wishListRepository.isExists(productId, userId);}

    public void save(int productId, int userId) {
        WishList wishList = new WishList();
        wishList.setProductId(productId);
        wishList.setUserId(userId);
        wishList.setCreatedAt();
        wishListRepository.save(wishList);
    }

    public void delete(int productId, int userId) {
        wishListRepository.delete(productId, userId);
    }
}
