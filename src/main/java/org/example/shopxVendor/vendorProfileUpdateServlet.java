package org.example.shopxVendor;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.example.shopx.DBConnection;

import java.io.IOException;
import java.sql.*;

public class vendorProfileUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");


        String storeName = request.getParameter("store_name");
        String vendorDOB = request.getParameter("vendorDOB");
        String vendorAddress = request.getParameter("vendorAddress");
        String email = request.getParameter("email");

        String username = (String) request.getSession().getAttribute("username");

        try (Connection conn = DBConnection.getConnection()) {
            String query = "UPDATE vendors SET store_name = ?, vendorDOB = ?, vendorAddress = ?, email = ? WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, storeName);
                stmt.setString(2, vendorDOB);
                stmt.setString(3, vendorAddress);
                stmt.setString(4, email);
                stmt.setString(5, username);
                stmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("Vendor/vendorProfilePage.jsp");
    }
}
