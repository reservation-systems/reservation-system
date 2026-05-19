package com.restaurant.reservation_system.reservationmanagement;

import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/reservations")
@CrossOrigin("*")
public class ReservationController {

    private final ReservationService reservationService;

    public ReservationController(ReservationService reservationService) {
        this.reservationService = reservationService;
    }

    @GetMapping
    public List<Reservation> getAllReservations() {
        return reservationService.getAllReservations();
    }

    @PostMapping
    public Reservation createReservation(@RequestBody Reservation reservation) {
        return reservationService.createReservation(reservation);
    }

    @PutMapping("/{id}/status")
    public Reservation updateStatus(@PathVariable Long id,
                                    @RequestParam ReservationStatus status) {
        return reservationService.updateStatus(id, status);
    }

    @GetMapping("/customer")
    public List<Reservation> getByEmail(@RequestParam String email) {
        return reservationService.getReservationsByEmail(email);
    }

    @DeleteMapping("/{id}")
    public String deleteReservation(@PathVariable Long id) {
        reservationService.deleteReservation(id);
        return "Reservation deleted successfully";
    }
}