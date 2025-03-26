package com.drumstore.web.repositories;

import com.drumstore.web.dto.RoleDTO;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

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
}
