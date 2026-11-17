package com.restaurant.reservation_system;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(properties = {"spring.datasource.url=jdbc:h2:mem:context-test;DB_CLOSE_DELAY=-1", "app.bootstrap-admin.email=", "app.bootstrap-admin.password="})
class ReservationSystemApplicationTests {

	@Test
	void contextLoads() {
	}

}
