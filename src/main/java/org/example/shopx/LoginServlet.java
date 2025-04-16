package org.example.shopx;

import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.sql.*;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                response.sendRedirect("accessPages/login.jsp?error=Database%20connection%20failed");
                return;
            }

            String query = "SELECT * FROM users WHERE username = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, username);
                stmt.setString(2, password); // ⚠️ should use hashed password comparison!

                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    // Login success: create session
                    HttpSession session = request.getSession();
                    session.setAttribute("username", rs.getString("username"));

                    response.sendRedirect("homePage.jsp");
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
