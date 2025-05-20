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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        String action = request.getParameter("action");
        int userId = (int) session.getAttribute("userID");
        String username = (String) session.getAttribute("username");

//        int userId = 0;

//        try (Connection conn = DBConnection.getConnection()) {
//            conn.setAutoCommit(false);
//
//            String sql = "SELECT id FROM users WHERE username = ?";
//            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
//                stmt.setString(1, username);
//                ResultSet rs = stmt.executeQuery();
//                if (rs.next()) {
//                    userId = rs.getInt("id");
//                }
//            }
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }

        System.out.println(username);
//        System.out.println(userId);


        if ("add".equals(action)) {
            String productIdParam = request.getParameter("product_id");
            if (productIdParam != null) {
                int productId = Integer.parseInt(productIdParam);
                try {
                    CartItem.addToCart(cart, productId, userId);
                    session.setAttribute("cart", cart);
                } catch (SQLException e) {
                    throw new ServletException("Error adding to cart", e);
                }
            }
        } else if ("increase".equals(action) || "decrease".equals(action) || "delete".equals(action)) {
            String itemName = request.getParameter("itemName");

            for (int i = 0; i < cart.size(); i++) {
                CartItem item = cart.get(i);
                if (item.getName().equals(itemName)) {
                    switch (action) {
                        case "increase":
                            try (Connection conn = DBConnection.getConnection()) {
                                conn.setAutoCommit(false);

                                // Check current stock
                                String checkStock = "SELECT stock FROM products WHERE name = ?";
                                int stock = 0;
                                try (PreparedStatement stockStmt = conn.prepareStatement(checkStock)) {
                                    stockStmt.setString(1, itemName);
                                    try (ResultSet rs = stockStmt.executeQuery()) {
                                        if (rs.next()) {
                                            stock = rs.getInt("stock");
                                        }
                                    }
                                }

                                if (stock <= 0) {
                                    // No stock available
                                    throw new SQLException("No more stock available for " + itemName);
                                }

                                // Increase quantity in cart
                                String updateCart = "UPDATE cart SET quantity = quantity + 1 WHERE user_id = ? AND product_id = (SELECT product_id FROM products WHERE name = ?)";

                                try (PreparedStatement stmt = conn.prepareStatement(updateCart)) {
                                    stmt.setInt(1, userId);  // instead of stmt.setString(1, username);
                                    stmt.setString(2, itemName);

                                    stmt.executeUpdate();
                                }

                                // Reduce stock by 1
                                String updateStock = "UPDATE products SET stock = stock - 1 WHERE product_id = (SELECT product_id FROM products WHERE name = ?)";
                                try (PreparedStatement stmt = conn.prepareStatement(updateStock)) {
                                    stmt.setString(1, itemName);
                                    stmt.executeUpdate();
                                }

                                conn.commit();

                                item.setQuantity(item.getQuantity() + 1);

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

                                    String updateStock = "UPDATE products SET stock = stock + 1 WHERE product_id = (SELECT product_id FROM products WHERE name = ?)";
                                    try (PreparedStatement stmt = conn.prepareStatement(updateStock)) {
                                        stmt.setString(1, itemName);
                                        stmt.executeUpdate();
                                    }

                                    conn.commit();
                                    item.setQuantity(item.getQuantity() - 1);

                                } catch (SQLException e) {
                                    throw new ServletException("Decrease quantity failed", e);
                                }
                            }
                            break;

                        case "delete":
                            try (Connection conn = DBConnection.getConnection()) {
                                conn.setAutoCommit(false);

                                try {
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
                                        String deleteQuery = "DELETE FROM cart WHERE user_id = ? AND product_id = ?";
                                        try (PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {
                                            deleteStmt.setInt(1, userId);
                                            deleteStmt.setInt(2, productId);

                                            deleteStmt.executeUpdate();
                                        }

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
            session.setAttribute("cart", cart);
        }

        response.sendRedirect("Cart/cart.jsp");
    }
}
