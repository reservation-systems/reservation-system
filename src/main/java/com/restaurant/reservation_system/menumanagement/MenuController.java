package com.restaurant.reservation_system.menumanagement;

//importing all notations from Spring's web package
import org.springframework.web.bind.annotation.*;
import java.util.List;

/*Marks the class as a web controller (handle web request automatically
converts the returned data into JSON)*/
@RestController
@RequestMapping("/api/menu")
@CrossOrigin("*")

public class MenuController {
    private final MenuService menuService;

    public MenuController(MenuService menuService) {
        this.menuService = menuService;
    }

    @GetMapping
    public List<MenuItem> getAllMenuItems() {
        return menuService.getAllMenuItems();
    }

    @GetMapping("/available")
    public List<MenuItem> getAvailableMenuItems() {
        return menuService.getAvailableMenuItems();
    }

    @PostMapping
    public MenuItem addMenuItem(@RequestBody MenuItem menuItem) {
        return menuService.addMenuItem(menuItem);
    }

    @PutMapping("/{id}")
    public MenuItem updateMenuItem(@PathVariable Long id, @RequestBody MenuItem menuItem) {
        return menuService.updateMenuItem(id, menuItem);
    }

    @DeleteMapping("/{id}")
    public String deleteMenuItem(@PathVariable Long id) {
        menuService.deleteMenuItem(id);
        return "Menu item deleted successfully";
    }
}
