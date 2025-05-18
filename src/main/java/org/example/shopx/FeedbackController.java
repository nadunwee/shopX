package org.example.shopx;

import jakarta.servlet.http.HttpServlet;
import org.example.shopx.model.FeedbackModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

            String sql = "SELECT id, name, email, subject, rating, message FROM feedback ORDER BY id DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String name = rs.getString("name");
                String email = rs.getString("email");
                String subject = rs.getString("subject");
                int rating = rs.getInt("rating");
                String message = rs.getString("message");
                int id = rs.getInt("id");

                FeedbackModel feedback = new FeedbackModel(id, name, email, subject, rating, message);
                feedbackList.add(feedback);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return feedbackList;
    }
    public static boolean deleteFeedback(int feedbackId) {
        boolean isDeleted = false;
        String sql = "DELETE FROM feedback WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            if (conn == null) return false;

            stmt.setInt(1, feedbackId);
            int rows = stmt.executeUpdate();
            isDeleted = rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isDeleted;
    }


}
