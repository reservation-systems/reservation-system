package com.restaurant.reservation_system.tablemanagement;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface RestaurantTableRepository extends JpaRepository<RestaurantTable, Long> {
    List<RestaurantTable> findByStatus(TableStatus status);
    List<RestaurantTable> findByCapacityGreaterThanEqualAndStatus(int capacity, TableStatus status);
}
