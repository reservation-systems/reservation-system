package com.restaurant.reservation_system.paymentmanagement;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PaymentRepository extends JpaRepository<Payment, Long> {
    List<Payment> findByStatus(String status);
    List<Payment> findByCustomerEmail(String email);
}