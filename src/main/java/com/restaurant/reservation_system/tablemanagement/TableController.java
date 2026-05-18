package com.restaurant.reservation_system.tablemanagement;

import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/tables")
@CrossOrigin("*")
public class TableController {

    private final TableService tableService;

    // Constructor Injection to link with the Table Service layer
    public TableController(TableService tableService) {
        this.tableService = tableService;
    }

    // API Endpoint: Get a list of all tables
    @GetMapping
    public List<RestaurantTable> getAllTables() {
        return tableService.getAllTables();
    }

    // API Endpoint: Get a list of only vacant tables
    @GetMapping("/available")
    public List<RestaurantTable> getAvailableTables() {
        return tableService.getAvailableTables();
    }
}
