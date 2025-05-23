<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 5/17/2025
  Time: 12:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.*, java.sql.*, org.example.shopx.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    String usernameSession = (String) session.getAttribute("username");
    if (usernameSession == null) {
        response.sendRedirect("checkout.jsp");
        return;
    }

    int orderId = 0;
    try {
        orderId = Integer.parseInt(request.getParameter("orderId"));
    } catch (Exception e) {
        response.sendRedirect("checkout.jsp");
        return;
    }
    Map<String, Object> orderDetails = new HashMap<>();
    List<Map<String, Object>> orderItems = new ArrayList<>();
    Map<String, String> deliveryAddress = new HashMap<>();

    try (Connection conn = DBConnection.getConnection()) {
        // Get order info
        PreparedStatement orderStmt = conn.prepareStatement(
                "SELECT * FROM orders WHERE id = ? AND user_id = ?");
        orderStmt.setInt(1, orderId);
        ResultSet rsOrder = orderStmt.executeQuery();

        if (rsOrder.next()) {
            orderDetails.put("date", rsOrder.getDate("order_date"));
            orderDetails.put("total", rsOrder.getDouble("total_amount"));
            int addressId = rsOrder.getInt("address_id");

            // Get delivery address
            PreparedStatement addrStmt = conn.prepareStatement(
                    "SELECT o.*, da.full_name ,da.street, da.city, da.zip FROM orders o " +
                            "JOIN delivery_address da ON o.delivery_address_id = da.id " +
                            "WHERE o.user_id = ? ORDER BY o.created_at DESC LIMIT 1"
            );

            addrStmt.setInt(1, addressId);
            ResultSet rsAddr = addrStmt.executeQuery();
            if (rsAddr.next()) {
                deliveryAddress.put("fullName", rsAddr.getString("full_name"));
                deliveryAddress.put("street", rsAddr.getString("street"));
                deliveryAddress.put("city", rsAddr.getString("city"));
                deliveryAddress.put("zip", rsAddr.getString("zip"));
            }
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 2rem; }
        .confirmation-box { border: 1px solid #ccc; padding: 1.5rem; border-radius: 10px; background-color: #f9f9f9; }
        .confirmation-box h2 { color: green; }
        .order-details, .address-details { margin-top: 1rem; }
        .buttons { margin-top: 2rem; }
        .buttons form { display: inline; }
    </style>
</head>
<body>

<div class="confirmation-box">
    <h2>🎉 Order Placed Successfully!</h2>
    <p>Thank you for your purchase. Your order has been confirmed.</p>

    <div class="order-details">
        <h3>Order Details</h3>
        <p><strong>Order ID:</strong> <%= orderId %></p>
        <p><strong>Order Date:</strong> <%= orderDetails.get("date") %></p>
        <p><strong>Total Amount:</strong> Rs. <%= orderDetails.get("total") %></p>

        <h4>Items:</h4>
        <ul>
            <% for (Map<String, Object> item : orderItems) { %>
            <li>
                <%= item.get("name") %> × <%= item.get("quantity") %> - Rs. <%= item.get("price") %>
            </li>
            <% } %>
        </ul>
    </div>

    <div class="address-details">
        <h3>Delivery Address</h3>
        <p>
            <%= deliveryAddress.get("fullName") %><br>
            <%= deliveryAddress.get("street") %>, <%= deliveryAddress.get("city") %><br>
            ZIP: <%= deliveryAddress.get("zip") %>
        </p>
    </div>

    <div class="buttons">
        <!-- Cancel order -->
        <form action="cancelOrder" method="post">
            <input type="hidden" name="orderId" value="<%= orderId %>">
            <button type="submit" style="background:red;color:white;padding:10px;border:none;border-radius:5px;">Cancel Order</button>
        </form>

        <!-- Repurchase -->
        <form action="repurchase" method="post">
            <input type="hidden" name="orderId" value="<%= orderId %>">
            <button type="submit" style="background:green;color:white;padding:10px;border:none;border-radius:5px;">Repurchase</button>
        </form>
    </div>
</div>

</body>
</html>
