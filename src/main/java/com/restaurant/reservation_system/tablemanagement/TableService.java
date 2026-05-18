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
}
