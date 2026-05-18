package com.restaurant.reservation_system.offermanagement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/offer-codes")
@CrossOrigin("*")
public class OfferCodeController {

    @Autowired
    private OfferCodeService offerCodeService;

    @GetMapping
    public List<OfferCode> getAllOfferCodes() {
        return offerCodeService.getAllOfferCodes();
    }

    @GetMapping("/active")
    public List<OfferCode> getActiveOfferCodes() {
        return offerCodeService.getActiveOfferCodes();
    }

    @PostMapping("/validate")
    public Map<String, Object> validateCode(@RequestBody Map<String, String> body) {
        String code = body.get("code");
        Optional<OfferCode> offer = offerCodeService.validateCode(code);
        if (offer.isPresent()) {
            return Map.of(
                    "valid", true,
                    "discountPercent", offer.get().getDiscountPercent(),
                    "description", offer.get().getDescription()
            );
        }
        return Map.of("valid", false, "message", "Invalid or expired offer code");
    }

    @PostMapping
    public OfferCode createOfferCode(@RequestBody OfferCode offerCode) {
        return offerCodeService.createOfferCode(offerCode);
    }

    @PutMapping("/{id}/toggle")
    public OfferCode toggleActive(@PathVariable Long id) {
        return offerCodeService.toggleActive(id);
    }

    @DeleteMapping("/{id}")
    public String deleteOfferCode(@PathVariable Long id) {
        offerCodeService.deleteOfferCode(id);
        return "Offer code deleted";
    }
}