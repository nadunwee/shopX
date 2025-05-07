package org.example.shopxVendor;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import org.example.shopx.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class vendorSubscriptionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String companyName = request.getParameter("companyName");
        String businessAddress = request.getParameter("businessAddress");
        String businessEmail = request.getParameter("businessEmail");
        String businessContactNo = request.getParameter("businessContactNo");
        String businessRegNo = request.getParameter("businessRegNo");

        HttpSession session = request.getSession(false);
        String type = (session != null) ? (String) session.getAttribute("subscriptionType") : null;
        int vendorID = (session != null) ? (int) session.getAttribute("vendorID") : null;

        try (Connection conn = DBConnection.getConnection()) {
                String query = "INSERT INTO vendorpendingverifications (companyName, businessAddress, businessEmail, businessContactNo, businessRegNo, vendorID, type) VALUES (?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, companyName);
                    stmt.setString(2, businessAddress);
                    stmt.setString(3, businessEmail);
                    stmt.setString(4, businessContactNo);
                    stmt.setString(5, businessRegNo);
                    stmt.setInt(6, vendorID);
                    stmt.setString(7, type);

                    stmt.executeUpdate();
                    response.sendRedirect("Vendor/vendorPaymentPage.jsp");

                }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("accessPages/register.jsp?error=" + e.getMessage());
        }
    }
}
