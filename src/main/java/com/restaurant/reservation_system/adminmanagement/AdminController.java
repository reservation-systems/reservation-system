package com.restaurant.reservation_system.adminmanagement;
import com.restaurant.reservation_system.usermanagement.*;
import jakarta.servlet.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.http.HttpStatus;
import java.util.*;
@RestController
@RequestMapping("/api/admin")
public class AdminController {
    private final AdminService admins; private final AuthService auth; private final AuthController sessions;
    public AdminController(AdminService admins,AuthService auth,AuthController sessions){this.admins=admins;this.auth=auth;this.sessions=sessions;}
    @GetMapping("/all") public List<Admin> all(){return admins.getAllAdmins();}
    @GetMapping("/{id}") public Admin get(@PathVariable Long id){return admins.getAdminById(id);}
    @PostMapping("/add") public Map<String,Object> add(@RequestBody Admin input){return Map.of("status","success","admin",admins.addAdmin(input));}
    @PutMapping("/update/{id}") public Map<String,Object> update(@PathVariable Long id,@RequestBody Admin input){return Map.of("status","success","admin",admins.updateAdmin(id,input));}
    @DeleteMapping("/delete/{id}") public Map<String,String> delete(@PathVariable Long id){admins.deleteAdmin(id);return Map.of("status","success");}
    @PostMapping("/login") public Map<String,Object> login(@RequestBody LoginRequest input,HttpServletRequest req,HttpServletResponse res){
        Object user=auth.login(input.getEmail(),input.getPassword());
        if(!(user instanceof Admin))throw new ResponseStatusException(HttpStatus.UNAUTHORIZED,"Invalid email or password");
        return sessions.signIn(user,req,res);
    }
}
