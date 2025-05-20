package org.example.shopx.Checkout;

import org.example.shopx.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class AddressModel {
    private int addressId;
    private static String fullname;
    private static String street;
    private static String city;
    private static int zip;

    public AddressModel(int addressId, String fullname, String street, String city, int zip) {
        this.addressId = addressId;
        AddressModel.fullname = fullname;
        AddressModel.street = street;
        AddressModel.city = city;
        AddressModel.zip = zip;
    }

    public AddressModel(String street, String city, String postalCode) {

        AddressModel.street = street;
        AddressModel.city = city;
        AddressModel.zip = Integer.parseInt(postalCode);
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



    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public static String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        AddressModel.fullname = fullname;
    }

    public static String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        AddressModel.street = street;
    }

    public static String getCity() {
        return city;
    }

    public void setCity(String city) {
        AddressModel.city = city;
    }

    public static int getZip() {
        return zip;
    }

    public void setZip(int zip) {
        AddressModel.zip = zip;
    }

}

