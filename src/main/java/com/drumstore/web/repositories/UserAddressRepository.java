package com.drumstore.web.repositories;

import com.drumstore.web.dto.UserAddressDTO;
import com.drumstore.web.models.UserAddress;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserAddressRepository extends BaseRepository<UserAddress> {
    private final Jdbi jdbi = DBConnection.getJdbi();


    public boolean create(UserAddress address) {
        if (address.isIsDefault()) {
            boolean hasDefault = jdbi.withHandle(handle ->
                    handle.createQuery("SELECT COUNT(*) FROM user_addresses WHERE user_id = :userId AND is_default = true")
                            .bind("userId", address.getUserId())
                            .mapTo(Integer.class)
                            .one() > 0
            );

            if (hasDefault) {
                jdbi.useHandle(handle ->
                        handle.createUpdate("UPDATE user_addresses SET is_default = false WHERE user_id = :userId")
                                .bind("userId", address.getUserId())
                                .execute()
                );
            }
        }

        int result = jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO user_addresses (user_id, address, phone, province_id, district_id, ward_id, is_default) " +
                                "VALUES (:userId, :address, :phone, :provinceId, :districtId, :wardId, :isDefault)")
                        .bindBean(address)
                        .execute()
        );
        return result > 0;
    }

    public int update(UserAddress entity) {
        if (entity.isIsDefault()) {
            jdbi.useHandle(handle ->
                    handle.createUpdate("UPDATE user_addresses SET isDefault = false WHERE userId = :userId")
                            .bind("userId", entity.getUserId())
                            .execute()
            );
        }
        String updateQuery = "UPDATE user_addresses SET address = :address, phone = :phone, " +
                "provinceId = :provinceId, districtId = :districtId, wardId = :wardId, isDefault = :isDefault " +
                "WHERE id = :id";
        return super.update(updateQuery, entity);
    }

    public int save(UserAddress entity) {
        if (entity.isIsDefault()) {
            jdbi.useHandle(handle ->
                    handle.createUpdate("UPDATE user_addresses SET isDefault = false WHERE userId = :userId")
                            .bind("userId", entity.getUserId())
                            .execute()
            );
        }
        String insertQuery = "INSERT INTO user_addresses (userId, address, phone, provinceId, districtId, wardId, isDefault) " +
                "VALUES (:userId, :address, :phone, :provinceId, :districtId, :wardId, :isDefault)";
        return super.save(insertQuery, entity);
    }

    public int isExistsUserAddress(int userId) {
        String sql = """
            SELECT COUNT(*) FROM user_addresses WHERE userid = :userId
            """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", userId)
                        .mapTo(int.class)
                        .one()
        );
    }

    public Map<String, List<UserAddressDTO>> getMainAddressAndSubAddress(int userId) {
        Map<String, List<UserAddressDTO>> map = new HashMap<>();
        List<UserAddressDTO> mainAddress = new ArrayList<>();
        List<UserAddressDTO> subAddress = new ArrayList<>();

        String sql = """
                    SELECT 
                        us.id, 
                        p.name AS province, 
                        d.name AS district, 
                        w.name AS ward, 
                        us.address AS fullAddress, 
                        us.isDefault 
                    FROM user_addresses us
                    INNER JOIN provinces p ON us.provinceId = p.id
                    INNER JOIN districts d ON us.districtId = d.id
                    INNER JOIN wards w ON us.wardId = w.id
                    WHERE us.userId = :userId
                """;
        List<UserAddressDTO> addresses = jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", userId)
                        .mapToBean(UserAddressDTO.class)
                        .list()
        );

        for (UserAddressDTO address : addresses) {
            if (address.getIsDefault() == 1) {
                mainAddress.add(address);
            } else {
                subAddress.add(address);
            }
        }

        map.put("mainAddress", mainAddress);
        map.put("subAddress", subAddress);

        return map;
    }

}
