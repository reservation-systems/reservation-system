package com.restaurant.reservation_system.menumanagement;
import org.springframework.stereotype.Service;
import java.util.List;

@Service

public class PreOrderService {
    private final PreOrderRepository preOrderRepository;
    private final MenuItemRepository menuItemRepository;

    public PreOrderService(PreOrderRepository preOrderRepository, MenuItemRepository menuItemRepository) {
        this.preOrderRepository = preOrderRepository;
        this.menuItemRepository = menuItemRepository;
    }

    public List<PreOrder> getAllPreOrders() {
        return preOrderRepository.findAll();
    }
}
