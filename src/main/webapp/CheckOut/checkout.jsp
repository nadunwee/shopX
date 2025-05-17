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
<%@ page import="org.example.shopx.model.CartItem" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String usernameSession = (String) session.getAttribute("username");
    String name = "";
    double price=0 ;
    int quantity =0;

    String username = "";
    if (usernameSession != null) {
        try {
            DBConnection DBUtil = null;
            Connection conn = DBUtil.getConnection();
            String sql = "SELECT c.* FROM cart_items c , users u WHERE u.id=c.user_id AND username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, usernameSession);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                name = rs.getString("username");
                price = rs.getDouble("price");
                quantity = rs.getInt("quantity");
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("login.jsp");
    }

%>
<%
    List<Map<String, String>> addresses = new ArrayList<>();
    String fullName = "";
    String street = "";
    String city = "";
    String zip = "";
    if (usernameSession != null) {
        try {
            DBConnection DBUtil = null;
            Connection conn = DBUtil.getConnection();

            String sql = "SELECT d.full_name, d.street, d.city, d.zip " +
                    "FROM delivery_address d " +
                    "JOIN users u ON d.user_id = u.id " +
                    "WHERE u.username = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, usernameSession);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                fullName = rs.getString("full_name");
                street = rs.getString("street");
                city = rs.getString("city");
                zip = rs.getString("zip");
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("login.jsp");
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

<div class="checkout-container" >
    <h2>Your Cart</h2>
        <%double total=0;%>
        <c:forEach var="item" >
            <div class="cart-item-card">
                <div class="item-info">
                    <h3 class="item-name"><%=name%></h3>
                    <p class="item-price">Price: Rs. <%=price%></p>
                    <p class="item-quantity">Quantity:<%=quantity%></p>
                    <%total+=quantity*price;%>
                </div>
            </div>
        </c:forEach>
    <p class="item-total">Total: Rs. <%=total%></p>


    <h2>Select Delivery Address</h2>
    <c:forEach var="addr" >
        <input type="radio" name="addressId" value="<%=fullName%>" required />
        <%=street%>, <%=city%>, <%=zip%><br/>
    </c:forEach>

        <!-- Outside the main checkout form -->
    <form action="${pageContext.request.contextPath}/addAddress" method="post">
        <input type="text" name="fullName" placeholder="Full Name" required>
        <input type="text" name="street" placeholder="Street" required>
        <input type="text" name="city" placeholder="City" required>
        <input type="text" name="zip" placeholder="ZIP Code" required>
        <input type="submit" value="Add Address">
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
    <a href="orderConfirmation.jsp" class="confirm-btn"><button class="confirm-btn" type="submit"><i class='bx bx-credit-card'></i>Finalize Checkout</button> </a>
</div>
</body>
</html>
