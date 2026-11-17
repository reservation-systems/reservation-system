package com.restaurant.reservation_system.config;
import java.util.Map;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.*;
@RestControllerAdvice
public class ApiErrors {
    @ExceptionHandler(IllegalArgumentException.class)
    ResponseEntity<?> invalid(IllegalArgumentException ex) { return ResponseEntity.badRequest().body(Map.of("message", ex.getMessage())); }
    @ExceptionHandler(org.springframework.dao.DataIntegrityViolationException.class)
    ResponseEntity<?> conflict() { return ResponseEntity.status(409).body(Map.of("message", "This value is already in use or referenced by another record")); }
}
