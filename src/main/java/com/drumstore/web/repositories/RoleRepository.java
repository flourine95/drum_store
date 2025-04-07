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
        String sql = "SELECT * FROM roles";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(RoleDTO.class)
                        .list()
        );
    }

    public List<Integer> getUserIdsByRoleId(int roleId) {
        String sql = "SELECT userId FROM user_roles WHERE roleId = :roleId";
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

    public boolean deleteRole(int id) {
        try {
            jdbi.useTransaction(handle -> {
                handle.createUpdate("DELETE FROM role_permissions WHERE roleId = :roleId")
                        .bind("roleId", id)
                        .execute();
                handle.createUpdate("DELETE FROM user_roles WHERE roleId = :roleId")
                        .bind("roleId", id)
                        .execute();
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
