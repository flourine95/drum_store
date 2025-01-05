package com.drumstore.web.services;


import com.drumstore.web.models.User;
import com.drumstore.web.repositories.UserRepository;

import java.util.List;

public class UserService {
    private final UserRepository userRepository = new UserRepository();

    public List<User> all() {
        return userRepository.all();
    }


    public void createUser(User user) {
        userRepository.save(user);
    }

    public void updateUser(User user) {
        userRepository.update(user);
    }

    public void deleteUser(int id) {
        userRepository.delete(id);
    }

    public User find(int id) {
        return userRepository.find(id);
    }

    public User findWithDetails(int id) {
        return userRepository.findWithDetails(id);
    }

    public User show(int id) {
        return userRepository.show(id);
    }
}