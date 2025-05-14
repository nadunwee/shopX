package org.example.shopx.Checkout;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.shopx.Checkout.Address;
import org.example.shopx.model.CartItem;
import org.example.shopx.Checkout.Order;
import org.example.shopx.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/processCheckout")
public class ProcessCheckoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get cart and address details from session or request
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        String addressId = request.getParameter("addressId"); // Could be new or existing
        String paymentMethod = request.getParameter("paymentMethod");

        if (cartItems == null || cartItems.isEmpty()) {
            request.setAttribute("error", "Your cart is empty.");
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Save order summary
            String orderSQL = "INSERT INTO orders (username, address_id, payment_method) VALUES (?, ?, ?)";
            PreparedStatement orderStmt = conn.prepareStatement(orderSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            orderStmt.setString(1, username);
            orderStmt.setString(2, addressId);
            orderStmt.setString(3, paymentMethod);
            orderStmt.executeUpdate();

            var rs = orderStmt.getGeneratedKeys();
            int orderId = -1;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // Save each cart item under the order
            String itemSQL = "INSERT INTO order_items (order_id, product_id, quantity) VALUES (?, ?, ?)";
            PreparedStatement itemStmt = conn.prepareStatement(itemSQL);

            for (CartItem item : cartItems) {
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, item.getProductId());
                itemStmt.setInt(3, item.getQuantity());
                itemStmt.addBatch();
            }

            itemStmt.executeBatch();
            conn.commit();

            // Clear cart
            session.removeAttribute("cartItems");

            // Redirect to confirmation
            response.sendRedirect("checkoutSuccess.jsp");

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            throw new ServletException("Checkout failed", e);
        }
    }
}
