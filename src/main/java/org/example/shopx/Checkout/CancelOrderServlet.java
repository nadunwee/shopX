package org.example.shopx.Checkout;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.example.shopx.DBConnection;

import java.io.IOException;
import java.sql.*;

public class CancelOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE orders SET status = 'Cancelled' WHERE order_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("orderConfirmation.jsp?status=cancelled");
    }
}
