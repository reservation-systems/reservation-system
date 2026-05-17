package com.restaurant.reservation_system.staffmanagement;

import jakarta.persistence.*;

@Entity
public class Staff {

     @Id
     @GeneratedValue(strategy = GenerationType.IDENTITY)
     private Long id;
     private String name;
     private String role; // e.g., Chef, Waiter, Manager
     private String phone;
     private String email;
     private double salary;

     //Getter & Setter
     public Long getId() {
          return id;
     }

     public void setId(Long id) {
          this.id = id;
     }

     public String getRole() {
          return role;
     }

     public void setRole(String role) {
          this.role = role;
     }

     public String getName() {
          return name;
     }

     public void setName(String name) {
          this.name = name;
     }

     public String getPhone() {
          return phone;
     }

     public void setPhone(String phone) {
          this.phone = phone;
     }

     public String getEmail() {
          return email;
     }

     public void setEmail(String email) {
          this.email = email;
     }

     public double getSalary() {
          return salary;
     }

     public void setSalary(double salary) {
          this.salary = salary;
     }
}