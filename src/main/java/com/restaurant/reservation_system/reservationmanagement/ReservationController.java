package com.restaurant.reservation_system.reservationmanagement;

import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/reservations")
@CrossOrigin("*")
public class ReservationController {

    private final ReservationService reservationService;

    // Constructor Injection for Dependency Injection
    public ReservationController(ReservationService reservationService) {
        this.reservationService = reservationService;
    }

    // Get all reservations
    @GetMapping
    public List<Reservation> getAllReservations() {
        return reservationService.getAllReservations();
    }

    // Get reservations by customer email
    @GetMapping("/customer")
    public List<Reservation> getByEmail(@RequestParam String email) {
        return reservationService.getReservationsByEmail(email);
    }
}