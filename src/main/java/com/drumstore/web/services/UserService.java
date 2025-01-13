package com.drumstore.web.services;


import com.drumstore.web.models.User;
import com.drumstore.web.repositories.UserRepository;

import java.util.List;

public class UserService {
    private final UserRepository userRepository = new UserRepository();

    public List<User> all() {
        return userRepository.all();
    }

    public int create(User user) {
        return userRepository.save(user);
    }

    public int update(User user) {
        return userRepository.update(user);
    }

    public int delete(int id) {
        return userRepository.delete(id);
    }

    public User find(int id) {
        return userRepository.find(id);
    }

    public User detail(int id) {
        return userRepository.detail(id);
    }

    public User show(int id) {
        return userRepository.show(id);
    }
}