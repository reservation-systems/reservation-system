package com.restaurant.reservation_system.config;
import org.springframework.context.annotation.*;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.security.web.context.SecurityContextRepository;

@Configuration
public class SecurityConfig {
    @Bean PasswordEncoder passwordEncoder() { return new BCryptPasswordEncoder(); }
    @Bean SecurityContextRepository securityContextRepository() { return new HttpSessionSecurityContextRepository(); }
    @Bean SecurityFilterChain security(HttpSecurity http, SecurityContextRepository contexts) throws Exception {
        http.securityContext(c -> c.securityContextRepository(contexts));
        http.authorizeHttpRequests(a -> a
            .dispatcherTypeMatchers(jakarta.servlet.DispatcherType.FORWARD, jakarta.servlet.DispatcherType.ERROR).permitAll()
            .requestMatchers("/api/auth/csrf", "/api/auth/login", "/api/auth/register", "/api/admin/login").permitAll()
            .requestMatchers(HttpMethod.GET, "/api/menu", "/api/menu/**", "/api/tables", "/api/tables/available", "/api/offers/active", "/api/reviews").permitAll()
            .requestMatchers(HttpMethod.POST, "/api/offers/validate", "/api/offer-codes/validate").authenticated()
            .requestMatchers("/api/auth/me", "/api/auth/logout").authenticated()
            .requestMatchers(HttpMethod.GET, "/api/customers/email/**", "/api/reservations/customer", "/api/reservations/*", "/api/reviews/customer").authenticated()
            .requestMatchers(HttpMethod.PUT, "/api/customers/*", "/api/reservations/*", "/api/reservations/*/status").authenticated()
            .requestMatchers(HttpMethod.DELETE, "/api/reservations/*").authenticated()
            .requestMatchers(HttpMethod.POST, "/api/reservations", "/api/reviews", "/api/preorders/*", "/api/payments/process").authenticated()
            .requestMatchers("/api/**").hasRole("ADMIN")
            .requestMatchers("/admin-dashboard", "/admin-dashboard.jsp", "/customers", "/customers.jsp", "/staff", "/staff.jsp", "/tables", "/tables.jsp", "/payments", "/payments.jsp", "/reservations-admin", "/reservations-admin.jsp", "/menu-management", "/menu-management.jsp", "/offers-management", "/offers-management.jsp", "/reviews-management", "/reviews-management.jsp").hasRole("ADMIN")
            .requestMatchers("/profile", "/profile.jsp", "/my-reservations", "/my-reservations.jsp", "/customer-dashboard", "/customer-dashboard.jsp", "/payment", "/payment.jsp").authenticated()
            .anyRequest().permitAll());
        http.exceptionHandling(e -> e
            .authenticationEntryPoint((req,res,ex) -> { if(req.getRequestURI().contains("/api/")) res.sendError(401); else res.sendRedirect(req.getContextPath()+"/login.jsp"); })
            .accessDeniedHandler((req,res,ex) -> res.sendError(403)));
        http.logout(l -> l.disable());
        http.requestCache(c -> c.disable());
        return http.build();
    }
}
