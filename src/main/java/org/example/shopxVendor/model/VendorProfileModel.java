package org.example.shopxVendor.model;

public class VendorProfileModel {
    private int id;
    private String storeName, username, vendorDOB, email, password, vendorAddress, imageFileName, createdAt;

    public VendorProfileModel(int id, String storeName, String username, String vendorDOB, String email, String password, String vendorAddress, String createdAt, String imageFileName) {
        this.id = id;
        this.storeName = storeName;
        this.username = username;
        this.vendorDOB = vendorDOB;
        this.email = email;
        this.password = password;
        this.vendorAddress = vendorAddress;
        this.createdAt = createdAt;
        this.imageFileName = imageFileName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getVendorDOB() {
        return vendorDOB;
    }

    public void setVendorDOB(String vendorDOB) {
        this.vendorDOB = vendorDOB;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getVendorAddress() {
        return vendorAddress;
    }

    public void setVendorAddress(String vendorAddress) {
        this.vendorAddress = vendorAddress;
    }

    public String getImageFileName() {
        return imageFileName;
    }

    public void setImageFileName(String imageFileName) {
        this.imageFileName = imageFileName;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}
