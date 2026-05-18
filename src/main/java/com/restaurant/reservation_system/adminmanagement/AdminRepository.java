package com.restaurant.reservation_system.adminmanagement;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.List;

public interface AdminRepository extends JpaRepository<Admin, Long> {


    Optional<Admin> findByEmail(String email);


    boolean existsByEmail(String email);


    List<Admin> findByRole(String role);
}