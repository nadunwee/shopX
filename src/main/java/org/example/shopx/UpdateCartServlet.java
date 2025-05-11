package org.example.shopx;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.shopx.model.CartItem;
import org.example.shopx.DBConnection;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        String action = request.getParameter("action");
        Integer userId = (Integer) session.getAttribute("userID"); // Get userId from session

        if ("add".equals(action)) {
            // Add to cart action
            String productIdParam = request.getParameter("product_id");

            if (productIdParam != null) {
                int productId = Integer.parseInt(productIdParam);

                try {
                    // Use CartItem's addToCart method to handle adding to the cart
                    CartItem.addToCart(cart, productId, userId);

                    // Save the updated cart to the session
                    session.setAttribute("cart", cart);

                } catch (SQLException e) {
                    throw new ServletException("Error adding to cart", e);
                }
            }
        } else if ("increase".equals(action) || "decrease".equals(action) || "delete".equals(action)) {
            // Update cart (increase, decrease, delete)
            String itemName = request.getParameter("itemName");

            for (int i = 0; i < cart.size(); i++) {
                CartItem item = cart.get(i);
                if (item.getName().equals(itemName)) {
                    switch (action) {
                        case "increase":
                            try (Connection conn = DBConnection.getConnection()) {
                                conn.setAutoCommit(false);

                                String updateCart = "UPDATE cart SET quantity = quantity + 1 WHERE user_id = ? AND product_id = (SELECT product_id FROM products WHERE name = ?)";
                                try (PreparedStatement stmt = conn.prepareStatement(updateCart)) {
                                    stmt.setInt(1, userId);
                                    stmt.setString(2, itemName);
                                    int rows = stmt.executeUpdate();
                                    if (rows == 0) {
                                        throw new SQLException("Failed to update cart");
                                    }
                                }

                                String checkStock = "SELECT stock FROM products WHERE name = ?";
                                try (PreparedStatement stockStmt = conn.prepareStatement(checkStock)) {
                                    stockStmt.setString(1, itemName);
                                    try (ResultSet rs = stockStmt.executeQuery()) {
                                        if (rs.next() && rs.getInt("stock") <= 0) {
                                            throw new SQLException("No more stock available for " + itemName);
                                        }
                                    }
                                }


                                // Decrease stock
                                String updateStock = "UPDATE products SET stock = stock - 1 WHERE product_id = (SELECT product_id FROM products WHERE name = ?) AND stock > 0";
                                try (PreparedStatement stmt = conn.prepareStatement(updateStock)) {
                                    stmt.setString(1, itemName);
                                    int rows = stmt.executeUpdate();
                                    if (rows == 0) {
                                        throw new SQLException("Out of stock");
                                    }
                                }

                                conn.commit();
                                item.setQuantity(item.getQuantity() + 1); // session cart

                            } catch (SQLException e) {
                                throw new ServletException("Increase quantity failed", e);
                            }
                            break;

                        case "decrease":
                            if (item.getQuantity() > 1) {
                                try (Connection conn = DBConnection.getConnection()) {
                                    conn.setAutoCommit(false);

                                    String updateCart = "UPDATE cart SET quantity = quantity - 1 WHERE user_id = ? AND product_id = (SELECT product_id FROM products WHERE name = ?)";
                                    try (PreparedStatement stmt = conn.prepareStatement(updateCart)) {
                                        stmt.setInt(1, userId);
                                        stmt.setString(2, itemName);
                                        stmt.executeUpdate();
                                    }

                                    // Increase stock back
                                    String updateStock = "UPDATE products SET stock = stock + 1 WHERE product_id = (SELECT product_id FROM products WHERE name = ?)";
                                    try (PreparedStatement stmt = conn.prepareStatement(updateStock)) {
                                        stmt.setString(1, itemName);
                                        stmt.executeUpdate();
                                    }

                                    conn.commit();
                                    item.setQuantity(item.getQuantity() - 1); // session cart

                                } catch (SQLException e) {
                                    throw new ServletException("Decrease quantity failed", e);
                                }
                            }
                            break;
                        case "delete":
                            try (Connection conn = DBConnection.getConnection()) {
                                conn.setAutoCommit(false);

                                try {
                                    // First, find the quantity and product_id for this item
                                    String fetchQuery = "SELECT product_id, quantity FROM cart WHERE user_id = ? AND product_id = (SELECT product_id FROM products WHERE name = ?)";
                                    int productId = -1;
                                    int quantity = 0;

                                    try (PreparedStatement stmt = conn.prepareStatement(fetchQuery)) {
                                        stmt.setInt(1, userId);
                                        stmt.setString(2, itemName);
                                        try (ResultSet rs = stmt.executeQuery()) {
                                            if (rs.next()) {
                                                productId = rs.getInt("product_id");
                                                quantity = rs.getInt("quantity");
                                            }
                                        }
                                    }

                                    if (productId != -1) {
                                        // Delete from cart
                                        String deleteQuery = "DELETE FROM cart WHERE user_id = ? AND product_id = ?";
                                        try (PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {
                                            deleteStmt.setInt(1, userId);
                                            deleteStmt.setInt(2, productId);
                                            deleteStmt.executeUpdate();
                                        }

                                        // Restore stock
                                        String stockUpdate = "UPDATE products SET stock = stock + ? WHERE product_id = ?";
                                        try (PreparedStatement stockStmt = conn.prepareStatement(stockUpdate)) {
                                            stockStmt.setInt(1, quantity);
                                            stockStmt.setInt(2, productId);
                                            stockStmt.executeUpdate();
                                        }

                                        conn.commit();
                                    }
                                } catch (SQLException e) {
                                    conn.rollback();
                                    throw new ServletException("Failed to delete item and restore stock", e);
                                } finally {
                                    conn.setAutoCommit(true);
                                }

                                // Remove from session cart
                                for (int j = 0; j < cart.size(); j++) {
                                    if (cart.get(j).getName().equals(itemName)) {
                                        cart.remove(j);
                                        break;
                                    }
                                }
                            } catch (SQLException e) {
                                throw new ServletException("DB error during item delete", e);
                            }
                            break;
                    }
                    break;
                }
            }

            // Save the updated cart to the session
            session.setAttribute("cart", cart);
        }

        // Redirect back to the cart page to display the updated cart
        response.sendRedirect("Cart/cart.jsp");
    }
}
