package com.restaurant.reservation_system.menumanagement;

import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/preorders")
@CrossOrigin("*")

//feat(preorder): set up PreOrderController base structure and dependency injection
public class PreOrderController {
    private final PreOrderService preOrderService;

    public PreOrderController(PreOrderService preOrderService) {
        this.preOrderService = preOrderService;
    }
}
