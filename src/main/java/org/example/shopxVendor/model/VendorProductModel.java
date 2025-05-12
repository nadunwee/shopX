package org.example.shopxVendor.model;

public class VendorProductModel {
    private String productImageFileName;
    private int product_id;
    private String name;
    private String additional_details;
    private String category;
    private float price;
    private int stock;
    private float rating;

    public VendorProductModel(String productImageFileName, int product_id, String name, String additional_details, String category, float price, int stock, float rating){
        this.productImageFileName = productImageFileName;
        this.product_id = product_id;
        this.name = name;
        this.additional_details = additional_details;
        this.category = category;
        this.price = price;
        this.stock = stock;
        this.rating = rating;
    }

    public String getProductImageFileName() {
        return productImageFileName;
    }

    public void setProductImageFileName(String productImageFileName) {
        this.productImageFileName = productImageFileName;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAdditional_details() {
        return additional_details;
    }

    public void setAdditional_details(String additional_details) {
        this.additional_details = additional_details;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }
}
