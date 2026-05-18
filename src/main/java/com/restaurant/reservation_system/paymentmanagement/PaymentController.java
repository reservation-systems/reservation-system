package com.restaurant.reservation_system.paymentmanagement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/payments")
@CrossOrigin("*")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @GetMapping
    public List<Payment> getAllPayments(@RequestParam(required = false) String status) {
        if (status != null && !status.isEmpty()) {
            return paymentService.getPaymentsByStatus(status);
        }
        return paymentService.getAllPayments();
    }

    @GetMapping("/summary")
    public PaymentSummary getSummary() {
        return paymentService.getSummary();
    }

    @PostMapping("/process")
    public Payment processPayment(@RequestBody PaymentRequest request) {
        return paymentService.processPayment(request);
    }

    @PutMapping("/{id}/status")
    public Payment updateStatus(@PathVariable Long id, @RequestParam String status) {
        return paymentService.updatePaymentStatus(id, status);
    }

    @DeleteMapping("/{id}")
    public String deletePayment(@PathVariable Long id) {
        paymentService.deletePayment(id);
        return "Payment deleted successfully";
    }
}