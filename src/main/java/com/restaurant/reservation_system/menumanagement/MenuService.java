package com.restaurant.reservation_system.menumanagement;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class MenuService {
    private final MenuItemRepository menuItemRepository;

    public MenuService(MenuItemRepository menuItemRepository) {
        this.menuItemRepository = menuItemRepository;
    }

    public List<MenuItem> getAllMenuItems() {
        return menuItemRepository.findAll();
    }

    public List<MenuItem> getAvailableMenuItems() {
        return menuItemRepository.findByAvailableTrue();
    }

}
