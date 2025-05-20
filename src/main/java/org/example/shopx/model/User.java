package org.example.shopx.model;

public class User {
    private int id; // userId
    private String username;
    private String email;
    private String password;
    private String gender;
    private String dob;

    // Constructor with id
    public User(int id, String username, String email, String password, String gender, String dob) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.dob = dob;
    }

    // Optional: constructor without id (e.g., for registration)
    public User(String username, String email, String password, String gender, String dob) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.dob = dob;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public String gender() {
        return gender;
    }

    public void gender(String gender) {
        this.gender = gender;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
