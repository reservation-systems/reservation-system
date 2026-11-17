package com.restaurant.reservation_system.tablemanagement;

import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/tables")
public class TableController {

    private final TableService tableService;
    @org.springframework.beans.factory.annotation.Autowired private com.restaurant.reservation_system.reservationmanagement.ReservationService reservations;

    public TableController(TableService tableService) {
        this.tableService = tableService;
    }

    @GetMapping
    public List<RestaurantTable> getAllTables() {
        return tableService.getAllTables();
    }

    @GetMapping("/available")
    public List<RestaurantTable> getAvailableTables(@RequestParam(required=false) java.time.LocalDate date, @RequestParam(required=false) java.time.LocalTime time, @RequestParam(required=false) Long excludeId) {
        return reservations.available(date,time,excludeId);
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