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

    public PreOrder createPreOrder(Long menuItemId, PreOrder preOrder) {
        MenuItem menuItem = menuItemRepository.findById(menuItemId)
                .orElseThrow(() -> new RuntimeException("Menu item not found"));

        if (!menuItem.isAvailable()) {
            throw new RuntimeException("Menu item is not available");
        }

        preOrder.setMenuItem(menuItem);
        preOrder.setItemName(menuItem.getName());
        preOrder.setTotalPrice(menuItem.getPrice() * preOrder.getQuantity());
        preOrder.setStatus("PENDING");

        return preOrderRepository.save(preOrder);
    }


    public PreOrder updateStatus(Long id, String status) {
        PreOrder preOrder = preOrderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Pre-order not found"));

        preOrder.setStatus(status);
        return preOrderRepository.save(preOrder);
    }

    public void deletePreOrder(Long id) {
        preOrderRepository.deleteById(id);
    }


}
