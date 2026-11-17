package com.restaurant.reservation_system.config;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.http.HttpStatus;
@Component
public class Access {
    public boolean isAdmin() {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        return auth != null && auth.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
    }
    public String email() {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if(auth == null || !auth.isAuthenticated() || auth.getName().equals("anonymousUser")) throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
        return auth.getName();
    }
    public void owner(String email) {
        if(!isAdmin() && !email().equalsIgnoreCase(email == null ? "" : email)) throw new ResponseStatusException(HttpStatus.FORBIDDEN);
    }
}
