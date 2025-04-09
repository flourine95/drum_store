package com.drumstore.web.repositories;

import com.drumstore.web.dto.VoucherDTO;
import com.drumstore.web.models.Product;
import com.drumstore.web.models.VoucherUser;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.sql.Timestamp;
import java.util.Optional;

public class VoucherRepository{
    private final Jdbi jdbi;

    public VoucherRepository() {
        this.jdbi = DBConnection.getJdbi();
    }


    public Optional<VoucherDTO> findByCode(String code) {
        String sql = """
                SELECT
                    v.id AS v_id, v.code AS v_code, v.discountType AS v_discountType,
                    v.discountValue AS v_discountValue, v.minOrderValue AS v_minOrderValue,
                    v.maxDiscountValue AS v_maxDiscountValue, v.startDate AS v_startDate,
                    v.endDate AS v_endDate, v.status AS v_status, v.perUserLimit AS v_perUserLimit,
                    v.usageLimit AS v_usageLimit
                FROM vouchers v
                WHERE v.code = :code
                """;
        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("code", code)
                .registerRowMapper(BeanMapper.factory(VoucherDTO.class, "v"))
                .mapTo(VoucherDTO.class)
                .findFirst());
    }

    public Optional<VoucherDTO> findById(int voucherId) {
        String sql = """
                SELECT
                    v.id AS v_id, v.code AS v_code, v.discountType AS v_discountType,
                    v.discountValue AS v_discountValue, v.minOrderValue AS v_minOrderValue,
                    v.maxDiscountValue AS v_maxDiscountValue, v.startDate AS v_startDate,
                    v.endDate AS v_endDate, v.status AS v_status, v.perUserLimit AS v_perUserLimit,
                    v.usageLimit AS v_usageLimit
                FROM vouchers v
                WHERE v.id = :voucherId
                """;
        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("voucherId", voucherId)
                .registerRowMapper(BeanMapper.factory(VoucherDTO.class, "v"))
                .mapTo(VoucherDTO.class)
                .findFirst());
    }

    public Optional<VoucherUser> findVoucherUser(int voucherId, int userId) {
        String sql = """
            SELECT uv.* 
            FROM user_vouchers uv
            WHERE uv.voucherId = :voucherId AND uv.userId = :userId
            """;
        try {
            return jdbi.withHandle(handle -> handle.createQuery(sql)
                    .bind("voucherId", voucherId)
                    .bind("userId", userId)
                    .map((rs, ctx) -> {
                        VoucherUser voucherUser = new VoucherUser();
                        voucherUser.setId(rs.getInt("id"));
                        voucherUser.setUserId(rs.getInt("userId"));
                        voucherUser.setVoucherId(rs.getInt("voucherId"));
                        voucherUser.setUsed(rs.getInt("used"));
                        // Ánh xạ TIMESTAMP sang LocalDateTime
                        Timestamp usedAt = rs.getTimestamp("usedAt");
                        voucherUser.setUsedAt(usedAt != null ? usedAt.toLocalDateTime() : null);
                        Timestamp createdAt = rs.getTimestamp("createdAt");
                        voucherUser.setCreatedAt(createdAt != null ? createdAt.toLocalDateTime() : null);
                        return voucherUser;
                    })
                    .stream()
                    .findFirst());
        } catch (Exception e) {
            throw e;
        }
    }

//    public int getTotalUsageCount(int voucherId) {
//        String sql = """
//                SELECT COUNT(*)
//                FROM user_vouchers uv
//                WHERE uv.voucherId = :voucherId AND uv.used = 1
//                FOR UPDATE
//                """;
//        return jdbi.withHandle(handle -> handle.createQuery(sql)
//                .bind("voucherId", voucherId)
//                .mapTo(Integer.class)
//                .one());
//    }

    public int getUserUsageCount(int voucherId, int userId) {
        String sql = """
                SELECT COUNT(*)
                FROM user_vouchers uv
                WHERE uv.voucherId = :voucherId AND uv.userId = :userId AND uv.used = 1
                FOR UPDATE
                """;
        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("voucherId", voucherId)
                .bind("userId", userId)
                .mapTo(Integer.class)
                .one());
    }


    public void addUserVoucher(Long userId, int voucherId, boolean used, Timestamp usedAt, Timestamp createdAt) {
        String sql = """
                INSERT INTO user_vouchers (userId, voucherId, used, usedAt, createdAt)
                VALUES (:userId, :voucherId, :used, :usedAt, :createdAt)
                """;
        jdbi.withHandle(handle -> handle.createUpdate(sql)
                .bind("userId", userId)
                .bind("voucherId", voucherId)
                .bind("used", used ? 1 : 0)
                .bind("usedAt", usedAt)
                .bind("createdAt", createdAt)
                .execute());
    }

    public void updateUserVoucher(Long userId, int voucherId, boolean used, Timestamp usedAt) {
        String sql = """
                UPDATE user_vouchers
                SET used = :used, usedAt = :usedAt
                WHERE userId = :userId AND voucherId = :voucherId AND used = 0
                """;
        jdbi.withHandle(handle -> handle.createUpdate(sql)
                .bind("userId", userId)
                .bind("voucherId", voucherId)
                .bind("used", used ? 1 : 0)
                .bind("usedAt", usedAt)
                .execute());
    }


}