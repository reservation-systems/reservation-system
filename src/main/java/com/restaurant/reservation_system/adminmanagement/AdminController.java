package com.restaurant.reservation_system.adminmanagement;

import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/admin")
@CrossOrigin("*")
public class AdminController {

    private final AdminRepository adminRepository;

    public AdminController(AdminRepository adminRepository) {
        this.adminRepository = adminRepository;
    }



    @GetMapping("/all")
    public List<Admin> getAllAdmins() {
        return adminRepository.findAll();
    }



    @GetMapping("/{id}")
    public Admin getAdmin(@PathVariable Long id) {

        return adminRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException("Admin not found"));
    }


    @PostMapping("/add")
    public Map<String, Object> addAdmin(@RequestBody Admin admin) {

        Map<String, Object> response = new HashMap<>();


        if (adminRepository.existsByEmail(admin.getEmail())) {

            response.put("status", "failed");
            response.put("message", "Email already exists");

            return response;
        }

        Admin savedAdmin = adminRepository.save(admin);

        response.put("status", "success");
        response.put("message", "Admin added successfully");
        response.put("admin", savedAdmin);

        return response;
    }



    @PutMapping("/update/{id}")
    public Map<String, Object> updateAdmin(
            @PathVariable Long id,
            @RequestBody Admin updatedAdmin) {

        Admin admin = adminRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException("Admin not found"));

        admin.setName(updatedAdmin.getName());

        admin.setEmail(updatedAdmin.getEmail());


        if (updatedAdmin.getPassword() != null
                && !updatedAdmin.getPassword().isEmpty()) {

            admin.setPassword(updatedAdmin.getPassword());
        }


        if (updatedAdmin.getRole() != null
                && !updatedAdmin.getRole().isEmpty()) {

            admin.setRole(updatedAdmin.getRole());
        }

        Admin savedAdmin = adminRepository.save(admin);

        Map<String, Object> response = new HashMap<>();

        response.put("status", "success");
        response.put("message", "Admin updated successfully");
        response.put("admin", savedAdmin);

        return response;
    }



    @DeleteMapping("/delete/{id}")
    public Map<String, Object> deleteAdmin(
            @PathVariable Long id) {

        adminRepository.deleteById(id);

        Map<String, Object> response = new HashMap<>();

        response.put("status", "success");
        response.put("message", "Admin deleted successfully");

        return response;
    }




    @PostMapping("/login")
    public Map<String, Object> login(
            @RequestBody Admin loginAdmin) {

        Map<String, Object> response = new HashMap<>();

        Optional<Admin> optionalAdmin =
                adminRepository.findByEmail(loginAdmin.getEmail());


        if (optionalAdmin.isEmpty()) {

            response.put("status", "failed");
            response.put("message", "Invalid email");

            return response;
        }

        Admin admin = optionalAdmin.get();


        if (!admin.getPassword().equals(loginAdmin.getPassword())) {

            response.put("status", "failed");
            response.put("message", "Invalid password");

            return response;
        }

        response.put("status", "success");
        response.put("message", "Login successful");
        response.put("admin", admin);

        return response;
    }
}