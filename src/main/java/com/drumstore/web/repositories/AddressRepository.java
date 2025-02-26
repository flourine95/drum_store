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
                    a.fullname AS fullname,
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

    public boolean addAddress(AddressDTO addressDTO) {
        try {
            // Nếu địa chỉ mới là mặc định, cập nhật các địa chỉ khác thành không mặc định
            if (addressDTO.isIsDefault()) {
                jdbi.useHandle(handle ->
                        handle.createUpdate("UPDATE user_addresses SET isDefault = false WHERE userId = :userId")
                                .bind("userId", addressDTO.getUserId())
                                .execute()
                );
            }

            // Thêm địa chỉ mới
            String sql = """
                        INSERT INTO user_addresses (userId, address,fullname, phone, provinceId, districtId, wardId, isDefault)
                        VALUES (:userId, :address,:fullname, :phone, :provinceId, :districtId, :wardId, :isDefault)
                    """;

            int result = jdbi.withHandle(handle ->
                    handle.createUpdate(sql)
                            .bindBean(addressDTO)
                            .execute()
            );

            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateAddress(AddressDTO addressDTO) {
        try {
            // Nếu địa chỉ mới là mặc định, cập nhật các địa chỉ khác thành không mặc định
            if (addressDTO.isIsDefault()) {
                jdbi.useHandle(handle ->
                        handle.createUpdate("UPDATE user_addresses SET isDefault = false WHERE userId = :userId")
                                .bind("userId", addressDTO.getUserId())
                                .execute()
                );
            }

            // Cập nhật địa chỉ
            String sql = """
                    UPDATE user_addresses
                    SET address = :address, fullname = :fullname, phone = :phone,
                        provinceId = :provinceId, districtId = :districtId, wardId = :wardId, isDefault = :isDefault
                    WHERE id = :id AND userId = :userId
                    """;

            int result = jdbi.withHandle(handle ->
                    handle.createUpdate(sql)
                            .bindBean(addressDTO)
                            .execute()
            );

            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteAddress(int addressId, int id) {
        String sql = """
                DELETE FROM user_addresses
                WHERE id = :addressId AND userId = :userId
                """;
        int result = jdbi.withHandle(handle -> handle.createUpdate(sql)
                .bind("addressId", addressId)
                .bind("userId", id)
                .execute()
        );
        return result > 0;
    }

    public AddressDTO getAddressById(int addressId) {
        String sql = """
                SELECT
                    a.id AS id, a.userId AS userId, a.address AS address,
                    a.fullname AS fullname,
                    a.phone AS phone, a.provinceId AS provinceId,
                    a.districtId AS districtId, a.wardId AS wardId, a.isDefault AS isDefault
                FROM user_addresses a
                WHERE a.id = :addressId
                """;
        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("addressId", addressId)
                .mapToBean(AddressDTO.class)
                .findFirst()
                .orElse(null)
        );
    }
}
