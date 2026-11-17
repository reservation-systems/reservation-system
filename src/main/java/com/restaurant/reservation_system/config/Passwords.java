package com.restaurant.reservation_system.config;
public final class Passwords {
    private Passwords() {}
    public static void validate(String value) {
        if(value == null || value.length()<8 || value.getBytes(java.nio.charset.StandardCharsets.UTF_8).length>72)
            throw new IllegalArgumentException("Password must be at least 8 characters and at most 72 UTF-8 bytes");
    }
    public static String email(String value) {
        if(value == null || !value.trim().matches("[^@\\s]+@[^@\\s]+\\.[^@\\s]+"))
            throw new IllegalArgumentException("A valid email is required");
        return value.trim().toLowerCase(java.util.Locale.ROOT);
    }
}
