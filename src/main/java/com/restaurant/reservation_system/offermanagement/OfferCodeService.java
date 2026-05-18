package com.restaurant.reservation_system.offermanagement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class OfferCodeService {

    @Autowired
    private OfferCodeRepository offerCodeRepository;

    public List<OfferCode> getAllOfferCodes() {
        return offerCodeRepository.findAll();
    }

    public List<OfferCode> getActiveOfferCodes() {
        return offerCodeRepository.findByActiveTrue();
    }

    public OfferCode createOfferCode(OfferCode offerCode) {
        offerCode.setCode(offerCode.getCode().toUpperCase());
        return offerCodeRepository.save(offerCode);
    }

    public Optional<OfferCode> validateCode(String code) {
        return offerCodeRepository.findByCodeAndActiveTrue(code.toUpperCase());
    }

    public OfferCode toggleActive(Long id) {
        OfferCode offer = offerCodeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Offer code not found"));
        offer.setActive(!offer.isActive());
        return offerCodeRepository.save(offer);
    }

    public void deleteOfferCode(Long id) {
        offerCodeRepository.deleteById(id);
    }
}