package com.restaurant.reservation_system.adminmanagement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admins")
public class AdminController {

    @Autowired
    private AdminService adminService;

    // Load JSP Page
    @GetMapping("/dashboard")
    public String adminDashboard(Model model) {

        List<Admin> admins = adminService.getAllAdmins();
        model.addAttribute("admins", admins);

        return "admin-dashboard";
    }
}