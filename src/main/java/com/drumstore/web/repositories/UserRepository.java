package com.drumstore.web.repositories;

import com.drumstore.web.models.User;
import com.drumstore.web.models.UserAddress;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.util.LinkedHashMap;
import java.util.List;

public class UserRepository extends BaseRepository<User> {
    private final Jdbi jdbi = DBConnection.getJdbi();

    public int save(User user) {
        String query = """
                INSERT INTO users (email, password, fullname, phone, role, status, avatar, email_verified, created_at)
                VALUES (:email, :password, :fullname, :phone, :role, :status, :avatar, :emailVerified, CURRENT_TIMESTAMP)
                """;
        return super.save(query, user);
    }

    public int update(User user) {
        String query = """
                UPDATE users SET email = :email, fullname = :fullname, updatedAt = CURRENT_TIMESTAMP WHERE id = :id
                """;
        return super.update(query, user);
    }


    public User show(int id) {
        User user = find(id);
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

    public User detail(int id) {
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