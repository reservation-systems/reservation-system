package com.restaurant.reservation_system.reviewmanagement;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String customerName;
    private String customerEmail;

    private int rating;
    private String comment;

    private LocalDateTime reviewDate;