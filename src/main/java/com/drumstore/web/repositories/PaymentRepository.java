package com.drumstore.web.repositories;

import com.drumstore.web.constants.PaymentConstants;
import com.drumstore.web.models.Payment;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

public class PaymentRepository extends BaseRepository<Payment> {
    private final Jdbi jdbi;

    public PaymentRepository() {
        jdbi = DBConnection.getJdbi();
    }

    public Payment save(Handle handle, Payment payment) {
        String insertQuery = "INSERT INTO payments (orderId, paymentMethod, status, amount, paymentDate, createdAt) " +
                "VALUES (:orderId, :paymentMethod, :status, :amount, :paymentDate, :createdAt)";
        int paymentId =
                handle.createUpdate(insertQuery)
                        .bindBean(payment)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(int.class)
                        .one();
        payment.setId(paymentId);
        return payment;
    }

    public void updatePayment(int orderId , String transactionId) {
        String sql = "UPDATE payments SET status = :status, transactionId = :transactionId WHERE orderId = :orderId";
         jdbi.useHandle(handle ->
                handle.createUpdate(sql)
                        .bind("orderId" , orderId)
                        .bind("status" , PaymentConstants.Status.COMPLETED.getValue())
                        .bind("transactionId" , transactionId)
                        .execute()
                );
    }
}
