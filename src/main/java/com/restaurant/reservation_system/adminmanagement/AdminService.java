package com.restaurant.reservation_system.adminmanagement;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AdminService {

    private final AdminRepository adminRepository;

    public AdminService(AdminRepository adminRepository) {
        this.adminRepository = adminRepository;
    }


    public List<Admin> getAllAdmins() {
        return adminRepository.findAll();
    }


    public Admin getAdminById(Long id) {
        return adminRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Admin not found"));
    }


    public Admin addAdmin(Admin admin) {

        if (adminRepository.existsByEmail(admin.getEmail())) {
            throw new RuntimeException("Email already exists");
        }

        if (admin.getRole() == null || admin.getRole().isEmpty()) {
            admin.setRole("ADMIN");
        }

        return adminRepository.save(admin);
    }


    public Admin updateAdmin(Long id, Admin updatedAdmin) {

        Admin admin = getAdminById(id);

        admin.setName(updatedAdmin.getName());
        admin.setEmail(updatedAdmin.getEmail());

        if (updatedAdmin.getPassword() != null &&
                !updatedAdmin.getPassword().isEmpty()) {
            admin.setPassword(updatedAdmin.getPassword());
        }

        if (updatedAdmin.getRole() != null &&
                !updatedAdmin.getRole().isEmpty()) {
            admin.setRole(updatedAdmin.getRole());
        }

        return adminRepository.save(admin);
    }


    public void deleteAdmin(Long id) {
        adminRepository.deleteById(id);
    }


    public Admin login(String email, String password) {

        Optional<Admin> optionalAdmin = adminRepository.findByEmail(email);

        if (optionalAdmin.isEmpty()) {
            throw new RuntimeException("Invalid email");
        }

        Admin admin = optionalAdmin.get();

        if (!admin.getPassword().equals(password)) {
            throw new RuntimeException("Invalid password");
        }

        return admin;
    }


    public Admin changePassword(Long id, String newPassword) {

        Admin admin = getAdminById(id);

        admin.setPassword(newPassword);

        return adminRepository.save(admin);
    }
}