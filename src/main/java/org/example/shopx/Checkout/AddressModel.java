package org.example.shopx.Checkout;

public class AddressModel {
    private int addressId;
    private String fullname;
    private String street;
    private String city;
    private int zip;

    public AddressModel(int addressId, String fullname, String street, String city, int zip) {
        this.addressId = addressId;
        this.fullname = fullname;
        this.street = street;
        this.city = city;
        this.zip = zip;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public int getZip() {
        return zip;
    }

    public void setZip(int zip) {
        this.zip = zip;
    }
}
