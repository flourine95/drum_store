package com.drumstore.web.repositories;

import com.drumstore.web.dto.UserDTO;
import com.drumstore.web.models.User;
import com.drumstore.web.models.UserAddress;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;
import org.mindrot.jbcrypt.BCrypt;

import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.List;

public class UserRepository extends BaseRepository<User> {
    private final Jdbi jdbi = DBConnection.getJdbi();

    public int save(User user) {
        String query = """
                INSERT INTO users (email, password, fullname,  status, avatar, createdAt)
                VALUES (:email, :password, :fullname,  :status, :avatar, CURRENT_TIMESTAMP)
                """;
        return super.save(query, user);
    }

    public int save(UserDTO user) {
        String query = """
                INSERT INTO users (email, password, fullname, status, avatar, createdAt)
                VALUES (:email, :password, :fullname, :status, :avatar, CURRENT_TIMESTAMP)
                """;
        return jdbi.withHandle(handle ->
                handle.createUpdate(query)
                        .bindBean(user)
                        .execute()
        );
    }

    public int update(User user) {
        String query = """
                UPDATE users SET phone = :phone, fullname = :fullname WHERE id = :id
                """;
        return super.update(query, user);
    }

    public int update(UserDTO user) {
        String query = """
                UPDATE users SET phone = :phone, fullname = :fullname WHERE id = :id
                """;
        return jdbi.withHandle(handle ->
                handle.createUpdate(query)
                        .bindBean(user)
                        .execute()
        );
    }


    public User show(int id) {
        User user = null;
//        User user = find(id);
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
                    u.createdAt AS u_createdAt,
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
    public boolean register(User user) {
        String query = """
                INSERT INTO users (email, password, fullname, status, createdAt)
                VALUES (:email, :password, :fullname, 1, CURRENT_TIMESTAMP)
                """;
        return super.save(query, user) > 0;
    }

    public boolean isPhoneExists(String phone) {
        String query = "SELECT COUNT(*) FROM users WHERE phone = ?";
        return jdbi.withHandle(handle -> handle.createQuery(query).bind(0, phone).mapTo(Integer.class).one()) > 0;
    }

    public boolean isEmailExists(String email) {
        String query = "SELECT COUNT(*) FROM users WHERE email = ?";
        return jdbi.withHandle(handle -> handle.createQuery(query).bind(0, email).mapTo(Integer.class).one()) > 0;
    }

    public int createWithAddresses(User user, List<UserAddress> addresses) {
        return jdbi.withHandle(handle -> {
            // Bắt đầu transaction
            return handle.inTransaction(h -> {
                // Thêm user
                String userSql = """
                        INSERT INTO users (email, password, fullname, role, status, avatar, createdAt)
                        VALUES (:email, :password, :fullname, :role, :status, :avatar, CURRENT_TIMESTAMP)
                        """;

                int userId = h.createUpdate(userSql)
                        .bindBean(user)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Integer.class)
                        .one();

                // Thêm địa chỉ
                if (addresses != null && !addresses.isEmpty()) {
                    String addressSql = """
                            INSERT INTO user_addresses (userId, address, phone, provinceId, districtId, wardId, isDefault)
                            VALUES (:userId, :address, :phone, :provinceId, :districtId, :wardId, :isDefault)
                            """;

                    for (UserAddress address : addresses) {
                        address.setUserId(userId);
                        h.createUpdate(addressSql)
                                .bindBean(address)
                                .execute();
                    }
                }

                return userId;
            });
        });
    }

    public void saveResetToken(int userId, String token, LocalDateTime expiryTime) {
        String sql = """
                INSERT INTO password_resets
                (userId, token, expiryTime, used, createdAt)
                VALUES (:userId, :token, :expiryTime, 0, CURRENT_TIMESTAMP)
                """;
        jdbi.useHandle(handle ->
                handle.createUpdate(sql)
                        .bind("userId", userId)
                        .bind("token", token)
                        .bind("expiryTime", expiryTime)
                        .execute()
        );
    }

    public boolean isResetTokenValid(String token) {
        String sql = """
                SELECT COUNT(*) FROM password_resets 
                WHERE token = :token 
                AND expiryTime > CURRENT_TIMESTAMP
                AND used = 0
                """;
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("token", token)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }

    public void markResetTokenAsUsed(String token) {
        String sql = """
                UPDATE password_resets 
                SET used = 1, 
                    usedAt = CURRENT_TIMESTAMP 
                WHERE token = :token
                """;
        jdbi.useHandle(handle ->
                handle.createUpdate(sql)
                        .bind("token", token)
                        .execute()
        );
    }

