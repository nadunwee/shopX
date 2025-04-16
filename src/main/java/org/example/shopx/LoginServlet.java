package org.example.shopx;

import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.sql.*;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                response.sendRedirect("accessPages/login.jsp?error=Database%20connection%20failed");
                return;
            }

            String query = "SELECT * FROM users WHERE email = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, email);
                stmt.setString(2, password); // ⚠️ should use hashed password comparison!

                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    // Login success: create session
                    HttpSession session = request.getSession();
//                    session.setAttribute("user", rs.getString("username"));

                    response.sendRedirect("home.jsp"); // Or your dashboard
                } else {
                    response.sendRedirect("accessPages/login.jsp?error=Invalid%20credentials");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("accessPages/login.jsp?error=" + e.getMessage());
        }
    }
}
