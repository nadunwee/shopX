<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 5/20/2025
  Time: 2:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.shopx.Checkout.AddressModel" %>
<%
    AddressModel address = (AddressModel) request.getAttribute("address");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Address</title>
</head>
<body>
<h2>Edit Delivery Address</h2>
<form action="UpdateAddressServlet" method="post">
    <input type="hidden" name="addressId" value="<%= address.getAddressId() %>">
    <label>Full Name:</label>
    <input type="text" name="full_name" value="<%= address.getFullname() %>" required><br>
    <label>Street:</label>
    <input type="text" name="street" value="<%= address.getStreet() %>" required><br>
    <label>City:</label>
    <input type="text" name="city" value="<%= address.getCity() %>" required><br>
    <label>Zip:</label>
    <input type="number" name="zip" value="<%= address.getZip() %>" required><br>
    <button type="submit">Update Address</button>
</form>
</body>
</html>

