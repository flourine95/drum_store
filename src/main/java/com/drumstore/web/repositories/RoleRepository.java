package com.drumstore.web.repositories;

import com.drumstore.web.dto.RoleDTO;
import com.drumstore.web.utils.DBConnection;
import com.drumstore.web.utils.OperationResult;
import org.jdbi.v3.core.Jdbi;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class RoleRepository {
    private final Jdbi jdbi = DBConnection.getJdbi();

    public List<RoleDTO> getAllRoles() {
        String sql = "SELECT id, name, description FROM roles";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(RoleDTO.class)
                        .list()
        );
    }

    public List<RoleDTO> getRolesByUserId(int userId) {
        String sql = """
                    SELECT r.id, r.name, r.description
                    FROM roles r
                    JOIN user_roles ur ON r.id = ur.roleId
                    WHERE ur.userId = :userId
                """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", userId)
                        .mapToBean(RoleDTO.class)
                        .list()
        );
    }

    public Set<String> getRoleNamesByUserId(int userId) {
        List<RoleDTO> roles = getRolesByUserId(userId);
        return roles.stream()
                .map(RoleDTO::getName)
                .collect(Collectors.toSet());
    }

    public void saveRolePermission(int roleId, int permissionId) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("INSERT INTO role_permissions (roleId, permissionId) VALUES (:roleId, :permissionId)")
                    .bind("roleId", roleId)
                    .bind("permissionId", permissionId)
                    .execute();
        });
    }

    public List<Integer> getUserIdsByRoleId(int roleId) {
        String sql = """
                    SELECT userId
                    FROM user_roles
                    WHERE roleId = :roleId
                """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("roleId", roleId)
                        .mapTo(Integer.class)
                        .list()
        );
    }

    public RoleDTO getRoleById(int id) {
        String sql = "SELECT * FROM roles WHERE id = :id";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .mapToBean(RoleDTO.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public OperationResult<Void> createRole(String name, String description) {
        String sql = "INSERT INTO roles (name, description) VALUES (:name, :description)";
        try {
            boolean success = jdbi.withHandle(handle ->
                    handle.createUpdate(sql)
                            .bind("name", name)
                            .bind("description", description)
                            .execute() > 0
            );

            if (success) {
                return OperationResult.success("Tạo vai trò thành công");
            } else {
                return OperationResult.failure("Không thể tạo vai trò");
            }
        } catch (Exception e) {
            Throwable cause = e.getCause();

            if (cause instanceof SQLIntegrityConstraintViolationException ||
                    (e.getMessage() != null && e.getMessage().toLowerCase().contains("duplicate"))) {
                return OperationResult.failure("Tên vai trò đã tồn tại trong hệ thống");
            }

            return OperationResult.failure("Đã xảy ra lỗi: " + e.getMessage());
        }
    }


    public OperationResult<Void> updateRole(int id, String name, String description) {
        String sql = "UPDATE roles SET name = :name, description = :description WHERE id = :id";
        try {
            boolean success = jdbi.withHandle(handle ->
                    handle.createUpdate(sql)
                            .bind("name", name)
                            .bind("description", description)
                            .bind("id", id)
                            .execute() > 0
            );

            if (success) {
                return OperationResult.success("Cập nhật vai trò thành công");
            } else {
                return OperationResult.failure("Không tìm thấy vai trò để cập nhật");
            }
        } catch (Exception e) {
            return OperationResult.failure("Đã xảy ra lỗi khi cập nhật: " + e.getMessage());
        }
    }


    public boolean deleteRole(int id) {
        try {
            jdbi.useTransaction(handle -> {
                // Delete role permissions first
                handle.createUpdate("DELETE FROM role_permissions WHERE roleId = :roleId")
                        .bind("roleId", id)
                        .execute();

                // Delete user roles
                handle.createUpdate("DELETE FROM user_roles WHERE roleId = :roleId")
                        .bind("roleId", id)
                        .execute();

                // Delete role
                handle.createUpdate("DELETE FROM roles WHERE id = :id")
                        .bind("id", id)
                        .execute();
            });
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean roleExists(String name) {
        String sql = "SELECT COUNT(*) FROM roles WHERE name = :name";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("name", name)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }

    public boolean createRole(RoleDTO roleRequest) {
        String sql = "INSERT INTO roles (name, description) VALUES (:name, :description)";
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bindBean(roleRequest)
                        .execute() > 0
        );
    }

    public boolean updateRole(RoleDTO roleRequest) {
        String sql = "UPDATE roles SET name = :name, description = :description WHERE id = :id";
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bindBean(roleRequest)
                        .execute() > 0
        );
    }
}
