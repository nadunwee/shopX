package org.example.shopx;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeParseException;

public class InputValidator {
    public static boolean isValidUsername(String username) {
        // check whether there's username and it's 4 to 20 char long
        return username != null && username.matches("^[a-zA-Z0-9_]{4,20}$");
    }

    public static boolean isValidEmail(String email) {
        return email != null && email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$");
    }

    public static boolean isStrongPassword(String password) {
        return password != null &&
                password.length() >= 8 &&
                password.matches(".*[A-Z].*") &&
                password.matches(".*[a-z].*") &&
                password.matches(".*\\d.*") &&
                password.matches(".*[!@#$%^&*()].*");
    }


    public static boolean isValidDOB(String dob) {
        if (dob == null) return false;
        try {
            LocalDate birthDate = LocalDate.parse(dob); // expects yyyy-MM-dd
            LocalDate today = LocalDate.now();
            int age = Period.between(birthDate, today).getYears();
            return age >= 13; // or another age requirement
        } catch (DateTimeParseException e) {
            return false;
        }
    }

    public static boolean isValidNationalID(String id) {
        return id != null && id.matches("^\\d{8,12}$"); // 8 to 12 digits
    }

}
