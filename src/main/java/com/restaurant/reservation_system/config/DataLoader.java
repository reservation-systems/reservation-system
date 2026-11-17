package com.restaurant.reservation_system.config;
import com.restaurant.reservation_system.adminmanagement.*;
import com.restaurant.reservation_system.usermanagement.*;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
@Configuration
public class DataLoader {
    @Bean CommandLineRunner initialize(AdminRepository admins, CustomerRepository customers, PasswordEncoder passwords,
        com.restaurant.reservation_system.tablemanagement.RestaurantTableRepository tables,
        com.restaurant.reservation_system.reservationmanagement.ReservationRepository reservations,
        @Value("${app.bootstrap-admin.email:}") String email, @Value("${app.bootstrap-admin.password:}") String password) {
        return args -> {
            for(var table:tables.findByStatus(com.restaurant.reservation_system.tablemanagement.TableStatus.RESERVED)) {
                if(reservations.findAll().stream().anyMatch(r -> java.util.Objects.equals(r.getTableNumber(),table.getTableNumber()))) {
                    table.setStatus(com.restaurant.reservation_system.tablemanagement.TableStatus.AVAILABLE); tables.save(table);
                }
            }
            // Upgrade existing plaintext records without exposing passwords in JSON or logs.
            for(var customer:customers.findAll()) {
                if(customer.getPassword()!=null && !customer.getPassword().startsWith("$2")) { customer.setPassword(passwords.encode(customer.getPassword())); customers.save(customer); }
            }
            for(var admin:admins.findAll()) {
                if("admin@gmail.com".equals(admin.getEmail()) && ("admin123".equals(admin.getPassword()) || (admin.getPassword()!=null && admin.getPassword().startsWith("$2") && passwords.matches("admin123",admin.getPassword())))) {
                    admin.setPassword(passwords.encode(java.util.UUID.randomUUID().toString()));
                    // Explicit bootstrap credentials can recover the old seeded account.
                    if(admin.getEmail().equalsIgnoreCase(email) && !password.isBlank()) { Passwords.validate(password); admin.setPassword(passwords.encode(password)); }
                    admins.save(admin);
                } else if(admin.getPassword()!=null && !admin.getPassword().startsWith("$2")) { admin.setPassword(passwords.encode(admin.getPassword())); admins.save(admin); }
            }
            if(!email.isBlank() && !password.isBlank() && !admins.existsByEmail(Passwords.email(email))) {
                Passwords.validate(password); admins.save(new Admin("Administrator",Passwords.email(email),passwords.encode(password),"ADMIN"));
            }
        };
    }
}
