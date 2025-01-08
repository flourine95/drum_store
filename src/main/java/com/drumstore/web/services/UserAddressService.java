package com.drumstore.web.services;

import com.drumstore.web.models.UserAddress;
import com.drumstore.web.repositories.UserAddressRepository;

import java.util.List;

public class UserAddressService {
    private final UserAddressRepository userAddressRepository = new UserAddressRepository();

    // Lấy danh sách tất cả địa chỉ
    public List<UserAddress> all() {
        return userAddressRepository.all();
    }

    // Tìm địa chỉ theo ID
    public UserAddress getUserAddressById(int id) {
        return userAddressRepository.find(id);
    }

    public UserAddress find(int id) {
        return userAddressRepository.find(id);
    }

    public boolean create(UserAddress address) {
        return userAddressRepository.create(address);
    }

    public boolean update(int id, UserAddress address) {
        return userAddressRepository.update(id, address);
    }

    public boolean deleteAddress(int id) {
        return userAddressRepository.delete(id);
    }

}
