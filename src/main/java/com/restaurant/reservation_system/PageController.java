package com.restaurant.reservation_system;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping({"/", "/index"})
    public String index() {
        return "index";
    }

    @GetMapping("/home")
    public String home() {
        return "home";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @GetMapping("/admin-login")
    public String adminLogin() {
        return "admin-login";
    }

    @GetMapping("/admin-dashboard")
    public String adminDashboard() {
        return "admin-dashboard";
    }

    @GetMapping("/customer-dashboard")
    public String customerDashboard() {
        return "customer-dashboard";
    }

    @GetMapping("/customers")
    public String customers() {
        return "customers";
    }

    @GetMapping("/menu")
    public String menu() {
        return "menu";
    }

    @GetMapping("/menu-management")
    public String menuManagement() {
        return "menu-management";
    }

    @GetMapping("/offers")
    public String offers() {
        return "offers";
    }

    @GetMapping("/offers-management")
    public String offersManagement() {
        return "offers-management";
    }

    @GetMapping("/payment")
    public String payment() {
        return "payment";
    }

    @GetMapping("/payments")
    public String payments() {
        return "payments";
    }

    @GetMapping("/profile")
    public String profile() {
        return "profile";
    }

    @GetMapping("/reservation")
    public String reservation() {
        return "reservation";
    }

    @GetMapping("/my-reservations")
    public String myReservations() {
        return "my-reservations";
    }

    @GetMapping("/reservations-admin")
    public String reservationsAdmin() {
        return "reservations-admin";
    }

    @GetMapping("/reviews")
    public String reviews() {
        return "reviews";
    }

    @GetMapping("/staff")
    public String staff() {
        return "staff";
    }

    @GetMapping("/tables")
    public String tables() {
        return "tables";
    }
}