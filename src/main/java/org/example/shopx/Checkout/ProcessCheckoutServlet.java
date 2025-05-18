package org.example.shopx.Checkout;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.shopx.DBConnection;
import org.example.shopx.model.CartItem;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;

public class ProcessCheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Assuming a user is logged in and username is stored in session
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        ArrayList<OrderItems> cartItems = getCartItems(username);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        if (cartItems.isEmpty()) {
            out.println("<p>No items found in cart.</p>");
        } else {
            out.println("<h2>Items in your cart:</h2>");
            for (OrderItems item : cartItems) {
                out.println("<p>Product ID: " + item.getProductId() +
                        ", Quantity: " + item.getQuantity() +
                        ", Price: " + item.getPrice() + "</p>");
            }
        }
    }

    private ArrayList<OrderItems> getCartItems(String username) {
        ArrayList<OrderItems> itemList = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM cart_items c JOIN users u ON u.id = c.user_id WHERE u.username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        int orderId = rs.getInt("order_id");
                        int productId = rs.getInt("product_id");
                        int quantity = rs.getInt("quantity");
                        float price = rs.getFloat("price");

                        OrderItems orderItem = new OrderItems(orderId, productId, quantity, price);
                        itemList.add(orderItem);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return itemList;
    }

    private boolean updateQuantity(int userId, int productId, int quantity) {
        try (Connection conn = DBConnection.getConnection()) {
            String query = "UPDATE cart_items SET quantity = ? WHERE user_id = ? AND product_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, quantity);
                stmt.setInt(2, userId);
                stmt.setInt(3, productId);
                return stmt.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
