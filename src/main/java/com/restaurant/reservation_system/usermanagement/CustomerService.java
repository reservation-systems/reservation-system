package com.restaurant.reservation_system.usermanagement;

import com.restaurant.reservation_system.usermanagement.Customer;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerService {

    private final CustomerRepository customerRepository;

    public CustomerService(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    public List<Customer> getAllCustomers() {
        return customerRepository.findAll();
    }

    public Customer findByEmail(String email) {
        return customerRepository.findByEmail(email).orElse(null);
    }

    public Customer registerCustomer(Customer customer) {
        if (customerRepository.existsByEmail(customer.getEmail())) {
            throw new RuntimeException("Email already exists");
        }

        return customerRepository.save(customer);
    }
    public Customer updateCustomer(Long id, Customer updatedCustomer) {
        Customer customer = customerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        customer.setName(updatedCustomer.getName());
        customer.setEmail(updatedCustomer.getEmail());
        customer.setPassword(updatedCustomer.getPassword());
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