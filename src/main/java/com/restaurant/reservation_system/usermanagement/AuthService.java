package com.restaurant.reservation_system.usermanagement;

import com.restaurant.reservation_system.adminmanagement.Admin;
import com.restaurant.reservation_system.adminmanagement.AdminRepository;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    private final CustomerRepository customerRepository;
    private final AdminRepository adminRepository;

    public AuthService(CustomerRepository customerRepository,
                       AdminRepository adminRepository) {
        this.customerRepository = customerRepository;
        this.adminRepository = adminRepository;
    }

    public Object login(String email, String password) {

        Admin admin = adminRepository.findByEmail(email).orElse(null);

        if (admin != null && admin.getPassword().equals(password)) {
            return admin;
        }

        Customer customer = customerRepository.findByEmail(email).orElse(null);

        if (customer != null && customer.getPassword().equals(password)) {
            return customer;
        }

        throw new RuntimeException("Invalid email or password");
    }
}