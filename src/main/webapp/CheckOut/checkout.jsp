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

    String sql = "SELECT * FROM users where username = ?";

    try(Connection conn = DBConnection.getConnection()){
        try(PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setString(1, usernameSession);
        }
    }

    ArrayList<AddressModel> savedAddresses = new ArrayList<>();
    if (usernameSession != null) {
        try {
            DBConnection DBUtil = null;
            Connection conn = DBUtil.getConnection();

            String sql = "SELECT da.id, da.full_name, da.street, da.city, da.zip " +
                    "FROM delivery_address da " +
                    "INNER JOIN users u ON u.id = da.user_id " +
                    "WHERE u.username = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, usernameSession);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int product_id = rs.getInt("id");
                String fullName = rs.getString("full_name");
                String street = rs.getString("street");
                String city = rs.getString("city");
                int zip = rs.getInt("zip");
                AddressModel AddressData = new AddressModel(product_id, fullName, street, city, zip);
                savedAddresses.add(AddressData);
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    ArrayList<CartItem> cartDetails = new ArrayList<>();
    if (usernameSession != null) {
        try {
            DBConnection DBUtil = null;
            Connection conn = DBUtil.getConnection();

            String sql = "SELECT id, full_name, street, city, zip FROM cart WHERE username = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, usernameSession);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int product_id = rs.getInt("id");
                String userID = rs.getString("user_id");
                String city = rs.getString("quantity");
                int zip = rs.getInt("price");
                AddressModel AddressData = new AddressModel(product_id, fullName, street, city, zip);
                savedAddresses.add(AddressData);
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
<%@ include file="/includes/navBar.jsp" %>

<div class="checkout-container">

    <h2 class="section-title">Your Cart</h2>
    <% System.out.println("Session Username: " + usernameSession); %>

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
                <form action="${pageContext.request.contextPath}/editAddressForm" method="get" style="display:inline;">
                    <input type="hidden" name="addressId" value="<%= addr.getAddressId() %>">
                    <button type="submit">Edit</button>
                </form>
<%--                //delete button--%>
                <form id="deleteForm-<%= addr.getAddressId() %>" action="${pageContext.request.contextPath}/deleteAddress" method="post" style="display:inline;">
                    <input type="hidden" name="addressId" value="<%= addr.getAddressId() %>">
                    <button type="button" class="btn-edge" onclick="confirmDelete(<%= addr.getAddressId() %>)">Delete</button>
                </form>


                <div id="editForm-<%= addr.getAddressId() %>" style="display: none; margin-top: 10px;">

                    <form action="${pageContext.request.contextPath}/updateAddress" method="post">
                        <input type="hidden" name="addressId" value="<%= addr.getAddressId() %>">
                        <input type="text" name="fullName" value="<%= addr.getFullname() %>" required>
                        <input type="text" name="street" value="<%= addr.getStreet() %>" required>
                        <input type="text" name="city" value="<%= addr.getCity() %>" required>
                        <input type="text" name="zip" value="<%= addr.getZip() %>" required>
                        <input type="submit" value="Update Address">
                    </form>
                </div>

            </td>
        </tr>
        <% } %>
        <%
            AddressModel address = (AddressModel) request.getAttribute("address");
        %>
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
        <form action="processCheckout" method="post">
            <div class="payment-methods">
                <label><input type="radio" name="paymentMethod" value="COD" onclick="togglePaymentDetails()"> Cash on Delivery</label><br>
                <label><input type="radio" name="paymentMethod" value="CARD" onclick="togglePaymentDetails()"> Credit/Debit Card</label><br>
                <label><input type="radio" name="paymentMethod" value="THIRD_PARTY" onclick="togglePaymentDetails()"> Pay via Gateway</label>
            </div>

            <div id="cardFields" class="card-fields">
                <input type="text" name="cardNumber" placeholder="Card Number">
                <input type="date" name="expiry" placeholder="Expiry">
                <input type="password" name="cvv" placeholder="CVV">
            </div>

        </form>

        <button type="button" class="confirm-btn edgy-btn" onclick="validateCheckout()">
            <i class='bx bx-credit-card'></i> Finalize Checkout
        </button>
    </div>
</div>
<script>
    function confirmDelete(addressId) {
        const confirmed = confirm("Are you sure you want to delete this address?");
        if (confirmed) {
            document.getElementById(`deleteForm-${addressId}`).submit();
        }
    }
</script>

<script>
    function toggleEditForm(addressId) {
        const form = document.getElementById(`editForm-${addressId}`);
        form.style.display = form.style.display === 'none' ? 'block' : 'none';
    }
</script>

<script>
    function togglePaymentDetails() {
        const selected = document.querySelector('input[name="paymentMethod"]:checked').value;
        const cardFields = document.getElementById('cardFields');
        cardFields.style.display = (selected === 'CARD') ? 'block' : 'none';
    }
</script>
<script>
    function validateCheckout() {
        const addressSelected = document.querySelector('input[name="addressId"]:checked');
        const paymentSelected = document.querySelector('input[name="paymentMethod"]:checked');

        if (!addressSelected) {
            alert("Please select a delivery address.");
            return;
        }

        if (!paymentSelected) {
            alert("Please select a payment method.");
            return;
        }

        // If CARD selected, validate card fields
        if (paymentSelected.value === "CARD") {
            const cardNumber = document.querySelector('input[name="cardNumber"]').value.trim();
            const expiry = document.querySelector('input[name="expiry"]').value.trim();
            const cvv = document.querySelector('input[name="cvv"]').value.trim();

            if (!cardNumber || !expiry || !cvv) {
                alert("Please fill in all card details.");
                return;
            }
        }

        document.getElementById("processCheckout").submit();
    }

    function togglePaymentDetails() {
        const selected = document.querySelector('input[name="paymentMethod"]:checked');
        const cardFields = document.getElementById('cardFields');
        if (selected && selected.value === 'CARD') {
            cardFields.style.display = 'block';
        } else {
            cardFields.style.display = 'none';
        }
    }

    // Attach change event listeners on page load
    window.onload = () => {
        const radios = document.querySelectorAll('input[name="paymentMethod"]');
        radios.forEach(r => r.addEventListener('change', togglePaymentDetails));
    };
</script>


</body>
</html>