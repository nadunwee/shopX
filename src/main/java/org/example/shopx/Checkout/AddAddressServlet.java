package org.example.shopx.Checkout;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.shopx.DBConnection;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;

public class AddAddressServlet extends HttpServlet {

    // Handle GET or POST depending on what your form uses
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String street = request.getParameter("street");
        String city = request.getParameter("city");
        int zip = Integer.parseInt(request.getParameter("zip"));

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        int userId = getUserIdByUsername(username);
        boolean success = updateAddress(userId, fullName, street, city, zip);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        if (success) {
            out.println("<p>Address added successfully.</p>");
        } else {
            out.println("<p>Failed to add address.</p>");
        }
    }

    private int getUserIdByUsername(String username) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT id FROM users WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt("id");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    private boolean updateAddress(int userId, String fullName, String street, String city, int zip) {
        try (Connection conn = DBConnection.getConnection()) {
            String query = "INSERT INTO delivery_address (userId, fullName, street, city, zip) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, userId);
                stmt.setString(2, fullName);
                stmt.setString(3, street);
                stmt.setString(4, city);
                stmt.setInt(5, zip);
                return stmt.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static ArrayList<AddressModel> getNewAddress(String username) {
        ArrayList<AddressModel> newAddressData = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM delivery_address da JOIN users u ON u.id = da.userId WHERE u.username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        int userId = rs.getInt("userId");
                        String fullName = rs.getString("fullName");
                        String street = rs.getString("street");
                        String city = rs.getString("city");
                        int zip = rs.getInt("zip");

                        AddressModel newAddress = new AddressModel(userId, fullName, street, city, zip);
                        newAddressData.add(newAddress);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return newAddressData;
    }
}
