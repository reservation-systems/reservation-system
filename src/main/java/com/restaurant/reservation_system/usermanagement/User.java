package com.restaurant.reservation_system.usermanagement;

import jakarta.persistence.*;

@MappedSuperclass
public class User {

    private String name;
    private String email;
    private String password;
    private String phone;





}