package com.util;

public class PasswordUtil {
    private static final int SHIFT = 2; // You can change the shift value as per your requirement.

    // Method to encrypt a password using Caesar cipher
    public static String encryptPassword(String password) {
        StringBuilder encrypted = new StringBuilder();
        for (char c : password.toCharArray()) {
            if (Character.isLetter(c)) {
                char base = Character.isLowerCase(c) ? 'a' : 'A';
                encrypted.append((char) ((c - base + SHIFT) % 26 + base));
            } else {
                // Leave numbers and special characters as is
                encrypted.append(c);
            }
        }
        return encrypted.toString();
    }
    
  

    // Method to verify if the input password matches the stored encrypted password
    public static boolean verifyPassword(String inputPassword, String storedPassword) {
    	System.out.println(encryptPassword(inputPassword)+" "+storedPassword);
        return encryptPassword(inputPassword).equals(storedPassword);
    }
}
