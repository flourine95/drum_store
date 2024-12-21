package com.drumstore.web.repositories;

import com.drumstore.web.models.User;
import com.drumstore.web.models.UserAddress;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class UserRepository {
    private final Jdbi jdbi = DBConnection.getJdbi();

    public List<User> all() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM users")
                        .mapToBean(User.class)
                        .list()
        );
    }

    public User findById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM users WHERE id = :id AND deleted_at IS NULL")
                        .bind("id", id)
                        .mapToBean(User.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public void save(User user) {
        jdbi.useHandle(handle ->
                handle.createUpdate("INSERT INTO users (email, password, fullname, phone, role, status, avatar, email_verified, created_at) " +
                                "VALUES (:email, :password, :fullname, :phone, :role, :status, :avatar, :emailVerified, CURRENT_TIMESTAMP)")
                        .bindBean(user)
                        .execute()
        );
    }

    public void update(User user) {
        jdbi.useHandle(handle ->
                handle.createUpdate("UPDATE users SET email = :email, fullname = :fullname, phone = :phone, role = :role, " +
                                "status = :status, updated_at = CURRENT_TIMESTAMP WHERE id = :id")
                        .bindBean(user)
                        .execute()
        );
    }

    public void delete(int id) {
        jdbi.useHandle(handle ->
                handle.createUpdate("UPDATE users SET deleted_at = CURRENT_TIMESTAMP WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
    }

    public User find(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM users WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(User.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public User show(int id) {
        User user = jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM users WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(User.class)
                        .findFirst()
                        .orElse(null)
        );

        if (user != null) {
            List<UserAddress> addresses = jdbi.withHandle(handle ->
                    handle.createQuery("SELECT * FROM user_addresses WHERE userId = :userId")
                            .bind("userId", user.getId())
                            .mapToBean(UserAddress.class)
                            .list()
            );
            user.setUserAddresses(addresses);
        }

        return user;
    }
}