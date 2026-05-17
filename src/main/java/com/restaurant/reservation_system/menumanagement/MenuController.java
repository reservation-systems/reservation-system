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

}
