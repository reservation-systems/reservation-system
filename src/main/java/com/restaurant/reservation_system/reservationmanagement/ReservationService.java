package com.restaurant.reservation_system.reservationmanagement;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ReservationService {

    private final ReservationRepository reservationRepository;

    // Constructor Injection to link with the Database Repository
    public ReservationService(ReservationRepository reservationRepository) {
        this.reservationRepository = reservationRepository;
    }

    // Business Logic: Get all records
    public List<Reservation> getAllReservations() {
        return reservationRepository.findAll();
    }

    // Business Logic: Find records matching a specific email
    public List<Reservation> getReservationsByEmail(String email) {
        return reservationRepository.findByCustomerEmail(email);
    }
    // Business Logic: Save a new reservation and force its initial status to PENDING
    public Reservation createReservation(Reservation reservation) {
        reservation.setStatus(ReservationStatus.PENDING);
        return reservationRepository.save(reservation);
    }

    // Business Logic: Find an existing reservation, change its status, or throw an error if missing
    public Reservation updateStatus(Long id, ReservationStatus status) {
        Reservation reservation = reservationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Reservation not found"));

        reservation.setStatus(status);
        return reservationRepository.save(reservation);
    }

    // Business Logic: Delete a record by its unique ID
    public void deleteReservation(Long id) {
        reservationRepository.deleteById(id);
    }

}
