package org.example.shopx.Checkout;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class DeleteAddressServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int addressId = Integer.parseInt(request.getParameter("addressId"));

        try {
            Connection conn = org.example.shopx.DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("DELETE FROM delivery_address WHERE id = ?");
            ps.setInt(1, addressId);
            ps.executeUpdate();

            response.sendRedirect("checkout.jsp");
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
