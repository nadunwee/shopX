<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.shopx.DBConnection" %>
<%@ page import="java.sql.*" %>
<%
  String usernameSession = (String) session.getAttribute("username");
  if (usernameSession == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  // Sample cart items list (replace with actual DB query)
  class CartItem {
    String name;
    int quantity;
    double price;
    CartItem(String name, int quantity, double price) {
      this.name = name;
      this.quantity = quantity;
      this.price = price;
    }
  }

  java.util.List<CartItem> cartItems = new java.util.ArrayList<>();
  cartItems.add(new CartItem("Wireless Mouse", 2, 1500.00));
  cartItems.add(new CartItem("USB-C Charger", 1, 2200.00));

  double total = 0;
  for (CartItem item : cartItems) {
    total += item.quantity * item.price;
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Shopping Cart - MyShop</title>
  <link rel="stylesheet" href=".././style.css">
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #f5f5f5;
    }

    .cart-container {
      padding: 40px;
      max-width: 1000px;
      margin: auto;
    }

    .cart-header {
      color: #4b1e83;
      border-left: 5px solid #ffdd00;
      padding-left: 15px;
      margin-bottom: 30px;
      font-size: 28px;
    }

    .cart-table {
      width: 100%;
      border-collapse: collapse;
      background: white;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      overflow: hidden;
    }

    .cart-table th, .cart-table td {
      padding: 18px;
      text-align: left;
      border-bottom: 1px solid #f0f0f0;
    }

    .cart-table th {
      background-color: #f9f9f9;
      color: #4b1e83;
      font-weight: 600;
    }

    .cart-table td:last-child {
      text-align: right;
    }

    .cart-total {
      text-align: right;
      margin-top: 20px;
      font-size: 20px;
      color: #4b1e83;
    }

    .checkout-btn {
      display: block;
      background-color: #ffdd00;
      color: #333;
      text-align: center;
      font-size: 16px;
      font-weight: bold;
      padding: 12px 0;
      margin-top: 30px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s;
      width: 100%;
      max-width: 300px;
      margin-left: auto;
    }

    .checkout-btn:hover {
      background-color: #ffbd2d;
    }
  </style>
</head>
<body>

<%@ include file="/includes/navBar.jsp" %>

<div class="cart-container">
  <div class="cart-header">My Cart</div>

  <table class="cart-table">
    <thead>
    <tr>
      <th>Product</th>
      <th>Qty</th>
      <th>Price (Rs.)</th>
      <th>Subtotal (Rs.)</th>
    </tr>
    </thead>
    <tbody>
    <% for (CartItem item : cartItems) { %>
    <tr>
      <td><%= item.name %></td>
      <td>
        <form action="UpdateCartServlet" method="post" style="display:flex; align-items:center; gap:8px;">
          <input type="hidden" name="itemName" value="<%= item.name %>">
          <button type="submit" name="action" value="decrease" style="padding:4px 10px;">−</button>
          <span><%= item.quantity %></span>
          <button type="submit" name="action" value="increase" style="padding:4px 10px;">+</button>
        </form>
      </td>
      <td>Rs. <%= String.format("%.2f", item.price) %></td>
      <td style="text-align:right;">Rs. <%= String.format("%.2f", item.quantity * item.price) %></td>
      <td style="text-align:right;">
        <form action="UpdateCartServlet" method="post">
          <input type="hidden" name="itemName" value="<%= item.name %>">
          <button type="submit" name="action" value="delete" style="background:transparent; border:none; cursor:pointer; color:red;">
            <i class='bx bx-trash'></i>
          </button>
        </form>
      </td>
    </tr>
    <% } %>
    </tbody>

  </table>

  <div class="cart-total">
    <strong>Total: Rs. <%= String.format("%.2f", total) %></strong>
  </div>

  <form action="CheckoutServlet" method="post">
    <button class="checkout-btn" type="submit"><i class='bx bx-credit-card'></i> Proceed to Checkout</button>
  </form>
</div>

</body>
</html>