    public User findByResetToken(String token) {
        String sql = """
                SELECT u.* FROM users u
                JOIN password_resets pr ON u.id = pr.userId
                WHERE pr.token = :token 
                AND pr.expiryTime > CURRENT_TIMESTAMP
                AND pr.used = 0
                """;
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("token", token)
                        .mapToBean(User.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public void updatePassword(int userId, String newPassword) {
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        String sql = "UPDATE users SET password = :password WHERE id = :userId";
        jdbi.useHandle(handle ->
                handle.createUpdate(sql)
                        .bind("userId", userId)
                        .bind("password", hashedPassword)
                        .execute()
        );
    }

    public boolean hasPermission(int userId, String permissionName) {
        String sql = """
                    SELECT COUNT(*) > 0
                    FROM users u
                    JOIN user_roles ur ON u.id = ur.userId
                    JOIN role_permissions rp ON ur.roleId = rp.roleId
                    JOIN permissions p ON rp.permissionId = p.id
                    WHERE u.id = :userId
                    AND p.name = :permissionName
                    AND u.status = 1
                """;

        try {
            return jdbi.withHandle(handle ->
                    handle.createQuery(sql)
                            .bind("userId", userId)
                            .bind("permissionName", permissionName)
                            .mapTo(Boolean.class)
                            .findFirst()
                            .orElse(false)
            );
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public UserDTO find2(int id) {
        String sql = """
                    SELECT
                        u.id AS u_id, u.email AS u_email, u.password AS u_password,
                        u.fullname AS u_fullname, u.phone AS u_phone, u.status AS u_status,
                        u.avatar AS u_avatar, u.createdAt AS u_createdAt,
                        r.id AS r_id, r.name AS r_name,
                        p.id AS p_id, p.name AS p_name
                    FROM users u
                    LEFT JOIN user_roles ur ON u.id = ur.userId
                    LEFT JOIN roles r ON ur.roleId = r.id
                    LEFT JOIN role_permissions rp ON r.id = rp.roleId
                    LEFT JOIN permissions p ON rp.permissionId = p.id
                    WHERE u.id = :id
                """;

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("id", id)
                .registerRowMapper(BeanMapper.factory(UserDTO.class, "u"))
                .reduceRows(new LinkedHashMap<Integer, UserDTO>(), (map, row) -> {
                    UserDTO user = map.computeIfAbsent(row.getColumn("u_id", Integer.class),
                            _ -> row.getRow(UserDTO.class)
                    );

                    String role = row.getColumn("r_name", String.class);
                    if (role != null) {
                        user.addRole(role);
                    }

                    String permission = row.getColumn("p_name", String.class);
                    if (permission != null) {
                        user.addPermission(permission);
                    }

                    return map;
                })
                .values()
                .stream()
                .findFirst()
                .orElse(null)
        );
    }

    public UserDTO login(String username, String password) {
        String query = """
                SELECT
                    u.id AS u_id, u.email AS u_email, u.password AS u_password, u.fullname AS u_fullname,
                    u.phone AS u_phone, u.status AS u_status, u.avatar AS u_avatar,
                    r.name AS r_name, p.name AS p_name
                FROM users u
                LEFT JOIN user_roles ur ON u.id = ur.userId
                LEFT JOIN roles r ON ur.roleId = r.id
                LEFT JOIN role_permissions rp ON r.id = rp.roleId
                LEFT JOIN permissions p ON rp.permissionId = p.id
                WHERE (u.email = :username) AND u.status = 1
                """;

        return jdbi.withHandle(handle -> handle.createQuery(query)
                .bind("username", username)
                .registerRowMapper(BeanMapper.factory(UserDTO.class, "u"))
                .reduceRows(new LinkedHashMap<Integer, UserDTO>(), (map, row) -> {
                    UserDTO user = map.computeIfAbsent(
                            row.getColumn("u_id", Integer.class),
                            _ -> row.getRow(UserDTO.class)
                    );

                    String role = row.getColumn("r_name", String.class);
                    if (role != null) {
                        user.addRole(role);
                    }

                    String permission = row.getColumn("p_name", String.class);
                    if (permission != null) {
                        user.addPermission(permission);
                    }

                    return map;
                })
                .values()
                .stream()
                .findFirst()
                .filter(user -> {
                    boolean isValid = BCrypt.checkpw(password, user.getPassword());
                    user.setPassword(null);
                    return isValid;
                })
                .orElse(null)
        );
    }

    public UserDTO findUser(String field, Object value) {
        String sql = """
                SELECT
                    u.id AS u_id, u.email AS u_email, u.password AS u_password, u.fullname AS u_fullname,
                    u.phone AS u_phone, u.status AS u_status, u.avatar AS u_avatar,
                    r.name AS r_name, p.name AS p_name
                FROM users u
                LEFT JOIN user_roles ur ON u.id = ur.userId
                LEFT JOIN roles r ON ur.roleId = r.id
                LEFT JOIN role_permissions rp ON r.id = rp.roleId
                LEFT JOIN permissions p ON rp.permissionId = p.id
                WHERE u.""" + field +
                """ 
                        = :value
                        """;
        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("value", value)
                .registerRowMapper(BeanMapper.factory(UserDTO.class, "u"))
                .reduceRows(new LinkedHashMap<Integer, UserDTO>(), (map, row) -> {
                    UserDTO user = map.computeIfAbsent(
                            row.getColumn("u_id", Integer.class),
                            _ -> row.getRow(UserDTO.class)
                    );

                    String role = row.getColumn("r_name", String.class);
                    if (role != null) {
                        user.addRole(role);
                    }

                    String permission = row.getColumn("p_name", String.class);
                    if (permission != null) {
                        user.addPermission(permission);
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