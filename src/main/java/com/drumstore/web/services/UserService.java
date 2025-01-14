package com.drumstore.web.services;


import com.drumstore.web.models.User;
import com.drumstore.web.repositories.UserRepository;
import org.mindrot.jbcrypt.BCrypt;

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

    public String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt()); // Mã hóa mật khẩu
    }


    public boolean register(User user) {
        return userRepository.register(user);
    }

    public boolean isPhoneExists(String phone) {
        return userRepository.isPhoneExists(phone);
    }

    public boolean isEmailExists(String email) {
        return userRepository.isEmailExists(email);
    }

    public User login(String username, String password) {
       return userRepository.login(username, password);
    }
}