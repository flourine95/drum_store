package com.drumstore.web.repositories;

import com.drumstore.web.dto.PermissionDTO;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class PermissionRepository {
    private final Jdbi jdbi = DBConnection.getJdbi();

    public List<PermissionDTO> getAllPermissions() {
        String sql = "SELECT id, name, description FROM permissions";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(PermissionDTO.class)
                        .list()
        );
    }

    public List<PermissionDTO> getPermissionsByUserId(int userId) {
        String sql = """
            SELECT DISTINCT p.id, p.name, p.description
            FROM permissions p
            JOIN role_permissions rp ON p.id = rp.permissionId
            JOIN user_roles ur ON rp.roleId = ur.roleId
            WHERE ur.userId = :userId
        """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", userId)
                        .mapToBean(PermissionDTO.class)
                        .list()
        );
    }

    public Set<String> getPermissionNamesByUserId(int userId) {
        List<PermissionDTO> permissions = getPermissionsByUserId(userId);
        return permissions.stream()
                .map(PermissionDTO::getName)
                .collect(Collectors.toSet());
    }
}
