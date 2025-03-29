package com.drumstore.web.services;

import com.drumstore.web.models.Payment;
import com.drumstore.web.repositories.PaymentRepository;

public class PaymentService {
    private PaymentRepository paymentRepository = new PaymentRepository();

    public void updatePayment(int orderId , String transactionId) {
        paymentRepository.updatePayment(orderId,transactionId);
    }
}
