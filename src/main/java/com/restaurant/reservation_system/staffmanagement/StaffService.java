package com.restaurant.reservation_system.staffmanagement;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class StaffService {
    private final StaffRepository staffRepository;

    public StaffService(StaffRepository staffRepository) {
        this.staffRepository = staffRepository;
    }

    public List<Staff> getAllStaff() {
        return staffRepository.findAll();
    }

    public Staff addStaff(Staff staff) {
        return staffRepository.save(staff);
    }

    public Staff updateStaff(Long id, Staff updatedStaff) {
        Staff staff = staffRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Staff not found"));

        staff.setName(updatedStaff.getName());
        staff.setRole(updatedStaff.getRole());
        staff.setPhone(updatedStaff.getPhone());
        staff.setEmail(updatedStaff.getEmail());
        staff.setSalary(updatedStaff.getSalary());

        return staffRepository.save(staff);
    }



















}
