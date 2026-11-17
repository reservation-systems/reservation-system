package com.restaurant.reservation_system.reservationmanagement;
import com.restaurant.reservation_system.tablemanagement.*;
import com.restaurant.reservation_system.config.Access;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;
import java.time.*;
import java.util.*;

@Service
@Transactional(isolation=org.springframework.transaction.annotation.Isolation.READ_COMMITTED)
public class ReservationService {
    private final ReservationRepository reservations;
    private final RestaurantTableRepository tables;
    private final Access access;
    private final int duration;
    public ReservationService(ReservationRepository reservations, RestaurantTableRepository tables, Access access,
            @Value("${app.reservation.duration-minutes:120}") int duration) {
        this.reservations=reservations; this.tables=tables; this.access=access; this.duration=duration;
        if(duration<1 || duration>1440) throw new IllegalArgumentException("Reservation duration must be 1 to 1440 minutes");
    }
    public List<Reservation> getAllReservations() { return reservations.findAll(); }
    public List<Reservation> getReservationsByEmail(String email) {
        access.owner(email); return reservations.findByCustomerEmail(email);
    }
    public Reservation getReservation(Long id) {
        Reservation r=reservations.findById(id).orElseThrow(() -> missing());
        access.owner(r.getCustomerEmail()); return r;
    }
    private ResponseStatusException missing() { return new ResponseStatusException(HttpStatus.NOT_FOUND,"Reservation not found"); }
    private Reservation locked(Long id) { return reservations.lockById(id).orElseThrow(() -> missing()); }
    private void validate(Reservation r) {
        if(r.getReservationDate()==null || r.getReservationTime()==null || r.getTableNumber()==null ||
            r.getNumberOfGuests()<1 || r.getCustomerName()==null || r.getCustomerName().isBlank())
            throw new IllegalArgumentException("Name, date, time, table and a positive guest count are required");
        if(LocalDateTime.of(r.getReservationDate(),r.getReservationTime()).isBefore(LocalDateTime.now()))
            throw new IllegalArgumentException("Reservation must be in the future");
    }
    private boolean overlaps(Reservation a, LocalDate date, LocalTime time) {
        LocalDateTime start=LocalDateTime.of(date,time), other=LocalDateTime.of(a.getReservationDate(),a.getReservationTime());
        return start.isBefore(other.plusMinutes(duration)) && other.isBefore(start.plusMinutes(duration));
    }
    private boolean conflict(Integer table, LocalDate date, LocalTime time, Long exclude) {
        return reservations.findByTableNumberAndReservationDateBetween(table,date.minusDays(1),date.plusDays(1)).stream()
            .filter(r -> r.getStatus()!=ReservationStatus.CANCELLED && !Objects.equals(exclude,r.getId()))
            .anyMatch(r -> overlaps(r,date,time));
    }
    private void checkTable(Reservation r, Long exclude) {
        // The table row is the shared lock for all booking writers, including first bookings.
        RestaurantTable table=tables.lockByTableNumber(r.getTableNumber())
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,"Table not found"));
        if(table.getStatus()!=TableStatus.AVAILABLE || r.getNumberOfGuests()>table.getCapacity())
            throw new ResponseStatusException(HttpStatus.CONFLICT,"Table unavailable or too small");
        if(conflict(r.getTableNumber(),r.getReservationDate(),r.getReservationTime(),exclude))
            throw new ResponseStatusException(HttpStatus.CONFLICT,"Table already booked during this time");
    }
    public Reservation createReservation(Reservation r) {
        r.setId(null);
        if(!access.isAdmin()) r.setCustomerEmail(access.email());
        r.setCustomerEmail(com.restaurant.reservation_system.config.Passwords.email(r.getCustomerEmail()));
        validate(r); checkTable(r,null); r.setStatus(ReservationStatus.PENDING);
        return reservations.save(r);
    }
    public Reservation updateReservation(Long id, Reservation input) {
        Reservation r=locked(id); access.owner(r.getCustomerEmail());
        if(r.getStatus()==ReservationStatus.CANCELLED) throw new ResponseStatusException(HttpStatus.CONFLICT,"Cancelled reservations cannot be edited");
        validate(input); checkTable(input,id);
        r.setCustomerName(input.getCustomerName()); r.setCustomerPhone(input.getCustomerPhone());
        r.setReservationDate(input.getReservationDate()); r.setReservationTime(input.getReservationTime());
        r.setNumberOfGuests(input.getNumberOfGuests()); r.setTableNumber(input.getTableNumber()); r.setSpecialRequest(input.getSpecialRequest());
        // Changes require renewed approval; the client cannot set status or ownership.
        r.setStatus(ReservationStatus.PENDING);
        return reservations.save(r);
    }
    public Reservation updateStatus(Long id, ReservationStatus status) {
        Reservation r=locked(id); access.owner(r.getCustomerEmail());
        if(!access.isAdmin() && status!=ReservationStatus.CANCELLED) throw new ResponseStatusException(HttpStatus.FORBIDDEN);
        if(status==null) throw new IllegalArgumentException("Status is required");
        if(status!=ReservationStatus.CANCELLED) { validate(r); checkTable(r,id); }
        r.setStatus(status); return reservations.save(r);
    }
    public void deleteReservation(Long id) {
        Reservation r=locked(id); access.owner(r.getCustomerEmail()); reservations.delete(r);
    }
    @Transactional(readOnly=true)
    public List<RestaurantTable> available(LocalDate date,LocalTime time,Long exclude) {
        if((date==null)!=(time==null)) throw new IllegalArgumentException("Both date and time are required");
        if(exclude!=null) getReservation(exclude);
        return tables.findByStatus(TableStatus.AVAILABLE).stream()
            .filter(t -> date==null || !conflict(t.getTableNumber(),date,time,exclude)).toList();
    }
}
