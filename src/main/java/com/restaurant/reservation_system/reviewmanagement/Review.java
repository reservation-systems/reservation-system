package com.restaurant.reservation_system.reviewmanagement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewService {

    private final ReviewRepository reviewRepository;

    @Autowired
    public ReviewService(ReviewRepository reviewRepository) {
        this.reviewRepository = reviewRepository;
    }

    // Method to handle saving business logic for a review
    public Review saveReview(Review review) {
        return reviewRepository.save(review);
    }
}