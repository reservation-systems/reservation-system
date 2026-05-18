package com.restaurant.reservation_system.reviewmanagement;

import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/reviews")
@CrossOrigin("*")
public class ReviewController {

    private final ReviewService reviewService;

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @GetMapping
    public List<Review> getAllReviews() {
        return reviewService.getAllReviews();
    }

    @GetMapping("/customer")
    public List<Review> getReviewsByCustomerEmail(@RequestParam String email) {
        return reviewService.getReviewsByCustomerEmail(email);
    }
}