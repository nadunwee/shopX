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
            String password = request.getParameter("password");
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");

            try {
                Connection conn = DBConnection.getConnection();
                String sql = "UPDATE users SET email = ?, password = ?, dob = ?, gender = ? WHERE username = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, email);
                stmt.setString(2, password);
                stmt.setString(3, dob);
                stmt.setString(4, gender);
                stmt.setString(5, username);

                int updated = stmt.executeUpdate();

                stmt.close();
                conn.close();

                response.sendRedirect("account.jsp");
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
