package com.restaurant.reservation_system.paymentmanagement;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PaymentService {

    private final PaymentRepository paymentRepository;

    public PaymentService(PaymentRepository paymentRepository) {
        this.paymentRepository = paymentRepository;
    }

    public List<Payment> getAllPayments() {
        return paymentRepository.findAll();
    }

    public Payment createPayment(Payment payment) {
        payment.setStatus(PaymentStatus.PENDING);
        return paymentRepository.save(payment);
    }

    public Payment updatePaymentStatus(Long id, PaymentStatus status) {
        Payment payment = paymentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Payment not found"));

        payment.setStatus(status);
        return paymentRepository.save(payment);
    }

    public List<Payment> getPaymentsByCustomerEmail(String email) {
        return paymentRepository.findByCustomerEmail(email);
    }

    public void deletePayment(Long id) {
        paymentRepository.deleteById(id);
    }
}