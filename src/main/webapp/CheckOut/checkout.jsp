<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="org.example.shopx.DBConnection" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.example.shopx.Checkout.AddressModel" %>
<%@ page import="org.example.shopx.model.CartItem" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String usernameSession = (String) session.getAttribute("username");
    List<AddressModel> savedAddresses = new ArrayList<>();
    if (usernameSession != null) {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT da.id, da.full_name, da.street, da.city, da.zip " +
                    "FROM delivery_address da " +
                    "INNER JOIN users u ON u.id = da.user_id " +
                    "WHERE u.username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, usernameSession);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int addressId = rs.getInt("id");
                String fullName = rs.getString("full_name");
                String street = rs.getString("street");
                String city = rs.getString("city");
                int zip = rs.getInt("zip");
                AddressModel address = new AddressModel(addressId, fullName, street, city, zip); // Make sure constructor exists
                savedAddresses.add(address);
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Checkout | ShopX</title>
    <link rel="stylesheet" href="../style.css">
    <link rel="stylesheet" href="checkout.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
<%@ include file="/includes/navBar.jsp" %>

<div class="checkout-container">
    <h2 class="section-title">Your Cart</h2>

    <%
        String username = (String) session.getAttribute("username");
        ArrayList<CartItem> cartDetails = null;
        try {
            cartDetails = CartItem.getCartItemsForUser(username);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        CartItem cartInfo = null;
        if (cartDetails != null && !cartDetails.isEmpty()) {
            cartInfo = cartDetails.get(0);
        }
    %>

    <% double total = 0;
        if (cartInfo != null) { %>
    <div class="cart-item-card">
        <div class="item-info">
            <h3 class="item-name"><%= cartInfo.getName() %></h3>
            <p class="item-price">Price: Rs. <%= cartInfo.getPrice() %></p>
            <p class="item-quantity">Quantity: <%= cartInfo.getQuantity() %></p>
            <% total += cartInfo.getPrice() * cartInfo.getQuantity(); %>
        </div>
    </div>
    <p class="item-total section-title">Total: Rs. <%= total %></p>
    <% } %>

    <h2 class="section-title">Select Delivery Address</h2>

    <table border="1" cellpadding="8" cellspacing="0" style="width: 100%; border-collapse: collapse; margin-top: 10px;">
        <thead>
        <tr>
            <th>Select</th>
            <th>Full Name</th>
            <th>Street</th>
            <th>City</th>
            <th>ZIP Code</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (!savedAddresses.isEmpty()) {
            for (AddressModel addr : savedAddresses) { %>
        <tr>
            <td><input type="radio" name="addressId" value="<%= addr.getAddressId() %>" required></td>
            <td><%= addr.getFullname() %></td>
            <td><%= addr.getStreet() %></td>
            <td><%= addr.getCity() %></td>
            <td><%= addr.getZip() %></td>
            <td>
                <!-- Edit Form Trigger -->
                <button type="button" onclick="toggleEditForm(<%= addr.getAddressId() %>)">Edit</button>

                <!-- Hidden Edit Form -->
                <div id="editForm-<%= addr.getAddressId() %>" style="display: none;">
                    <form action="${pageContext.request.contextPath}/updateAddress" method="post">
                        <input type="hidden" name="addressId" value="<%= addr.getAddressId() %>">
                        <input type="text" name="fullName" value="<%= addr.getFullname() %>" required>
                        <input type="text" name="street" value="<%= addr.getStreet() %>" required>
                        <input type="text" name="city" value="<%= addr.getCity() %>" required>
                        <input type="text" name="zip" value="<%= addr.getZip() %>" required>
                        <input type="submit" value="Update Address">
                    </form>
                </div>

                <!-- Delete Form -->
                <form id="deleteForm-<%= addr.getAddressId() %>" action="deleteAddress" method="post" style="display:inline;">
                    <input type="hidden" name="addressId" value="<%= addr.getAddressId() %>">
                    <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete this address?')">Delete</button>
                </form>
            </td>
        </tr>
        <%   }
        } else { %>
        <tr><td colspan="6">Please log in to view your saved addresses.</td></tr>
        <% } %>
        </tbody>
    </table>

    <h2 class="section-title">Add New Delivery Address</h2>
    <div class="input-card">
        <form action="${pageContext.request.contextPath}/addAddress" method="post" class="input-group">
            <input type="text" name="fullName" placeholder="Full Name" required>
            <input type="text" name="street" placeholder="Street" required>
            <input type="text" name="city" placeholder="City" required>
            <input type="text" name="zip" placeholder="ZIP Code" required>
            <input type="submit" class="btn-edge" value="Add Address">
        </form>
    </div>
</div>

<script>
    function confirmDelete(addressId) {
        if (confirm("Are you sure you want to delete this address?")) {
            document.getElementById("deleteForm-" + addressId).submit();
        }
    }

    function toggleEditForm(addressId) {
        const form = document.getElementById("editForm-" + addressId);
        form.style.display = form.style.display === "none" ? "block" : "none";
    }
</script>

</body>
</html>
