package com.restaurant.reservation_system.usermanagement;
import com.restaurant.reservation_system.adminmanagement.*;
import org.springframework.stereotype.Service;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.http.HttpStatus;
@Service
public class AuthService {
    private final CustomerRepository customers;
    private final AdminRepository admins;
    private final PasswordEncoder passwords;
    public AuthService(CustomerRepository customers, AdminRepository admins, PasswordEncoder passwords) {
        this.customers=customers; this.admins=admins; this.passwords=passwords;
    }
    public Object login(String email, String password) {
        if(email == null || password == null) throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid email or password");
        var admin = admins.findByEmail(email.trim().toLowerCase(java.util.Locale.ROOT)).orElse(null);
        if(admin != null && passwords.matches(password,admin.getPassword())) return admin;
        var customer = customers.findByEmail(email.trim().toLowerCase(java.util.Locale.ROOT)).orElse(null);
        if(customer != null && passwords.matches(password,customer.getPassword())) return customer;
        throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid email or password");
    }
}
