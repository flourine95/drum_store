package com.drumstore.web.services;

import com.drumstore.web.dto.AddressDTO;
import com.drumstore.web.repositories.AddressRepository;
import com.drumstore.web.repositories.UserRepository;

import java.util.List;

public class AddressService {
    private AddressRepository addressRepository = new AddressRepository();
    public List<AddressDTO> getAddressesByUserId(int userId) {
        return addressRepository.getAddressesByUserId(userId);
    }
}
