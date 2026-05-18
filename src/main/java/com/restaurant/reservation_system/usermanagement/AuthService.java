package com.restaurant.reservation_system.usermanagement;

import org.springframework.stereotype.Service;

@Service
public class AuthService {

    private final CustomerRepository customerRepository;

    public AuthService(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    public Customer login(String email, String password) {
        Customer customer = customerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Invalid email or password"));

        if (!customer.getPassword().equals(password)) {
            throw new RuntimeException("Invalid email or password");
        }

        return customer;
    }
}