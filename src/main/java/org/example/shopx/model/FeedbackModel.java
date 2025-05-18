package org.example.shopx.model;

public class FeedbackModel {
    private String name;
    private String Email;
    private String Subject;
    private int rating;
    private String Message;
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public FeedbackModel(int id, String name, String email, String subject, int rating, String message )
    {
        this.name = name;
        this.Email = email;
        this.Subject = subject;
        this.rating = rating;
        this.Message = message;
        this.id = id;

    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public String getSubject() {
        return Subject;
    }

    public void setSubject(String subject) {
        Subject = subject;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getMessage() {
        return Message;
    }

    public void setMessage(String message) {
        Message = message;
    }

}
