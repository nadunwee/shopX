<%@ page import="java.sql.*" %>
<%@ page import="org.example.shopx.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product Details</title>
    <link rel="stylesheet" type="text/css" href="product.css">
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

<%@ include file="/includes/navBar.jsp" %>

<%
    String sessionUsername = (String) session.getAttribute("username");
    int productId = Integer.parseInt(request.getParameter("id"));
    Connection conn = DBConnection.getConnection();
    String sql = "SELECT * FROM products WHERE product_id = ?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setInt(1, productId);
    ResultSet rs = stmt.executeQuery();

    if (rs.next()) {
%>

<div class="product-full-width">
    <div class="product-image-section">
        <img src="<%= rs.getString("image") %>" alt="<%= rs.getString("name") %>" class="main-product-image">
    </div>

    <div class="product-details-section">
        <div class="vendor-store-name">shopX partner : <%= rs.getString("vendor") %></div>
        <p class="product-name"><%= rs.getString("name") %></p>
        <div class="price-tag">Rs. <%= rs.getBigDecimal("price") %></div>
        <div class="availability"><%= rs.getString("stock") %></div>

        <div class="btn-wrapper" style="margin-top: 10px">
            <% if (sessionUsername != null) { %>
            <a href="cart.jsp?add=<%= rs.getInt("product_id") %>" class="add-to-cart-btn">🛒 Add to Cart</a>
            <% } else { %>
            <a href="accessPages/login.jsp" class="add-to-cart-btn">🛒 Add to Cart</a>
            <% } %>
        </div>


        <ul class="highlights" style="margin-top: 30px">
            <%
                String additionalDetails = rs.getString("additional_details");
                if (additionalDetails != null && !additionalDetails.trim().isEmpty()) {
                    String[] highlights = additionalDetails.split("\\r?\\n");
                    for (String highlight : highlights) {
            %>
            <li>✔️ <%= highlight.trim() %></li>
            <%
                }
            } else {
            %>
            <li>✔️ No additional highlights available</li>
            <%
                }
            %>
        </ul>

        <p class="category-heading">Belongs to shopping categories of:</p>
        <div class="category-tags">
            <span class="tag"><%= rs.getString("category") %></span>
        </div>
    </div>
</div>

<%
    }
    rs.close();
    stmt.close();
    conn.close();
%>

</body>
</html>
