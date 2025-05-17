package org.example.shopxVendor.controller;

import org.example.shopxVendor.model.VendorProfileModel;
import org.example.shopx.DBConnection;

import java.io.File;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VendorProfileController {
    public static ArrayList<VendorProfileModel> getByUsername(String username) {

        ArrayList<VendorProfileModel> vendorDataToModel = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT * FROM vendors WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, username);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                                int id = rs.getInt("id");
                                String store_name = rs.getString("store_name");
                                String userName = rs.getString("username");
                                String vendorDOB = rs.getString("vendorDOB");
                                String email = rs.getString("email");
                                String password = rs.getString("password");
                                String vendorAddress = rs.getString("vendorAddress");
                                String createdAt = rs.getString("created_at");
                                String imageFileName = rs.getString("imageFileName");

                        VendorProfileModel vendorData = new VendorProfileModel(id, store_name, userName, vendorDOB, email, password, vendorAddress, createdAt, imageFileName);
                        vendorDataToModel.add(vendorData);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vendorDataToModel;
    }

    public static boolean updateData(String storeName, String vendorDOB, String vendorAddress, String email, String imageFileName, String username) {
        try (Connection conn = DBConnection.getConnection()) {
            String query = "UPDATE vendors SET store_name = ?, vendorDOB = ?, vendorAddress = ?, email = ?, imageFileName = ? WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, storeName);
                stmt.setString(2, vendorDOB);
                stmt.setString(3, vendorAddress);
                stmt.setString(4, email);
                stmt.setString(5, imageFileName);
                stmt.setString(6, username);
                return stmt.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean deleteVendorProfile(String username, String imageFolderPath) {
        boolean successOrNot = false;
        try (Connection conn = DBConnection.getConnection()) {
            //get the image file name from db
            String imageFileName = null;
            String getImageQuery = "SELECT imageFileName FROM vendors WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(getImageQuery)) {
                stmt.setString(1, username);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    imageFileName = rs.getString("imageFileName");
                }else{
                    return false;
                }
            }
            //delete verifications of the vendor about to delete
            String deleteVerificationQuery = "DELETE FROM vendorpendingverifications WHERE vendorID = (SELECT id FROM vendors WHERE username = ?)";
            try (PreparedStatement stmt = conn.prepareStatement(deleteVerificationQuery)) {
                stmt.setString(1, username);
                stmt.executeUpdate();
            }
            //delete the products of the vendor about to delete
            String deleteProductsQuery = "DELETE FROM products WHERE vendorID = (SELECT id FROM vendors WHERE username = ?)";
            try (PreparedStatement stmt = conn.prepareStatement(deleteProductsQuery)) {
                stmt.setString(1, username);
                stmt.executeUpdate();
            }

            // Delete vendor
            String deleteVendorQuery = "DELETE FROM vendors WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteVendorQuery)) {
                stmt.setString(1, username);
                int rows = stmt.executeUpdate();
                if(rows > 0){
                    successOrNot = true;
                }
            }

            // Delete the image file from photos folder
            if (imageFileName != null) {
                String imagePath = imageFolderPath + File.separator + imageFileName;
                File imageFile = new File(imagePath);
                if (imageFile.exists()) {
                    imageFile.delete();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            successOrNot = false;
        }
    return successOrNot;

    }

    public static boolean createVendorProfile(VendorProfileModel vendor) {
        try (Connection conn = DBConnection.getConnection()) {
            String query = "INSERT INTO vendors (store_name, username, vendorDOB, email, password, vendorAddress, imageFileName, created_at) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, vendor.getStoreName());
                stmt.setString(2, vendor.getUsername());
                stmt.setString(3, vendor.getVendorDOB());
                stmt.setString(4, vendor.getEmail());
                stmt.setString(5, vendor.getPassword()); // You should hash this in production
                stmt.setString(6, vendor.getVendorAddress());
                stmt.setString(7, vendor.getImageFileName());

                return stmt.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
