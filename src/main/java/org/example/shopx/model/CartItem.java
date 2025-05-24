package org.example.shopx.model;

import org.example.shopx.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartItem {
    private String name;
    private int quantity;
    private double price;
    private int userId;
    private int productId;

    public CartItem(String name, int quantity, double price, int userId, int productId) {
        this.name = name;
        this.quantity = quantity;
        this.price = price;
        this.userId = userId;
        this.productId = productId;
    }

    // Getters and Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public double getSubtotal() {
        return price * quantity;
    }

    // Inside CartItem.java
    public static ArrayList<CartItem> getCartItemsForUser(String username) throws SQLException {
        ArrayList<CartItem> cartItems = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT c.quantity, c.price, c.product_id, p.name, u.id AS user_id FROM cart c " +
                    "JOIN products p ON c.product_id = p.product_id " +
                    "JOIN users u ON c.user_id = u.id " +
                    "WHERE u.username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        String name = rs.getString("name");
                        int quantity = rs.getInt("quantity");
                        double price = rs.getDouble("price");
                        int userId = rs.getInt("user_id");
                        int productId = rs.getInt("product_id");

                        cartItems.add(new CartItem(name, quantity, price, userId, productId));
                    }
                }
            }
        }

        return cartItems;
    }


    // Method to add cart item to the database and update session cart
    public static void addToCart(List<CartItem> cart, int productId, int userId) throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false); // ✅ Disable auto-commit before starting manual transaction

            try {
                // Check if the product already exists in the cart for the user
                String checkQuery = "SELECT * FROM cart WHERE user_id = ? AND product_id = ?";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                    checkStmt.setInt(1, userId);
                    checkStmt.setInt(2, productId);
                    try (ResultSet rs = checkStmt.executeQuery()) {
                        if (rs.next()) {
                            // Update quantity
                            String updateQuery = "UPDATE cart SET quantity = quantity + 1 WHERE user_id = ? AND product_id = ?";
                            try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                                updateStmt.setInt(1, userId);
                                updateStmt.setInt(2, productId);
                                updateStmt.executeUpdate();
                            }
                        } else {
                            // Insert new record
                            String insertQuery = "INSERT INTO cart (user_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
                            try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                                insertStmt.setInt(1, userId);
                                insertStmt.setInt(2, productId);
                                insertStmt.setInt(3, 1);  // Initial quantity is 1
                                double price = getProductPrice(conn, productId);
                                insertStmt.setDouble(4, price);
                                insertStmt.executeUpdate();
                            }
                        }
                    }
                }

                // 🔻 Reduce stock
                String stockUpdateQuery = "UPDATE products SET stock = stock - 1 WHERE product_id = ? AND stock > 0";
                try (PreparedStatement stockStmt = conn.prepareStatement(stockUpdateQuery)) {
                    stockStmt.setInt(1, productId);
                    int affectedRows = stockStmt.executeUpdate();
                    if (affectedRows == 0) {
                        throw new SQLException("Stock not updated — possible out of stock.");
                    }
                }

                conn.commit(); // ✅ Commit the transaction
                CartItem newItem = getCartItemFromProduct(conn, productId, userId);
                if (newItem != null) {
                    cart.add(newItem);
                }

            } catch (SQLException e) {
                conn.rollback(); // 🔁 Roll back if any error occurs
                throw e;
            } finally {
                conn.setAutoCommit(true); // ✅ Always re-enable auto-commit after you're done
            }
        }
    }



    // Helper method to retrieve product price from the products table
    private static double getProductPrice(Connection conn, int productId) throws SQLException {
        String query = "SELECT price FROM products WHERE product_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("price");
                }
            }
        }
        return 0.0; // Return 0 if product not found, but this should not happen if the product exists.
    }


    // Helper method to retrieve a CartItem from the product table
    private static CartItem getCartItemFromProduct(Connection conn, int productId, int userId) throws SQLException {
        String query = "SELECT * FROM products WHERE product_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String name = rs.getString("name");
                    double price = rs.getDouble("price");
                    // Use the setter methods to set values
                    CartItem cartItem = new CartItem(name, 1, price, userId, productId);
                    return cartItem;
                }
            }
        }
        return null;
    }
}