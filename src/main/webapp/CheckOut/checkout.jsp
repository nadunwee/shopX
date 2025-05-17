<%--
  Created by IntelliJ IDEA.
  User: Ryzen
  Date: 5/3/2025
  Time: 11:24 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="org.example.shopx.DBConnection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    DBConnection DBUtil = null;
    Connection conn = null;
    try {
        conn = DBConnection.getConnection();
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
    String sql = "SELECT * FROM products";
    PreparedStatement stmt = null;
    try {
        stmt = conn.prepareStatement(sql);
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
    try {
        ResultSet rs = stmt.executeQuery();
    } catch (SQLException e) {
        throw new RuntimeException(e);
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
    <h2>Your Cart</h2>
    <table>
        <tr><th>Item</th><th>Price</th><th>Quantity</th><th>Total</th></tr>
        <c:forEach var="item" items="${cartItems}">
            <tr>
                <td>${item.name}</td>
                <td>${item.price}</td>
                <td>${item.quantity}</td>
                <td>${item.total}</td>
            </tr>
        </c:forEach>
    </table>


    <h2>Select Delivery Address</h2>
    <form action="processCheckout" method="post">
        <c:forEach var="addr" items="${addresses}">
            <input type="radio" name="addressId" value="${addr.id}" required />
            ${addr.line1}, ${addr.city}, ${addr.zip}<br/>
        </c:forEach>

        <form action="addAddress" method="post">
            <!-- address input fields -->
            <input type="text" name="street" />
            <input type="text" name="city" />
            <input type="submit" value="Add Address" />
        </form>

        <h3>Payment Method</h3>
        <input type="radio" name="paymentMethod" value="COD" required /> Cash on Delivery<br/>
        <input type="radio" name="paymentMethod" value="CARD" /> Card<br/>

        <input type="submit" value="Place Order" />
    </form>

    <script>
        function togglePaymentDetails() {
            var selected = document.querySelector('input[name="paymentMethod"]:checked').value;
            document.getElementById('cardFields').style.display = (selected === 'CARD') ? 'block' : 'none';
        }
    </script>

    <input type="radio" name="paymentMethod" value="COD" onclick="togglePaymentDetails()"> Cash on Delivery<br>
    <input type="radio" name="paymentMethod" value="CARD" onclick="togglePaymentDetails()"> Credit/Debit Card<br>
    <input type="radio" name="paymentMethod" value="THIRD_PARTY" onclick="togglePaymentDetails()"> Pay via Gateway<br>

    <div id="cardFields" style="display: none;">
        Card Number: <input type="text" name="cardNumber"><br>
        Expiry: <input type="text" name="expiry"><br>
        CVV: <input type="password" name="cvv"><br>
    </div>
</div>
</body>
</html>
