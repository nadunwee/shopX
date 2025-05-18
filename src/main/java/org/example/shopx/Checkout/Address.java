package org.example.shopx.Checkout;

public class Address {
    private int userid;
    private int addressId;
    private String username;
    private String street;
    private String city;
    private String state;
    private String postalCode;
    private String country;

    public Address() {}

    public Address(int userid, String fullName, String street, String city, int zip) {
        this.userid=userid;
        this.username=fullName;
        this.street=street;
        this.city=city;
        this.postalCode=String.valueOf(zip);

    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
}
