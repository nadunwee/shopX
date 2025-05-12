package org.example.shopxVendor.controller;

import jakarta.servlet.http.Part;
import org.example.shopx.DBConnection;
import org.example.shopxVendor.model.VendorProductModel;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class VendorProductController {
    public static ArrayList<VendorProductModel> getProductbyVendorID(int vendorID) {
        ArrayList<VendorProductModel> vendorProductsDetails = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM products WHERE vendorID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, vendorID);
                try (ResultSet rs = stmt.executeQuery();) {
                    while (rs.next()) {
                        String productImageFileName = rs.getString("productImageFileName");
                        int product_id = rs.getInt("product_id");
                        String name = rs.getString("name");
                        String additional_details = rs.getString("additional_details");
                        String category = rs.getString("category");
                        float price = rs.getFloat("price");
                        int stock = rs.getInt("stock");
                        float rating = rs.getFloat("rating");

                        VendorProductModel vendorProductsOBJ = new VendorProductModel(productImageFileName, product_id, name, additional_details, category, price, stock, rating);
                        vendorProductsDetails.add(vendorProductsOBJ);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vendorProductsDetails;
    }
    public static boolean addProduct(String name, String category, String additional_details, float price, int stock, String productImageFileName, int vendorID){

        boolean insertSuccess = false;

        try(Connection conn = DBConnection.getConnection()){
            String query = "INSERT INTO products(name, category, additional_details, price, stock, productImageFileName, vendorID) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try(PreparedStatement stmt = conn.prepareStatement(query)){
                stmt.setString(1, name);
                stmt.setString(2, category);
                stmt.setString(3, additional_details);
                stmt.setFloat(4, price);
                stmt.setInt(5, stock);
                stmt.setString(6, productImageFileName);
                stmt.setInt(7, vendorID);

                int rows = stmt.executeUpdate();
                if(rows > 0) {
                    insertSuccess = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return insertSuccess;
    }
    public static boolean updateProductDetails(int product_id, String name, float price, int stock, String additionalDetails, int vendorID, String productImageFileName){
        boolean isSuccess = false;

        try (Connection conn = DBConnection.getConnection()) {
            String query = "UPDATE products SET name = ?, price = ?, stock = ?, additional_details = ?, productImageFileName = ? WHERE product_id = ?";

            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, name);
                stmt.setFloat(2, price);
                stmt.setInt(3, stock);
                stmt.setString(4, additionalDetails);
                stmt.setString(5, productImageFileName);
                stmt.setInt(6, product_id);
                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    isSuccess = true;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }
    public static boolean vendorDeleteProduct(int vendorID, String name, int product_id, String productPhotosPath){

        boolean isSuccess = false;

        try (Connection conn = DBConnection.getConnection()) {
            String productImageFileName = null;
            String getImageQuery = "SELECT productImageFileName FROM products WHERE product_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(getImageQuery)) {
                stmt.setInt(1, product_id);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    productImageFileName = rs.getString("productImageFileName");
                }
            }

            // Delete from products table
            String deleteProductsQuery = "DELETE FROM products WHERE product_id = ? AND vendorID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteProductsQuery)) {
                stmt.setInt(1, product_id);
                stmt.setInt(2, vendorID);
                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    isSuccess = true;
                }
            }

            // Delete the image file from photos folder
            if (productImageFileName != null) {
                String imagePath = productPhotosPath + File.separator + productImageFileName;
                File imageFile = new File(imagePath);
                if (imageFile.exists()) {
                    imageFile.delete();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }
}