package com.restaurant.reservation_system.paymentmanagement;

import com.restaurant.reservation_system.offermanagement.Offer;
import com.restaurant.reservation_system.offermanagement.OfferRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class PaymentService {
    @Autowired private com.restaurant.reservation_system.config.Access access;

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private OfferRepository offerRepository;

    public List<Payment> getAllPayments() {
        return paymentRepository.findAll();
    }

    public List<Payment> getPaymentsByStatus(String status) {
        return paymentRepository.findByStatus(status);
    }

    public Payment processPayment(PaymentRequest request) {
        if(!access.isAdmin()) request.setCustomerEmail(access.email());
        if(!Double.isFinite(request.getAmount()) || request.getAmount()<=0) throw new IllegalArgumentException("Amount must be positive");
        if(!java.util.Set.of("CARD","CASH","ONLINE").contains(request.getPaymentMethod())) throw new IllegalArgumentException("Invalid payment method");
        if("CARD".equals(request.getPaymentMethod()) && (request.getCardNumber()==null || !request.getCardNumber().matches("[0-9]{16}"))) throw new IllegalArgumentException("A 16-digit demo card is required");
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
            Offer offer = offerRepository.findByOfferCodeIgnoreCase(request.getOfferCode().trim());
            boolean valid = offer != null && offer.isActive() && (offer.getStartDate()==null || !java.time.LocalDate.now().isBefore(offer.getStartDate())) && (offer.getEndDate()==null || !java.time.LocalDate.now().isAfter(offer.getEndDate()));
            if (!valid) throw new IllegalArgumentException("Invalid or expired offer code");
            if (valid) {
                if(offer.getDiscountPercentage()<0 || offer.getDiscountPercentage()>100) throw new IllegalArgumentException("Invalid discount");
                discount = request.getAmount() * (offer.getDiscountPercentage() / 100.0);
                payment.setOfferCodeUsed(offer.getOfferCode());
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
        try { PaymentStatus.valueOf(status); } catch(Exception ex) { throw new IllegalArgumentException("Invalid payment status"); }
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