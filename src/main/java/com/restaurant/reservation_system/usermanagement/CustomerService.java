package com.restaurant.reservation_system.usermanagement;

import com.restaurant.reservation_system.usermanagement.Customer;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerService {

    private final CustomerRepository customerRepository;
    @org.springframework.beans.factory.annotation.Autowired private org.springframework.security.crypto.password.PasswordEncoder passwords;
    @org.springframework.beans.factory.annotation.Autowired private com.restaurant.reservation_system.config.Access access;

    public CustomerService(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    public List<Customer> getAllCustomers() {
        return customerRepository.findAll();
    }

    public Customer findByEmail(String email) {
        access.owner(email);
        return customerRepository.findByEmail(email).orElse(null);
    }

    public Customer registerCustomer(Customer customer) {
        customer.setId(null);
        customer.setEmail(com.restaurant.reservation_system.config.Passwords.email(customer.getEmail()));
        com.restaurant.reservation_system.config.Passwords.validate(customer.getPassword());
        if (customerRepository.existsByEmail(customer.getEmail())) {
            throw new IllegalArgumentException("Email already exists");
        }

        customer.setPassword(passwords.encode(customer.getPassword()));
        return customerRepository.save(customer);
    }
    public Customer updateCustomer(Long id, Customer updatedCustomer) {
        Customer customer = customerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        access.owner(customer.getEmail());
        String email = com.restaurant.reservation_system.config.Passwords.email(updatedCustomer.getEmail());
        if (!email.equals(customer.getEmail())) throw new IllegalArgumentException("Email cannot be changed because it identifies bookings and the login session");
        customer.setName(updatedCustomer.getName());
        customer.setEmail(email);
        if(updatedCustomer.getPassword()!=null && !updatedCustomer.getPassword().isBlank()) {
            com.restaurant.reservation_system.config.Passwords.validate(updatedCustomer.getPassword());
            customer.setPassword(passwords.encode(updatedCustomer.getPassword()));
        }
        customer.setPhone(updatedCustomer.getPhone());
        customer.setAddress(updatedCustomer.getAddress());

        return customerRepository.save(customer);
    }

    public void deleteCustomer(Long id) {
        if (!customerRepository.existsById(id)) {
            throw new RuntimeException("Customer not found");
        }

        customerRepository.deleteById(id);
    }


}