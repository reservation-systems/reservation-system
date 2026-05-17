package com.restaurant.reservation_system.reservationmanagement;



import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;


@Entity
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String customerName;
    private String customerEmail;
    private String customerPhone;

    private LocalDate reservationDate;
    private LocalTime reservationTime;

    private int numberOfGuests;

    @Enumerated(EnumType.STRING)
    private ReservationStatus status = ReservationStatus.PENDING;


}
