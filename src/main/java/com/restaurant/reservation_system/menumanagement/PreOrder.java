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
    private String status = "PENDING"; //order status set as "Pending" until processed

    @ManyToOne //many PreOrders can belong to one MenuItem
    @JoinColumn(name = "menu_item_id") //define foreign key column in PreOrder table
    private MenuItem menuItem;

    //automatically runs before saving the entity to database
    @PrePersist
    public void onCreate() {
        orderTime = LocalDateTime.now();
    }

    //getters and setters


    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public String getCustomerName() {
        return customerName;
    }
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }
    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getItemName() {
        return itemName;
    }
    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }
    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public LocalDateTime getOrderTime() {
        return orderTime;
    }
    public void setOrderTime(LocalDateTime orderTime) {
        this.orderTime = orderTime;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public MenuItem getMenuItem() {
        return menuItem;
    }
    public void setMenuItem(MenuItem menuItem) {
        this.menuItem = menuItem;
    }
}
