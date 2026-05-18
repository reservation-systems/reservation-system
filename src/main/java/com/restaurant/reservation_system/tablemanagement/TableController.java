package com.restaurant.reservation_system.tablemanagement;

import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/tables")
@CrossOrigin("*")
public class TableController {

    private final TableService tableService;

    public TableController(TableService tableService) {
        this.tableService = tableService;
    }

    @GetMapping
    public List<RestaurantTable> getAllTables() {
        return tableService.getAllTables();
    }

    @GetMapping("/available")
    public List<RestaurantTable> getAvailableTables() {
        return tableService.getAvailableTables();
    }

    @PostMapping
    public RestaurantTable addTable(@RequestBody RestaurantTable table) {
        return tableService.addTable(table);
    }

    @PutMapping("/{id}")
    public RestaurantTable updateTable(@PathVariable Long id,
                                       @RequestBody RestaurantTable table) {
        return tableService.updateTable(id, table);
    }

    @PutMapping("/{id}/status")
    public RestaurantTable updateStatus(@PathVariable Long id,
                                        @RequestParam TableStatus status) {
        return tableService.updateStatus(id, status);
    }

    @DeleteMapping("/{id}")
    public String deleteTable(@PathVariable Long id) {
        tableService.deleteTable(id);
        return "Table deleted successfully";
    }
}