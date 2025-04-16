package org.example.shopx;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;

import java.io.*;
import java.sql.*;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get data from the form
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Hash the password before storing (you should use a stronger hashing algorithm like bcrypt in a real app)
        String hashedPassword = password; // Use a hashing function like BCrypt here

        // Insert data into the database
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                response.sendRedirect("accessPages/login.jsp");
                return;
            }

            String query = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, username);
                stmt.setString(2, email);
                stmt.setString(3, hashedPassword);

                // Execute the update and check the number of affected rows
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    // If one or more rows are affected, registration was successful
                    response.sendRedirect("accessPages/login.jsp");
                } else {
                    // If no rows are affected, there was an issue with the insertion
                    response.sendRedirect("accessPages/register.jsp?error=Failed%20to%20register,%20please%20try%20again.");
                }
            } catch (SQLException e) {
                // Log the error and send a detailed error message
                e.printStackTrace();
                response.sendRedirect("accessPages/register.jsp?error=" + e.getMessage());
            }
        } catch (SQLException e) {
            // Log the error and send a detailed error message
            e.printStackTrace();
            response.sendRedirect("accessPages/register.jsp?error=" + e.getMessage());
        }
    }
}
