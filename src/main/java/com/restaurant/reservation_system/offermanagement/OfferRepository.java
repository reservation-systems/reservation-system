package com.restaurant.reservation_system.offermanagement;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OfferRepository extends JpaRepository<Offer, Long> {

    List<Offer> findByActiveTrue();

    Offer findByOfferCodeIgnoreCase(String offerCode);
}