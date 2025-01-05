package com.drumstore.web.repositories;

import com.drumstore.web.models.UserAddress;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class UserAddressRepository {
    private final Jdbi jdbi = DBConnection.getJdbi();

    // Lấy tất cả địa chỉ
    public List<UserAddress> all() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM user_addresses")
                        .mapToBean(UserAddress.class)
                        .list()
        );
    }

    public UserAddress find(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM user_addresses WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(UserAddress.class)
                        .first()
        );
    }

    public boolean create(UserAddress address) {
        // Kiểm tra nếu đã tồn tại địa chỉ chính
        if (address.isIsDefault()) {
            boolean hasDefault = jdbi.withHandle(handle ->
                    handle.createQuery("SELECT COUNT(*) FROM user_addresses WHERE user_id = :userId AND is_default = true")
                            .bind("userId", address.getUserId())
                            .mapTo(Integer.class)
                            .one() > 0
            );

            // Nếu đã tồn tại địa chỉ chính, bỏ đặt làm chính cho địa chỉ cũ
            if (hasDefault) {
                jdbi.useHandle(handle ->
                        handle.createUpdate("UPDATE user_addresses SET is_default = false WHERE user_id = :userId")
                                .bind("userId", address.getUserId())
                                .execute()
                );
            }
        }

        // Thêm địa chỉ mới
        int result = jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO user_addresses (user_id, address, phone, province_id, district_id, ward_id, is_default) " +
                                "VALUES (:userId, :address, :phone, :provinceId, :districtId, :wardId, :isDefault)")
                        .bindBean(address)
                        .execute()
        );
        return result > 0;
    }

    public boolean update(int id, UserAddress address) {
        System.out.println(address);
        if (address.isIsDefault()) {
            jdbi.useHandle(handle ->
                    handle.createUpdate("UPDATE user_addresses SET isDefault = false WHERE userId = :userId")
                            .bind("userId", address.getUserId())
                            .execute()
            );
        }

        int result = jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE user_addresses SET address = :address, phone = :phone, " +
                                "provinceId = :provinceId, districtId = :districtId, wardId = :wardId, isDefault = :isDefault " +
                                "WHERE id = :id")
                        .bindBean(address)
                        .execute()
        );
        return result > 0;
    }


    public boolean delete(int id) {
        int result = jdbi.withHandle(handle ->
                handle.createUpdate("DELETE FROM user_addresses WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
        return result > 0;
    }
}
