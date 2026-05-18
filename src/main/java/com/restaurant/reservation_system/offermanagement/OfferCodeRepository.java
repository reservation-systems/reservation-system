package com.restaurant.reservation_system.offermanagement;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface OfferCodeRepository extends JpaRepository<OfferCode, Long> {
    Optional<OfferCode> findByCodeAndActiveTrue(String code);
    List<OfferCode> findByActiveTrue();
}