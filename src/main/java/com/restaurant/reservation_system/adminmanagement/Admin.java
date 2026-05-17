package com.restaurant.reservation_system.adminmanagement;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Admin {

    @Id
    private Long id;

    private String name;
}