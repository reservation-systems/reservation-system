package com.restaurant.reservation_system.usermanagement;
import com.restaurant.reservation_system.adminmanagement.Admin;
import jakarta.servlet.http.*;
import java.util.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.web.context.SecurityContextRepository;
import org.springframework.security.web.csrf.CsrfToken;
@RestController
@RequestMapping("/api/auth")
public class AuthController {
    private final AuthService auth;
    private final CustomerService customers;
    private final SecurityContextRepository contexts;
    public AuthController(AuthService auth, CustomerService customers, SecurityContextRepository contexts) { this.auth=auth; this.customers=customers; this.contexts=contexts; }
    @GetMapping("/csrf") public Map<String,String> csrf(CsrfToken token) { return Map.of("token",token.getToken(),"headerName",token.getHeaderName()); }
    @PostMapping("/register") public Customer register(@RequestBody Customer customer) { return customers.registerCustomer(customer); }
    @PostMapping("/login") public Map<String,Object> login(@RequestBody LoginRequest input, HttpServletRequest request, HttpServletResponse response) {
        return signIn(auth.login(input.getEmail(), input.getPassword()),request,response);
    }
    public Map<String,Object> signIn(Object user, HttpServletRequest request, HttpServletResponse response) {
        boolean admin = user instanceof Admin;
        String email = admin ? ((Admin)user).getEmail() : ((Customer)user).getEmail();
        request.getSession(); request.changeSessionId();
        var context=SecurityContextHolder.createEmptyContext();
        context.setAuthentication(UsernamePasswordAuthenticationToken.authenticated(email,null,List.of(new SimpleGrantedAuthority(admin?"ROLE_ADMIN":"ROLE_CUSTOMER"))));
        SecurityContextHolder.setContext(context); contexts.saveContext(context,request,response);
        new org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository().saveToken(null,request,response);
        return Map.of("status","success","role",admin?"ADMIN":"CUSTOMER","redirect",admin?"admin-dashboard.jsp":"home.jsp",admin?"admin":"customer",user);
    }
    @GetMapping("/me") public Map<String,Object> me() {
        var a=SecurityContextHolder.getContext().getAuthentication();
        return Map.of("email",a.getName(),"role",a.getAuthorities().stream().anyMatch(r->r.getAuthority().equals("ROLE_ADMIN"))?"ADMIN":"CUSTOMER");
    }
    @PostMapping("/logout") public Map<String,String> logout(HttpServletRequest request) {
        var session=request.getSession(false); if(session!=null) session.invalidate(); SecurityContextHolder.clearContext(); return Map.of("status","success");
    }
}
