package com.restaurant.reservation_system.menumanagement;

import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/preorders")
@CrossOrigin("*")

public class PreOrderController {
    private final PreOrderService preOrderService;

    public PreOrderController(PreOrderService preOrderService) {
        this.preOrderService = preOrderService;
    }

    @GetMapping
    public List<PreOrder> getAllPreOrders() {
        return preOrderService.getAllPreOrders();
    }

    @PostMapping("/{menuItemId}")
    public PreOrder createPreOrder(@PathVariable Long menuItemId, @RequestBody PreOrder preOrder) {
        return preOrderService.createPreOrder(menuItemId, preOrder);
    }

    @PutMapping("/{id}/status")
    public PreOrder updateStatus(@PathVariable Long id, @RequestParam String status) {
        return preOrderService.updateStatus(id, status);
    }

    @DeleteMapping("/{id}")
    public String deletePreOrder(@PathVariable Long id) {
        preOrderService.deletePreOrder(id);
        return "Pre-order deleted successfully";
    }


}
