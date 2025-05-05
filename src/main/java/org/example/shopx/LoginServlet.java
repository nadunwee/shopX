package org.example.shopx;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.sql.*;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String type = request.getParameter("type");

        String table = type.equals("vendor") ? "vendors" : "users";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                response.sendRedirect("accessPages/login.jsp?error=Database%20connection%20failed");
                return;
            }

            String query = "SELECT * FROM " + table + " WHERE username = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, username);
                stmt.setString(2, password);

                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("username", rs.getString("username"));
                    session.setAttribute("type", type);

                    // Redirect based on role
                    if (type.equals("vendor")) {
                        response.sendRedirect("Vendor/vendorHome.jsp");
                    } else {
                        response.sendRedirect("homePage.jsp");
                    }
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
