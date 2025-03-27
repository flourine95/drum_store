package com.drumstore.web.repositories;

import com.drumstore.web.models.Payment;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

public class PaymentRepository extends BaseRepository<Payment> {
    private final Jdbi jdbi;

    public PaymentRepository() {
        jdbi = DBConnection.getJdbi();
    }

    public Payment save(Payment payment) {
        String insertQuery = "INSERT INTO payments (orderId, paymentMethod, status, amount, paymentDate, createdAt) " +
                "VALUES (:orderId, :paymentMethod, :status, :amount, :paymentDate, :createdAt)";
        int paymentId = jdbi.withHandle(handle ->
                handle.createUpdate(insertQuery)
                        .bindBean(payment)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(int.class)
                        .one()
        );
        payment.setId(paymentId);
        return payment;
    }
}
