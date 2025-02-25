package com.drumstore.web.repositories;

import com.drumstore.web.dto.AddressDTO;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class AddressRepository {
    private final Jdbi jdbi = DBConnection.getJdbi();
    public List<AddressDTO> getAddressesByUserId(int userId) {
        String sql = """
                SELECT
                    a.id AS id, a.userId AS userId, a.address AS address,
                    a.phone AS phone, a.provinceId AS provinceId,
                    a.districtId AS districtId, a.wardId AS wardId, a.isDefault AS isDefault
                FROM user_addresses a
                WHERE a.userId = :userId
                """;
        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("userId", userId)
                .mapToBean(AddressDTO.class)
                .list()
        );
    }
}
