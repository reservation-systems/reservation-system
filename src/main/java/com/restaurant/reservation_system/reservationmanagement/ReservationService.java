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
}
