package com.restaurant.reservation_system.usermanagement;

import org.springframework.web.bind.annotation.*;

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



}