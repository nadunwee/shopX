package org.example.shopxVendor.controller;

import org.example.shopx.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class VendorSubscriptionController {
    public static boolean insertSubscriptionForm(String companyName, String businessAddress, String businessEmail, String businessContactNo, String businessRegNo, String type, int vendorID) {
        boolean success = false;

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
                int rowsUpdated = stmt.executeUpdate();
                if (rowsUpdated > 0) {
                    success = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    public static boolean paymentSystemInsertion(String cardType, String cardNo, String cardEXP, String cardCVN, int vendorID){
        boolean isSuccess = false;

        try (Connection conn = DBConnection.getConnection()) {
            String query = "UPDATE vendorpendingverifications SET cardType = ?, cardNo = ?, cardEXP = ?, cardCVN = ?, verificationStatus = ? WHERE vendorID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, cardType);
                stmt.setString(2, cardNo);
                stmt.setString(3, cardEXP);
                stmt.setString(4, cardCVN);
                stmt.setString(5, "pending");
                stmt.setInt(6, vendorID);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    isSuccess = true;
                }
             }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }
}
