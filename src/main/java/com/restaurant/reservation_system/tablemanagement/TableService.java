package com.restaurant.reservation_system.tablemanagement;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class TableService {

    private final RestaurantTableRepository tableRepository;

    // Constructor Injection to link with the Table Repository
    public TableService(RestaurantTableRepository tableRepository) {
        this.tableRepository = tableRepository;
    }

    // Business Logic: Get every table in the system
    public List<RestaurantTable> getAllTables() {
        return tableRepository.findAll();
    }

    // Business Logic: Filter and return only vacant tables
    public List<RestaurantTable> getAvailableTables() {
        return tableRepository.findByStatus(TableStatus.AVAILABLE);
    }

    // Business Logic: Save a brand new physical table configuration
    public RestaurantTable addTable(RestaurantTable table) {
        return tableRepository.save(table);
    }
    // Business Logic: Find an existing table and update all its details safely
    public RestaurantTable updateTable(Long id, RestaurantTable updatedTable) {
        RestaurantTable table = tableRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Table not found"));

        table.setTableNumber(updatedTable.getTableNumber());
        table.setCapacity(updatedTable.getCapacity());
        table.setStatus(updatedTable.getStatus());

        return tableRepository.save(table);
    }

    // Business Logic: Quickly toggle just the status (e.g., AVAILABLE to OCCUPIED)
    public RestaurantTable updateStatus(Long id, TableStatus status) {
        RestaurantTable table = tableRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Table not found"));

        table.setStatus(status);
        return tableRepository.save(table);
    }

    // Business Logic: Permanently remove a table record by ID
    public void deleteTable(Long id) {
        tableRepository.deleteById(id);
    }
}
