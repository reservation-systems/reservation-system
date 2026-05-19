package com.restaurant.reservation_system.tablemanagement;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface RestaurantTableRepository extends JpaRepository<RestaurantTable, Long> {

    List<RestaurantTable> findByStatus(TableStatus status);

    Optional<RestaurantTable> findByTableNumber(Integer tableNumber);

}