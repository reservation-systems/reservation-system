package com.restaurant.reservation_system.adminmanagement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admins")
public class AdminController {

    @Autowired
    private AdminService adminService;


    @GetMapping("/dashboard")
    public String adminDashboard(Model model) {

        List<Admin> admins = adminService.getAllAdmins();
        model.addAttribute("admins", admins);

        return "admin-dashboard";
    }


    @ResponseBody
    @GetMapping("/all")
    public List<Admin> getAllAdmins() {
        return adminService.getAllAdmins();
    }


    @ResponseBody
    @PostMapping
    public Admin createAdmin(@RequestBody Admin admin) {
        return adminService.saveAdmin(admin);
    }


    @ResponseBody
    @DeleteMapping("/{id}")
    public void deleteAdmin(@PathVariable Long id) {
        adminService.deleteAdmin(id);
    }
}