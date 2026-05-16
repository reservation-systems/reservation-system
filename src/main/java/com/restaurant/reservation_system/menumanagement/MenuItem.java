package com.restaurant.reservation_system.menumanagement;

//library use to connect java classes with database tables
import jakarta.persistence.*;

//entire class should behave as a database
@Entity

public class MenuItem {
    @Id //marks primary key
    //automatically generate IDs and database auto increments values
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String category;
    private double price;
    private String description;
    private boolean available = true;
}
