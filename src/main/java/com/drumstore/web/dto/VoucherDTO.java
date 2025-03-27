package com.drumstore.web.dto;

import java.sql.Timestamp;

public class VoucherDTO {
    private int id;
    private String code;
    private byte discountType;
    private double discountValue;       // Thay từ BigDecimal sang double
    private double minOrderValue;       // Thay từ BigDecimal sang double
    private double maxDiscountValue;    // Thay từ BigDecimal sang double
    private Timestamp startDate;
    private Timestamp endDate;
    private byte status;
    private int perUserLimit;
    public  VoucherDTO() {}

    public VoucherDTO(int id, String code, byte discountType, double discountValue,
                      double minOrderValue, double maxDiscountValue,
                      Timestamp startDate, Timestamp endDate, byte status, int perUserLimit) {
        this.id = id;
        this.code = code;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.minOrderValue = minOrderValue;
        this.maxDiscountValue = maxDiscountValue;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.perUserLimit = perUserLimit;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public byte getDiscountType() {
        return discountType;
    }

    public void setDiscountType(byte discountType) {
        this.discountType = discountType;
    }

    public double getDiscountValue() {    // Thay BigDecimal sang double
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {    // Thay BigDecimal sang double
        this.discountValue = discountValue;
    }

    public double getMinOrderValue() {    // Thay BigDecimal sang double
        return minOrderValue;
    }

    public void setMinOrderValue(double minOrderValue) {    // Thay BigDecimal sang double
        this.minOrderValue = minOrderValue;
    }

    public double getMaxDiscountValue() {    // Thay BigDecimal sang double
        return maxDiscountValue;
    }

    public void setMaxDiscountValue(double maxDiscountValue) {    // Thay BigDecimal sang double
        this.maxDiscountValue = maxDiscountValue;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    public byte getStatus() {
        return status;
    }

    public void setStatus(byte status) {
        this.status = status;
    }

    public int getPerUserLimit() {
        return perUserLimit;
    }

    public void setPerUserLimit(int perUserLimit) {
        this.perUserLimit = perUserLimit;
    }

    // Kiểm tra trạng thái voucher
    public boolean isActive() {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        return status == 1 &&
                startDate.before(now) &&
                endDate.after(now);
    }

    // Tính số tiền giảm
    public double calculateDiscount(double orderValue) {
        if (!isActive() || orderValue < minOrderValue) {
            return 0.0;
        }

        double discount;
        // Giảm theo phần trăm
        if (discountType == 0) {
            discount = orderValue * (discountValue / 100.0);
            if (maxDiscountValue != 0 && discount > maxDiscountValue) {
                discount = maxDiscountValue;
            }
        } else {
            discount = discountValue;
        }

        return discount;
    }

    @Override
    public String toString() {
        return "VoucherDTO{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", discountType=" + discountType +
                ", discountValue=" + discountValue +
                ", minOrderValue=" + minOrderValue +
                ", maxDiscountValue=" + maxDiscountValue +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", status=" + status +
                ", perUserLimit=" + perUserLimit +
                '}';
    }
}