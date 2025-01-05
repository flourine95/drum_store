package com.drumstore.web.repositories;

import com.drumstore.web.models.User;
import com.drumstore.web.models.UserAddress;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.stream.Collectors;

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

    public User findWithDetails(int id) {
        String sql = """
                SELECT
                    u.id AS u_id, u.email AS u_email, u.fullname AS u_fullname,
                    u.role AS u_role, u.status AS u_status, u.avatar AS u_avatar,
                    u.oauthProvider AS u_oauthProvider, u.oauthId AS u_oauthId,
                    u.emailVerified AS u_emailVerified, u.createdAt AS u_createdAt,
                    u.updatedAt AS u_updatedAt, u.deletedAt AS u_deletedAt,
                    a.id AS a_id, a.userId AS a_userId, a.address AS a_address,
                    a.phone AS a_phone, a.provinceId AS a_provinceId,
                    a.districtId AS a_districtId, a.wardId AS a_wardId, a.isDefault AS a_isDefault
                FROM users u
                         LEFT JOIN user_addresses a ON u.id = a.userId
                WHERE u.id = :id
                """;
        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("id", id)
                .registerRowMapper(BeanMapper.factory(User.class, "u"))
                .registerRowMapper(BeanMapper.factory(UserAddress.class, "a"))
                .reduceRows(new LinkedHashMap<Integer, User>(), (map, row) -> {
                    User user = map.computeIfAbsent(row.getColumn("u_id", Integer.class), _ -> row.getRow(User.class));
                    if (row.getColumn("a_id", Integer.class) != null) {
                        user.addAddress(row.getRow(UserAddress.class));
                    }
                    return map;
                })
                .values()
                .stream()
                .findFirst()
                .orElse(null)
        );
    }

}