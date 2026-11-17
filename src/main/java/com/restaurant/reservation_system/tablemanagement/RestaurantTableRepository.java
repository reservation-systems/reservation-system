package com.restaurant.reservation_system.tablemanagement;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import jakarta.persistence.LockModeType;
import java.util.*;
public interface RestaurantTableRepository extends JpaRepository<RestaurantTable,Long> {
    List<RestaurantTable> findByStatus(TableStatus status);
    Optional<RestaurantTable> findByTableNumber(Integer tableNumber);
    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("select t from RestaurantTable t where t.tableNumber=:number")
    Optional<RestaurantTable> lockByTableNumber(@Param("number") Integer number);
}
