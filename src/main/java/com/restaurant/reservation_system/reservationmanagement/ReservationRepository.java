package com.restaurant.reservation_system.reservationmanagement;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import jakarta.persistence.LockModeType;
import java.time.LocalDate;
import java.util.*;
public interface ReservationRepository extends JpaRepository<Reservation,Long> {
    List<Reservation> findByCustomerEmail(String email);
    List<Reservation> findByTableNumberAndReservationDateBetween(Integer tableNumber,LocalDate start,LocalDate end);
    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("select r from Reservation r where r.id=:id")
    Optional<Reservation> lockById(@Param("id") Long id);
}
