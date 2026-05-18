package com.restaurant.reservation_system.config;

import com.restaurant.reservation_system.adminmanagement.Admin;
import com.restaurant.reservation_system.adminmanagement.AdminRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataLoader {

    @Bean
    CommandLineRunner loadAdmin(AdminRepository adminRepository) {

        return args -> {

            if (adminRepository.findByEmail("admin@gmail.com").isEmpty()) {

                Admin admin = new Admin();

                admin.setName("Administrator");
                admin.setEmail("admin@gmail.com");
                admin.setPassword("admin123");

                adminRepository.save(admin);

                System.out.println("Default Admin Created");
            }
        };
    }
}