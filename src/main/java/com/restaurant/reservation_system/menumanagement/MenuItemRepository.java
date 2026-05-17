package com.restaurant.reservation_system.menumanagement;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

//Repository interface for MenuItem entity
public interface MenuItemRepository extends JpaRepository<MenuItem, Long> {

    //finds only menu items where "available" fields true
    //Spring automatically creates the SQL query
    //returns a list because multiple available menu items can exist
    List<MenuItem> findByAvailableTrue();
}
