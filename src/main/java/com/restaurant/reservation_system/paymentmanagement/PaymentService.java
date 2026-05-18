package com.restaurant.reservation_system.paymentmanagement;

import com.restaurant.reservation_system.offermanagement.OfferCode;
import com.restaurant.reservation_system.offermanagement.OfferCodeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class PaymentService {

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private OfferCodeRepository offerCodeRepository;

    public List<Payment> getAllPayments() {
        return paymentRepository.findAll();
    }

    public List<Payment> getPaymentsByStatus(String status) {
        return paymentRepository.findByStatus(status);
    }

    public Payment processPayment(PaymentRequest request) {
        Payment payment = new Payment();
        payment.setCustomerName(request.getCustomerName());
        payment.setCustomerEmail(request.getCustomerEmail());
        payment.setAmount(request.getAmount());
        payment.setPaymentMethod(request.getPaymentMethod());

        // Store only last 4 digits of card
        if (request.getCardNumber() != null && request.getCardNumber().length() >= 4) {
            String last4 = request.getCardNumber().substring(request.getCardNumber().length() - 4);
            payment.setCardNumber("****-****-****-" + last4);
        }

        // Apply offer code if provided
        double discount = 0;
        if (request.getOfferCode() != null && !request.getOfferCode().isEmpty()) {
            Optional<OfferCode> offerOpt = offerCodeRepository.findByCodeAndActiveTrue(
                    request.getOfferCode().toUpperCase()
            );
            if (offerOpt.isPresent()) {
                OfferCode offer = offerOpt.get();
                discount = request.getAmount() * (offer.getDiscountPercent() / 100.0);
                payment.setOfferCodeUsed(offer.getCode());
                payment.setDiscountAmount(discount);
            }
        }

        double finalAmount = request.getAmount() - discount;
        payment.setFinalAmount(finalAmount);

        // Always PAID for uni project demo
        payment.setStatus("PAID");

        return paymentRepository.save(payment);
    }

    public Payment updatePaymentStatus(Long id, String status) {
        Payment payment = paymentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Payment not found"));
        payment.setStatus(status);
        return paymentRepository.save(payment);
    }

    public void deletePayment(Long id) {
        paymentRepository.deleteById(id);
    }

    public PaymentSummary getSummary() {
        List<Payment> all = paymentRepository.findAll();
        long total = all.size();
        long paid = all.stream().filter(p -> "PAID".equals(p.getStatus())).count();
        long pending = all.stream().filter(p -> "PENDING".equals(p.getStatus())).count();
        double revenue = all.stream()
                .filter(p -> "PAID".equals(p.getStatus()))
                .mapToDouble(Payment::getFinalAmount)
                .sum();
        return new PaymentSummary(total, paid, pending, revenue);
    }
}