package com.restaurant.reservation_system.usermanagement;

 tablemanagement-and-researvationmanagement
import org.springframework.web.bind.annotation.*;


import com.restaurant.reservation_system.adminmanagement.Admin;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

 main
@RestController
@RequestMapping("/api/auth")
@CrossOrigin("*")
public class AuthController {

    private final AuthService authService;
    private final CustomerService customerService;

    public AuthController(AuthService authService,
                          CustomerService customerService) {
        this.authService = authService;
        this.customerService = customerService;
    }

 tablemanagement-and-researvationmanagement


    @PostMapping("/register")
    public Customer register(@RequestBody Customer customer) {
        return customerService.registerCustomer(customer);
    }

    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody LoginRequest loginRequest) {

        Object user = authService.login(
                loginRequest.getEmail(),
                loginRequest.getPassword()
        );

        Map<String, Object> response = new HashMap<>();

        if (user instanceof Admin) {

            Admin admin = (Admin) user;

            response.put("status", "success");
            response.put("role", "ADMIN");
            response.put("redirect", "admin-dashboard.jsp");
            response.put("admin", admin);

        } else if (user instanceof Customer) {

            Customer customer = (Customer) user;

            response.put("status", "success");
            response.put("role", "CUSTOMER");
            response.put("redirect", "home.jsp");
            response.put("customer", customer);

        } else {

            response.put("status", "failed");
            response.put("message", "Invalid email or password");

        }

        return response;
    }
 main
}