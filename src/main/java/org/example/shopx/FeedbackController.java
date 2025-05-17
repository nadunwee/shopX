package org.example.shopx;

import org.example.shopx.model.FeedbackModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class FeedbackController {

    public static boolean addFeedback(String name, String email, String subject, String message, String rating) {
        boolean isSuccess = false;

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return false;

            String sql = "INSERT INTO feedback (name, email, subject, message, rating) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, subject);
            stmt.setString(4, message);
            stmt.setInt(5, Integer.parseInt(rating));

            int result = stmt.executeUpdate();
            if (result > 0) {
                isSuccess = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSuccess;
    }

    public static List<FeedbackModel> getAllFeedbacks() {
        List<FeedbackModel> feedbackList = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return feedbackList;

            String sql = "SELECT name, email, subject, rating, message FROM feedback ORDER BY id DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String name = rs.getString("name");
                String email = rs.getString("email");
                String subject = rs.getString("subject");
                int rating = rs.getInt("rating");
                String message = rs.getString("message");

                FeedbackModel feedback = new FeedbackModel(name, email, subject, rating, message);
                feedbackList.add(feedback);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return feedbackList;
    }
}
