package com.restaurant.reservation_system;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.restaurant.reservation_system.reservationmanagement.*;
import com.restaurant.reservation_system.tablemanagement.*;
import com.restaurant.reservation_system.usermanagement.*;
import com.restaurant.reservation_system.adminmanagement.*;
import com.restaurant.reservation_system.paymentmanagement.*;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import java.time.*;
import java.util.*;
import java.util.concurrent.*;
import static org.assertj.core.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.*;

@SpringBootTest(properties={"spring.datasource.url=jdbc:h2:mem:security-tests;DB_CLOSE_DELAY=-1","app.bootstrap-admin.email=","app.bootstrap-admin.password="})
@AutoConfigureMockMvc
class ReservationSecurityTests {
    @Autowired MockMvc mvc;
    @Autowired org.springframework.boot.CommandLineRunner initialize;
    @Autowired ObjectMapper json;
    @Autowired ReservationRepository bookings;
    @Autowired RestaurantTableRepository tables;
    @Autowired CustomerRepository customers;
    @Autowired AdminRepository admins;
    @Autowired PaymentRepository payments;
    @Autowired PasswordEncoder passwords;
    @Autowired ReservationService service;
    static final String EMAIL="customer@example.com";
    @BeforeEach void setup() {
        payments.deleteAll(); bookings.deleteAll(); tables.deleteAll(); customers.deleteAll(); admins.deleteAll();
        RestaurantTable t=new RestaurantTable();t.setTableNumber(1);t.setCapacity(4);tables.save(t);
    }
    Reservation booking(LocalTime time) {
        Reservation r=new Reservation();r.setCustomerName("Customer");r.setCustomerEmail(EMAIL);r.setCustomerPhone("0771234567");
        r.setReservationDate(LocalDate.now().plusDays(3));r.setReservationTime(time);r.setNumberOfGuests(2);r.setTableNumber(1);return r;
    }
    void identity() {
        SecurityContextHolder.getContext().setAuthentication(UsernamePasswordAuthenticationToken.authenticated(EMAIL,null,List.of(new SimpleGrantedAuthority("ROLE_CUSTOMER"))));
    }
    @AfterEach void clear(){SecurityContextHolder.clearContext();}
    @Test void unauthenticatedAndCustomerCannotUseAdminApis() throws Exception {
        mvc.perform(get("/api/staff")).andExpect(status().isUnauthorized());
        mvc.perform(get("/api/staff").with(user(EMAIL).roles("CUSTOMER"))).andExpect(status().isForbidden());
        mvc.perform(get("/api/staff").with(user("admin@example.com").roles("ADMIN"))).andExpect(status().isOk());
        mvc.perform(get("/api/reservations").with(user(EMAIL).roles("CUSTOMER"))).andExpect(status().isForbidden());
        mvc.perform(get("/api/reservations/customer").param("email",EMAIL).with(user(EMAIL).roles("CUSTOMER"))).andExpect(status().isOk());
    }
    @Test void csrfRequiredAndCrossOriginNotAllowed() throws Exception {
        mvc.perform(post("/api/auth/register").contentType("application/json").content("{}")).andExpect(status().isForbidden());
        mvc.perform(options("/api/tables").header("Origin","https://evil.example").header("Access-Control-Request-Method","POST"))
            .andExpect(header().doesNotExist("Access-Control-Allow-Origin"));
        mvc.perform(get("/api/auth/csrf")).andExpect(status().isOk()).andExpect(jsonPath("$.token").isNotEmpty());
    }
    @Test void registrationHashesPasswordAndLoginCreatesRealSession() throws Exception {
        String data="{\"name\":\"Customer\",\"email\":\"customer@example.com\",\"password\":\"StrongPass123\"}";
        mvc.perform(post("/api/auth/register").with(csrf()).contentType("application/json").content(data))
            .andExpect(status().isOk()).andExpect(jsonPath("$.password").doesNotExist());
        assertThat(passwords.matches("StrongPass123",customers.findByEmail(EMAIL).orElseThrow().getPassword())).isTrue();
        var result=mvc.perform(post("/api/auth/login").with(csrf()).contentType("application/json")
            .content("{\"email\":\"customer@example.com\",\"password\":\"StrongPass123\"}"))
            .andExpect(status().isOk()).andExpect(jsonPath("$.customer.password").doesNotExist()).andReturn();
        MockHttpSession session=(MockHttpSession)result.getRequest().getSession(false);
        mvc.perform(get("/api/auth/me").session(session)).andExpect(status().isOk()).andExpect(jsonPath("$.email").value(EMAIL));
        mvc.perform(post("/api/auth/logout").session(session).with(csrf())).andExpect(status().isOk());
        assertThat(session.isInvalid()).isTrue();
        mvc.perform(post("/api/auth/login").with(csrf()).contentType("application/json")
            .content("{\"email\":\"customer@example.com\",\"password\":\"wrong\"}")).andExpect(status().isUnauthorized());
    }
    @Test void adminLoginAlsoCreatesSessionAndNeverLeaksPassword() throws Exception {
        admins.save(new Admin("Admin","admin@example.com",passwords.encode("StrongPass123"),"ADMIN"));
        var result=mvc.perform(post("/api/admin/login").with(csrf()).contentType("application/json")
            .content("{\"email\":\"admin@example.com\",\"password\":\"StrongPass123\"}"))
            .andExpect(status().isOk()).andExpect(jsonPath("$.admin.password").doesNotExist()).andReturn();
        mvc.perform(get("/api/staff").session((MockHttpSession)result.getRequest().getSession(false))).andExpect(status().isOk());
    }
    @Test void migratesPlaintextAndDisablesOldSeedPassword() throws Exception {
        Customer c=new Customer();c.setEmail(EMAIL);c.setPassword("LegacyPass123");customers.save(c);
        admins.save(new Admin("Old admin","admin@gmail.com","admin123","ADMIN"));
        initialize.run();
        assertThat(passwords.matches("LegacyPass123",customers.findByEmail(EMAIL).orElseThrow().getPassword())).isTrue();
        assertThat(passwords.matches("admin123",admins.findByEmail("admin@gmail.com").orElseThrow().getPassword())).isFalse();
    }
    @Test void blankProfilePasswordPreservesExistingHash() throws Exception {
        Customer c=new Customer();c.setEmail(EMAIL);c.setName("Customer");c.setPassword(passwords.encode("StrongPass123"));c=customers.save(c);
        String hash=c.getPassword();
        mvc.perform(put("/api/customers/"+c.getId()).with(user(EMAIL)).with(csrf()).contentType("application/json")
            .content("{\"name\":\"Updated\",\"email\":\"customer@example.com\",\"password\":\"\"}")).andExpect(status().isOk()).andExpect(jsonPath("$.password").doesNotExist());
        assertThat(customers.findById(c.getId()).orElseThrow().getPassword()).isEqualTo(hash);
    }
    @Test void weakPasswordsRejectedAndSeededAdminIsAbsent() throws Exception {
        mvc.perform(post("/api/auth/register").with(csrf()).contentType("application/json")
            .content("{\"email\":\"new@example.com\",\"password\":\"123\"}")).andExpect(status().isBadRequest());
        assertThat(admins.findByEmail("admin@gmail.com")).isEmpty();
    }
    @Test void customersCannotReadOrModifyOthersRecords() throws Exception {
        Reservation r=booking(LocalTime.NOON);r.setCustomerEmail("other@example.com");r=bookings.save(r);
        mvc.perform(get("/api/reservations/"+r.getId()).with(user(EMAIL))).andExpect(status().isForbidden());
        mvc.perform(delete("/api/reservations/"+r.getId()).with(user(EMAIL)).with(csrf())).andExpect(status().isForbidden());
        mvc.perform(put("/api/reservations/"+r.getId()).with(user(EMAIL)).with(csrf()).contentType("application/json")
            .content(json.writeValueAsString(booking(LocalTime.of(15,0))))).andExpect(status().isForbidden());
        mvc.perform(get("/api/reservations/customer").param("email","other@example.com").with(user(EMAIL))).andExpect(status().isForbidden());
        Customer c=new Customer();c.setEmail("other@example.com");c.setPassword(passwords.encode("StrongPass123"));c=customers.save(c);
        mvc.perform(put("/api/customers/"+c.getId()).with(user(EMAIL)).with(csrf()).contentType("application/json")
            .content("{\"email\":\"other@example.com\"}")).andExpect(status().isForbidden());
    }
    @Test void bookingOwnershipAndStatusCannotBeSpoofed() throws Exception {
        Reservation r=booking(LocalTime.NOON);r.setCustomerEmail("victim@example.com");r.setStatus(ReservationStatus.CONFIRMED);
        var result=mvc.perform(post("/api/reservations").with(user(EMAIL)).with(csrf()).contentType("application/json").content(json.writeValueAsString(r)))
            .andExpect(status().isOk()).andExpect(jsonPath("$.customerEmail").value(EMAIL)).andExpect(jsonPath("$.status").value("PENDING")).andReturn();
        long id=json.readTree(result.getResponse().getContentAsString()).get("id").asLong();
        mvc.perform(put("/api/reservations/"+id+"/status").param("status","CONFIRMED").with(user(EMAIL)).with(csrf())).andExpect(status().isForbidden());
    }
    @Test void overlappingSlotsRejectedButSeparateTimesAndDatesAllowed() {
        identity();service.createReservation(booking(LocalTime.NOON));
        assertThatThrownBy(()->service.createReservation(booking(LocalTime.of(13,0)))).isInstanceOf(org.springframework.web.server.ResponseStatusException.class);
        service.createReservation(booking(LocalTime.of(14,0)));
        Reservation next=booking(LocalTime.NOON);next.setReservationDate(next.getReservationDate().plusDays(1));service.createReservation(next);
        assertThat(bookings.count()).isEqualTo(3);
        assertThat(tables.findByTableNumber(1).orElseThrow().getStatus()).isEqualTo(TableStatus.AVAILABLE);
    }
    @Test void midnightOverlapIsRejected() {
        identity();Reservation first=booking(LocalTime.of(23,0));service.createReservation(first);
        Reservation second=booking(LocalTime.of(0,30));second.setReservationDate(first.getReservationDate().plusDays(1));
        assertThatThrownBy(()->service.createReservation(second)).isInstanceOf(org.springframework.web.server.ResponseStatusException.class);
    }
    @Test void editingAndAvailabilityExcludeCurrentReservation() throws Exception {
        identity();Reservation r=service.createReservation(booking(LocalTime.NOON));
        assertThat(service.available(r.getReservationDate(),LocalTime.NOON,null)).isEmpty();
        assertThat(service.available(r.getReservationDate(),LocalTime.NOON,r.getId())).hasSize(1);
        mvc.perform(put("/api/reservations/"+r.getId()).with(user(EMAIL)).with(csrf()).contentType("application/json")
            .content(json.writeValueAsString(booking(LocalTime.of(16,0))))).andExpect(status().isOk()).andExpect(jsonPath("$.reservationTime").value("16:00:00"));
        assertThat(service.available(r.getReservationDate(),LocalTime.NOON,null)).hasSize(1);
    }
    @Test void cancellingOrDeletingReleasesOnlyThatSlot() {
        identity();Reservation a=service.createReservation(booking(LocalTime.NOON));Reservation b=service.createReservation(booking(LocalTime.of(16,0)));
        service.updateStatus(a.getId(),ReservationStatus.CANCELLED);
        assertThat(service.available(a.getReservationDate(),LocalTime.NOON,null)).hasSize(1);
        assertThat(service.available(b.getReservationDate(),LocalTime.of(16,0),null)).isEmpty();
        service.deleteReservation(b.getId());
        assertThat(service.available(b.getReservationDate(),LocalTime.of(16,0),null)).hasSize(1);
    }
    @Test void capacityAndPastTimesRejected() {
        identity();Reservation large=booking(LocalTime.NOON);large.setNumberOfGuests(5);
        assertThatThrownBy(()->service.createReservation(large)).isInstanceOf(org.springframework.web.server.ResponseStatusException.class);
        Reservation past=booking(LocalTime.NOON);past.setReservationDate(LocalDate.now().minusDays(1));
        assertThatThrownBy(()->service.createReservation(past)).isInstanceOf(IllegalArgumentException.class);
    }
    @Test void concurrentBookingsHaveOnlyOneWinner() throws Exception {
        var pool=Executors.newFixedThreadPool(2);var ready=new CountDownLatch(2);var start=new CountDownLatch(1);
        Callable<Boolean> attempt=()->{ identity();ready.countDown();start.await();try {service.createReservation(booking(LocalTime.NOON));return true;}
            catch(org.springframework.web.server.ResponseStatusException ex){assertThat(ex.getStatusCode().value()).isEqualTo(409);return false;}
            finally{SecurityContextHolder.clearContext();}};
        try {
            var a=pool.submit(attempt);var b=pool.submit(attempt);assertThat(ready.await(10,TimeUnit.SECONDS)).isTrue();start.countDown();
            assertThat(List.of(a.get(20,TimeUnit.SECONDS),b.get(20,TimeUnit.SECONDS))).containsExactlyInAnyOrder(true,false);
            assertThat(bookings.count()).isEqualTo(1);
        } finally {pool.shutdownNow();}
    }
    @Test void paymentOwnershipAndCardMaskingAreEnforced() throws Exception {
        mvc.perform(post("/api/payments/process").with(user(EMAIL)).with(csrf()).contentType("application/json")
            .content("{\"customerEmail\":\"victim@example.com\",\"amount\":100,\"paymentMethod\":\"CARD\",\"cardNumber\":\"4111111111111111\"}"))
            .andExpect(status().isOk()).andExpect(jsonPath("$.customerEmail").value(EMAIL)).andExpect(jsonPath("$.cardNumber").value("****-****-****-1111"));
        mvc.perform(post("/api/payments/process").with(user(EMAIL)).with(csrf()).contentType("application/json")
            .content("{\"amount\":-1,\"paymentMethod\":\"CASH\"}")).andExpect(status().isBadRequest());
        mvc.perform(get("/api/payments").with(user(EMAIL))).andExpect(status().isForbidden());
    }
}
