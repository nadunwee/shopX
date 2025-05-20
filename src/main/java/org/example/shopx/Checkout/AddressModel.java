package org.example.shopx.Checkout;

import org.example.shopx.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class AddressModel {
    private int addressId;
    private  String fullname;
    private  String street;
    private String city;
    private  int zip;

    public AddressModel( String fullname, String street, String city, int zip) {
        this.fullname = fullname;
        this.street = street;
        this.city = city;
        this.zip = zip;
    }

    public AddressModel(String street, String city, String postalCode) {

        this.street = street;
        this.city = city;
        this.zip = Integer.parseInt(postalCode);
    }

    public AddressModel() {

    }

    public static boolean deleteAddress(int addressID, int userId) {
        boolean success = false;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM delivery_address WHERE address_id = ? AND user_id = ?")) {

            stmt.setInt(1, addressID);
            stmt.setInt(2, userId);
            success = stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }
    public static boolean updateAddress(int addressID, int userId, String fullName, String street, String city, int zip) {
        boolean isUpdated = false;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "UPDATE address SET full_name = ?, street = ?, city = ?, zip = ? WHERE address_id = ? AND user_id = ?")) {

            stmt.setString(1, fullName);
            stmt.setString(2, street);
            stmt.setString(3, city);
            stmt.setInt(4, zip);
            stmt.setInt(5, addressID);
            stmt.setInt(6, userId);

            int rowsAffected = stmt.executeUpdate();
            isUpdated = rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace(); // Or use proper logging
        }

        return isUpdated;
    }

    public static boolean updateAddress(AddressModel address) {
        boolean isUpdated = false;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE delivery_address SET full_name = ?, phone = ?, address_line1 = ?, address_line2 = ?, city = ?, postal_code = ?, country = ? WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, address.getFullname());
                stmt.setString(2, address.getStreet());
                stmt.setString(3, address.getCity());
                stmt.setInt(4, address.getZip());


                int rowsAffected = stmt.executeUpdate();
                isUpdated = rowsAffected > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isUpdated;
    }

    public static boolean deleteDeliveryAddress(int userId, int addressId) {
        boolean isSuccess = false;

        try (Connection conn = DBConnection.getConnection()) {
            String deleteQuery = "DELETE FROM delivery_address WHERE address_id = ? AND user_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteQuery)) {
                stmt.setInt(1, addressId);
                stmt.setInt(2, userId);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    isSuccess = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSuccess;
    }


    public  int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public  String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public  String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public  String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public  int getZip() {
        return zip;
    }

    public void setZip(int zip) {
        this.zip = zip;
    }

}

