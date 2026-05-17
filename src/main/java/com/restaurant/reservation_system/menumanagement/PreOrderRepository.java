package com.restaurant.reservation_system.menumanagement;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

//Repository interface for PreOrder entity
public interface PreOrderRepository extends JpaRepository<PreOrder,Long>{

    // Finds all preorders with a specific status
    // Spring automatically creates the query
    // Returns multiple preorder objects as a List
    List<PreOrder> findByStatus(String status);
}
