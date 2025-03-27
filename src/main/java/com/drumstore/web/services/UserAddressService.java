package com.drumstore.web.services;

import com.drumstore.web.dto.UserAddressDTO;
import com.drumstore.web.models.UserAddress;
import com.drumstore.web.repositories.UserAddressRepository;

import java.util.List;
import java.util.Map;

public class UserAddressService {
    private final UserAddressRepository userAddressRepository = new UserAddressRepository();

    public List<UserAddress> all() {
        return userAddressRepository.all();
    }

    public boolean create(UserAddress address) {
        return userAddressRepository.create(address);
    }

    public UserAddress find(int id) {
        return userAddressRepository.find(id);
    }

    public int update(UserAddress address) {
        return userAddressRepository.update(address);
    }

    public int delete(int id) {
        return userAddressRepository.delete(id);
    }

    public int isExitsUserAddress(int userId){
        return userAddressRepository.isExistsUserAddress(userId);
    }

    public Map<String, List<UserAddressDTO>> getMainAddressAndSubAddress(int userId){
        return userAddressRepository.getMainAddressAndSubAddress(userId);
    }

}
