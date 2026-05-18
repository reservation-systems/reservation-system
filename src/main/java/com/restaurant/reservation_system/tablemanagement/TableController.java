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

    // API Endpoint: Add a completely new table arrangement
    @PostMapping
    public RestaurantTable addTable(@RequestBody RestaurantTable table) {
        return tableService.addTable(table);
    }

    // API Endpoint: Fully update structural properties of a table by ID
    @PutMapping("/{id}")
    public RestaurantTable updateTable(@PathVariable Long id,
                                       @RequestBody RestaurantTable table) {
        return tableService.updateTable(id, table);
    }

    // API Endpoint: Minor update to switch a single table's status
    @PutMapping("/{id}/status")
    public RestaurantTable updateStatus(@PathVariable Long id,
                                        @RequestParam TableStatus status) {
        return tableService.updateStatus(id, status);
    }

    // API Endpoint: Delete an out-of-service table
    @DeleteMapping("/{id}")
    public String deleteTable(@PathVariable Long id) {
        tableService.deleteTable(id);
        return "Table deleted successfully";

    }
}

