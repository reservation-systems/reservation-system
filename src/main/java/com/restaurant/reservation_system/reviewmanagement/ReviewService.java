package com.restaurant.reservation_system.reviewmanagement;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ReviewService {

    private final ReviewRepository reviewRepository;

    public ReviewService(ReviewRepository reviewRepository) {
        this.reviewRepository = reviewRepository;
    }

    public List<Review> getAllReviews() {
        return reviewRepository.findAll();
    }

    public Review addReview(Review review) {
        if (review.getRating() < 1 || review.getRating() > 5) {
            throw new RuntimeException("Rating must be between 1 and 5");
        }

        return reviewRepository.save(review);
    }

    public List<Review> getReviewsByCustomerEmail(String email) {
        return reviewRepository.findByCustomerEmail(email);
    }

    public void deleteReview(Long id) {
        reviewRepository.deleteById(id);
    }
}