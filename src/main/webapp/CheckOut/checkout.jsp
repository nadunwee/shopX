<%--
  Created by IntelliJ IDEA.
  User: Ryzen
  Date: 5/3/2025
  Time: 11:24 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="org.example.shopx.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Checkout | ShopX</title>
    <link rel="stylesheet" type="text/css" href="../style.css">
    <link rel="stylesheet" type="text/css" href="checkoutcss.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

</head>
<body>
<%@include file="../includes/navBar.jsp" %>

<div class="checkout-container">

    <!-- 🛒 CART ITEMS -->
    <div class="cart-section">
        <h2>Your Cart</h2>
        <!-- Placeholder items, cart logic not implemented yet -->
        <p><em>Note: Cart functionality is not yet implemented.</em></p>

        <div class="cart-item">
            <strong>Sample Product A</strong>
            <p>Qty: 1</p>
            <p>Price: Rs. 1500</p>
        </div>

        <div class="cart-item">
            <strong>Sample Product B</strong>
            <p>Qty: 2</p>
            <p>Price: Rs. 900</p>
        </div>
    </div>

    <!-- 🏠 DELIVERY ADDRESS -->
    <div class="address-section">
        <h2>Delivery Address</h2>
        <p><strong>Name:</strong> Jane Doe</p>
        <p><strong>Address:</strong> 456 Park Road, Kandy, Sri Lanka</p>
        <p><strong>Phone:</strong> +94 76 987 6543</p>

        <button class="change-address-btn" onclick="window.location.href='manageAddresses.jsp'">
            Change / Add Address
        </button>
    </div>

    <!-- 💳 PAYMENT METHOD -->
    <div class="payment-section">
        <h2>Payment Method</h2>
        <form action="processPayment.jsp" method="POST">
            <label><input type="radio" name="paymentMethod" value="cod" checked> Cash on Delivery</label>
            <label><input type="radio" name="paymentMethod" value="card"> Debit / Credit Card</label>
            <label><input type="radio" name="paymentMethod" value="koko"> Koko (Pay Later)</label>
            <label><input type="radio" name="paymentMethod" value="mintpay"> MintPay (Installments)</label>

            <br>
            <button type="submit" class="proceed-btn">Proceed to Payment</button>
        </form>
    </div>

</div>

</body>
</html>
