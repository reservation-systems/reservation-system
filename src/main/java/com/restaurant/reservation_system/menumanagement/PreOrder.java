package com.restaurant.reservation_system.menumanagement;

import jakarta.persistence.*;
//import for handling date and time of order
import java.time.LocalDateTime;

@Entity
public class PreOrder {
    @Id //marks primary key
    //automatically generate IDs and database auto increments values
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String customerName;
    private String customerPhone;
    private String itemName;
    private int quantity;
    private double totalPrice;
    private LocalDateTime orderTime;
    private String status = "PENDING";
}
