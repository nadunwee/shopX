package org.example.shopx;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");

        if ("updateProfile".equals(action)) {
            String username = request.getParameter("username");
            String email = request.getParameter("email");

            try {
                Connection conn = DBConnection.getConnection();
                String sql = "UPDATE users SET email = ? WHERE username = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, email);
                stmt.setString(2, username);

                int updated = stmt.executeUpdate();

                stmt.close();
                conn.close();

                response.sendRedirect("account.jsp");  // redirect back to account page
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error updating profile");
            }
        } else if ("deleteProfile".equals(action)) {
            String username = request.getParameter("username");

            try {
                Connection conn = DBConnection.getConnection();
                String sql = "DELETE FROM users WHERE username = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);

                int deleted = stmt.executeUpdate();

                stmt.close();
                conn.close();

                // Invalidate session if user deleted their own account
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }

                response.sendRedirect("index.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error updating profile");
            }
        }
    }
}
