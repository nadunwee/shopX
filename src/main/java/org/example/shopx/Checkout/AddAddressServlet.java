package org.example.shopx.Checkout;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.example.shopx.DBConnection;

import java.io.IOException;
import java.sql.*;

public class AddAddressServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp"); // Or show an error
            return;
        }

        int userId = ((Integer) session.getAttribute("userId")).intValue();
        request.getSession().setAttribute("userId", userId);

        String fullName = request.getParameter("fullName");
        String street = request.getParameter("street");
        String city = request.getParameter("city");
        String zip = request.getParameter("zip");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO delivery_address (user_id, full_name, street, city, zip) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setString(2, fullName);
            stmt.setString(3, street);
            stmt.setString(4, city);
            stmt.setString(5, zip);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // ideally log this
        }

        response.sendRedirect("checkout.jsp"); // reloads the page to show new address
    }
}
