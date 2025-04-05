package com.drumstore.web.repositories;

import com.drumstore.web.dto.PermissionDTO;
import com.drumstore.web.utils.DBConnection;
import com.drumstore.web.utils.OperationResult;
import org.jdbi.v3.core.Jdbi;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class PermissionRepository {
    private final Jdbi jdbi = DBConnection.getJdbi();

    public List<PermissionDTO> getAllPermissions() {
        String sql = "SELECT * FROM permissions";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(PermissionDTO.class)
                        .list()
        );
    }

    public PermissionDTO getPermissionById(int id) {
        String sql = "SELECT * FROM permissions WHERE id = :id";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .mapToBean(PermissionDTO.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public OperationResult<Void> createPermission(String name, String description) {
        String sql = "INSERT INTO permissions (name, description) VALUES (:name, :description)";
        try {
            boolean success = jdbi.withHandle(handle ->
                    handle.createUpdate(sql)
                            .bind("name", name)
                            .bind("description", description)
                            .execute() > 0
            );

            if (success) {
                return OperationResult.success("Tạo quyền thành công");
            } else {
                return OperationResult.failure("Không thể tạo quyền");
            }
        } catch (Exception e) {
            Throwable cause = e.getCause();

            if (cause instanceof SQLIntegrityConstraintViolationException ||
                    (e.getMessage() != null && e.getMessage().toLowerCase().contains("duplicate"))) {
                return OperationResult.failure("Tên quyền đã tồn tại trong hệ thống");
            }

            return OperationResult.failure("Đã xảy ra lỗi: " + e.getMessage());
        }
    }

    public List<Integer> getUserIdsByPermissionId(int id) {
        String sql = """
            SELECT DISTINCT u.id
            FROM users u
            JOIN user_roles ur ON u.id = ur.userId
            JOIN role_permissions rp ON ur.roleId = rp.roleId
            WHERE rp.permissionId = :id
        """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .mapTo(Integer.class)
                        .list()
        );
    }

    public OperationResult<Void> updatePermission(int id, String name, String description) {
        String sql = "UPDATE permissions SET name = :name, description = :description WHERE id = :id";
        try {
            boolean success = jdbi.withHandle(handle ->
                    handle.createUpdate(sql)
                            .bind("id", id)
                            .bind("name", name)
                            .execute() > 0
            );

            if (success) {
                return OperationResult.success("Cập nhật quyền thành công");
            } else {
                return OperationResult.failure("Không tìm thấy quyền để cập nhật");
            }
        } catch (Exception e) {
            Throwable cause = e.getCause();

            if (cause instanceof SQLIntegrityConstraintViolationException ||
                    (e.getMessage() != null && e.getMessage().toLowerCase().contains("duplicate"))) {
                return OperationResult.failure("Tên quyền đã tồn tại trong hệ thống");
            }

            return OperationResult.failure("Đã xảy ra lỗi khi cập nhật: " + e.getMessage());
        }
    }

    public OperationResult<Void> deletePermission(int id) {
        String sql = "DELETE FROM permissions WHERE id = :id";
        try {
            boolean success = jdbi.withHandle(handle ->
                    handle.createUpdate(sql)
                            .bind("id", id)
                            .execute() > 0
            );

            if (success) {
                return OperationResult.success("Xóa quyền thành công");
            } else {
                return OperationResult.failure("Không tìm thấy quyền để xóa");
            }
        } catch (Exception e) {
            return OperationResult.failure("Đã xảy ra lỗi khi xóa: " + e.getMessage());
        }
    }
}
