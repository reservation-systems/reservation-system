package com.restaurant.reservation_system.tablemanagement;

import org.springframework.stereotype.Service;
import java.util.List;

@org.springframework.transaction.annotation.Transactional
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
        table.setId(null);
        if(table.getTableNumber()<1 || table.getCapacity()<1) throw new IllegalArgumentException("Table number and capacity must be positive");
        if(table.getStatus()==TableStatus.RESERVED) throw new IllegalArgumentException("Reservations are managed by date and time; use UNAVAILABLE to block a table");
        return tableRepository.save(table);
    }

    public RestaurantTable updateTable(Long id, RestaurantTable updatedTable) {
        RestaurantTable table = tableRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Table not found"));

        if(table.getTableNumber()!=updatedTable.getTableNumber()) throw new IllegalArgumentException("Table numbers cannot be changed after creation");
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