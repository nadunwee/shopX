package org.example.shopx.Checkout;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.example.shopx.DBConnection;

import java.io.IOException;
import java.sql.*;

public class OrderConfirmationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM orders WHERE order_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                request.setAttribute("order", rs);
                RequestDispatcher rd = request.getRequestDispatcher("orderConfirmation.jsp");
                rd.forward(request, response);
                return;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("error.jsp");
    }
}
