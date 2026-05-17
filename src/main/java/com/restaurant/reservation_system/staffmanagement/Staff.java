package com.restaurant.reservation_system.staffmanagement;

public class Staff {
     private String name;
     private String role; // e.g., Chef, Waiter, Manager
     private String phone;
     private String email;
     private double salary;
     private Long id;

     // getter setter
     public String getName() {
          return name;
     }

     public void setName(String name) {
          this.name = name;
     }

     public String getRole() {
          return role;
     }

     public void setRole(String role) {
          this.role = role;
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

     public Long getId() {
          return id;
     }

     public void setId(Long id) {
          this.id = id;
     }
}
