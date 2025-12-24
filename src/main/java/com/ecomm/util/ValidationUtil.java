package com.ecomm.util;

public class ValidationUtil {

    // Email validation
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) return false;
        String regex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        return email.matches(regex);
    }

    // Phone validation (10 digits)
    public static boolean isValidPhone(String phone) {
        if (phone == null) return false;
        String regex = "^[0-9]{10}$";
        return phone.matches(regex);
    }

    // Pincode validation (6 digits)
    public static boolean isValidPincode(String pincode) {
        if (pincode == null) return false;
        String regex = "^[0-9]{6}$";
        return pincode.matches(regex);
    }

    // Price validation
    public static boolean isValidPrice(double price) {
        return price > 0 && price < 1000000;
    }

    // Stock validation
    public static boolean isValidStock(int stock) {
        return stock >= 0 && stock < 100000;
    }

    // Name validation
    public static boolean isValidName(String name) {
        return name != null && name.trim().length() >= 2 && name.trim().length() <= 100;
    }

    // Password validation (minimum 8 characters)
    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 8;
    }

    // Sanitize input to prevent XSS
    public static String sanitizeInput(String input) {
        if (input == null) return "";
        return input.replaceAll("[<>\"']", "");
    }
}