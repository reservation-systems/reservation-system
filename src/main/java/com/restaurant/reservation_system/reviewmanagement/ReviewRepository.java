package com.restaurant.reservation_system.reviewmanagement;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Long> {
    List<Review> findByCustomerEmail(String customerEmail);
}

