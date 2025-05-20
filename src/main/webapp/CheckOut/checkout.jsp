<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="org.example.shopx.DBConnection" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="org.example.shopx.Checkout.AddressModel" %>
<%@ page import="org.example.shopx.model.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String usernameSession = (String) session.getAttribute("username");
    List<AddressModel> savedAddresses = new ArrayList<>();
    AddressModel UpdateAddress = (AddressModel) request.getAttribute("address");
    if (usernameSession != null) {
        try {
            DBConnection DBUtil = null;
            Connection conn = DBUtil.getConnection();

            String sql = "SELECT da.address_id, da.full_name, da.street, da.city, da.zip\n " +
                    "FROM delivery_address da " +
                    "INNER JOIN users u ON u.id = da.user_id " +
                    "WHERE u.username = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, usernameSession);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                AddressModel address = new AddressModel();
                address.setAddressId(rs.getInt("address_id"));
                address.setFullname(rs.getString("full_name"));
                address.setStreet(rs.getString("street"));
                address.setCity(rs.getString("city"));
                address.setZip(rs.getInt("zip"));
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
    <link rel="stylesheet" type="text/css" href="../style.css">
    <link rel="stylesheet" type="text/css" href="checkout.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
<%@include file="../includes/navBar.jsp" %>

<div class="checkout-container">

    <h2 class="section-title">Your Cart</h2>
    <% double total = 0; %>
    <div class="cart-item-card">
        <div class="item-info">
            <h3 class="item-name"><%= CartItem.getName() %></h3>
            <p class="item-price">Price: Rs. <%= CartItem.getPrice() %></p>
            <p class="item-quantity">Quantity: <%= CartItem.getQuantity() %></p>
            <% total += CartItem.getPrice() * CartItem.getQuantity(); %>
        </div>
    </div>
    <p class="item-total section-title">Total: Rs. <%= total %></p>

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
        <% if (!savedAddresses.isEmpty()) { %>
        <% for (AddressModel addr : savedAddresses) { %>
        <tr>
            <td><input type="radio" name="addressId" value="<%= addr.getAddressId() %>" required></td>
            <td><%= addr.getFullname() %></td>
            <td><%= addr.getStreet() %></td>
            <td><%= addr.getCity() %></td>
            <td><%= addr.getZip() %></td>
            <td>
                <form action="${pageContext.request.contextPath}/editAddressForm" method="post" style="display:inline;">
                    <input type="hidden" name="addressId" value="<%= addr.getAddressId() %>">
                    <button type="submit" class="btn-edge">Edit</button>
                </form>

                <form action="${pageContext.request.contextPath}/deleteAddress" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this address?');">
                    <input type="hidden" name="addressId" value="<%= addr.getAddressId() %>">
                    <button type="submit" class="btn-edge" style="background-color: #d9534f;">Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
        <% } else { %>
        <tr>
            <td colspan="5">Please log in to view your saved addresses.</td>
        </tr>
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
    <h2 class="section-title">Select Payment Method</h2>
    <div class="section-box">
        <form action="" method="post">
            <div class="payment-methods">
                <label><input type="radio" name="paymentMethod" value="COD" onclick="togglePaymentDetails()"> Cash on Delivery</label><br>
                <label><input type="radio" name="paymentMethod" value="CARD" onclick="togglePaymentDetails()"> Credit/Debit Card</label><br>
                <label><input type="radio" name="paymentMethod" value="THIRD_PARTY" onclick="togglePaymentDetails()"> Pay via Gateway</label>
            </div>

            <div id="cardFields" class="card-fields">
                <input type="text" name="cardNumber" placeholder="Card Number">
                <input type="text" name="expiry" placeholder="Expiry">
                <input type="password" name="cvv" placeholder="CVV">
            </div>

            <a href="orderConfirmation.jsp"><button type="submit" class="confirm-btn edgy-btn"><i class='bx bx-credit-card'></i> Finalize Checkout</button></a>
        </form>
    </div>
</div>

<script>
    function togglePaymentDetails() {
        const selected = document.querySelector('input[name="paymentMethod"]:checked').value;
        const cardFields = document.getElementById('cardFields');
        cardFields.style.display = (selected === 'CARD') ? 'block' : 'none';
    }
</script>

</body>
</html>