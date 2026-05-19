package com.restaurant.reservation_system.reservationmanagement;

import com.restaurant.reservation_system.tablemanagement.RestaurantTable;
import com.restaurant.reservation_system.tablemanagement.RestaurantTableRepository;
import com.restaurant.reservation_system.tablemanagement.TableStatus;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReservationService {

    private final ReservationRepository reservationRepository;
    private final RestaurantTableRepository tableRepository;

    public ReservationService(
            ReservationRepository reservationRepository,
            RestaurantTableRepository tableRepository
    ) {
        this.reservationRepository = reservationRepository;
        this.tableRepository = tableRepository;
    }

    public List<Reservation> getAllReservations() {
        return reservationRepository.findAll();
    }

    public Reservation createReservation(Reservation reservation) {

        reservation.setStatus(ReservationStatus.PENDING);

        if (reservation.getTableNumber() != null) {

            RestaurantTable table = tableRepository
                    .findByTableNumber(reservation.getTableNumber())
                    .orElseThrow(() ->
                            new RuntimeException("Table not found"));

            if (table.getStatus() != TableStatus.AVAILABLE) {
                throw new RuntimeException("Table already reserved");
            }

            table.setStatus(TableStatus.RESERVED);
            tableRepository.save(table);
        }

        return reservationRepository.save(reservation);
    }

    public Reservation updateStatus(Long id, ReservationStatus status) {

        Reservation reservation = reservationRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException("Reservation not found"));

        reservation.setStatus(status);

        if (status == ReservationStatus.CANCELLED
                && reservation.getTableNumber() != null) {

            tableRepository
                    .findByTableNumber(reservation.getTableNumber())
                    .ifPresent(table -> {

                        table.setStatus(TableStatus.AVAILABLE);
                        tableRepository.save(table);
                    });
        }

        return reservationRepository.save(reservation);
    }

    public List<Reservation> getReservationsByEmail(String email) {
        return reservationRepository.findByCustomerEmail(email);
    }

    public void deleteReservation(Long id) {

        Reservation reservation = reservationRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException("Reservation not found"));

        if (reservation.getTableNumber() != null) {

            tableRepository
                    .findByTableNumber(reservation.getTableNumber())
                    .ifPresent(table -> {

                        table.setStatus(TableStatus.AVAILABLE);
                        tableRepository.save(table);
                    });
        }

        reservationRepository.delete(reservation);
    }
}