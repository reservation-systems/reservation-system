package com.restaurant.reservation_system.offermanagement;

import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/offers")
@CrossOrigin("*")
public class OfferController {

    private final OfferService offerService;
    private final OfferRepository offerRepository;

    public OfferController(OfferService offerService, OfferRepository offerRepository) {
        this.offerService = offerService;
        this.offerRepository = offerRepository;
    }

    @GetMapping
    public List<Offer> getAllOffers() {
        return offerService.getAllOffers();
    }

    @GetMapping("/active")
    public List<Offer> getActiveOffers() {
        return offerService.getActiveOffers();
    }

    @PostMapping
    public Offer addOffer(@RequestBody Offer offer) {
        return offerService.addOffer(offer);
    }

    @PutMapping("/{id}")
    public Offer updateOffer(@PathVariable Long id, @RequestBody Offer offer) {
        return offerService.updateOffer(id, offer);
    }

    @DeleteMapping("/{id}")
    public String deleteOffer(@PathVariable Long id) {
        offerService.deleteOffer(id);
        return "Offer deleted successfully";
    }

    @PostMapping("/validate")
    public Map<String, Object> validateOffer(@RequestBody Map<String, String> body) {

        String code = body.get("code");

        Map<String, Object> response = new HashMap<>();

        if (code == null || code.trim().isEmpty()) {
            response.put("valid", false);
            return response;
        }

        Offer offer = offerRepository.findByOfferCodeIgnoreCase(code.trim());

        if (offer != null && offer.isActive() && isDateValid(offer)) {
            response.put("valid", true);
            response.put("discountPercent", offer.getDiscountPercentage());
            response.put("description", offer.getTitle());
        } else {
            response.put("valid", false);
        }

        return response;
    }

    private boolean isDateValid(Offer offer) {

        LocalDate today = LocalDate.now();

        if (offer.getStartDate() != null && today.isBefore(offer.getStartDate())) {
            return false;
        }

        if (offer.getEndDate() != null && today.isAfter(offer.getEndDate())) {
            return false;
        }

        return true;
    }
}