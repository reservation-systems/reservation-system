package com.restaurant.reservation_system.tablemanagement;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class TableService {

    private final RestaurantTableRepository tableRepository;

    public TableService(RestaurantTableRepository tableRepository) {
        this.tableRepository = tableRepository;
    }

    public List<RestaurantTable> getAllTables() {
        return tableRepository.findAll();
    }

    public List<RestaurantTable> getAvailableTables() {
        return tableRepository.findByStatus(TableStatus.AVAILABLE);
    }

    public RestaurantTable addTable(RestaurantTable table) {
        return tableRepository.save(table);
    }

    public RestaurantTable updateTable(Long id, RestaurantTable updatedTable) {
        RestaurantTable table = tableRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Table not found"));

        table.setTableNumber(updatedTable.getTableNumber());
        table.setCapacity(updatedTable.getCapacity());
        table.setStatus(updatedTable.getStatus());

        return tableRepository.save(table);
    }

    public RestaurantTable updateStatus(Long id, TableStatus status) {
        RestaurantTable table = tableRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Table not found"));

        table.setStatus(status);
        return tableRepository.save(table);
    }

    public void deleteTable(Long id) {
        tableRepository.deleteById(id);
    }
}