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

    public MenuItem addMenuItem(MenuItem menuItem) {
        return menuItemRepository.save(menuItem);
    }

    public void deleteMenuItem(Long id) {
        menuItemRepository.deleteById(id);
    }

    public MenuItem updateMenuItem(Long id, MenuItem updatedItem) {
        MenuItem item = menuItemRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Menu item not found"));

        item.setName(updatedItem.getName());
        item.setCategory(updatedItem.getCategory());
        item.setPrice(updatedItem.getPrice());
        item.setDescription(updatedItem.getDescription());
        item.setAvailable(updatedItem.isAvailable());

        return menuItemRepository.save(item);
    }
}
