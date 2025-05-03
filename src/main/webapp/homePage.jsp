<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="org.example.shopx.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>MyShop</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <!-- Boxicons CDN -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>

<%
    DBConnection DBUtil = null;
    Connection conn = DBUtil.getConnection();
    String sql = "SELECT * FROM products";
    PreparedStatement stmt = conn.prepareStatement(sql);
    ResultSet rs = stmt.executeQuery();
%>

<%--include the navbar--%>
<%@ include file="/includes/navBar.jsp" %>

<div class="product-section">
    <h2>Featured Products</h2>
    <div class="product-grid">
        <%
            while (rs.next()) {
                int productId = rs.getInt("product_id"); // Assuming there's a column 'id' in the products table
        %>
        <a href="product.jsp?id=<%= productId %>" class="product-card-link">
            <div class="product-card">
                <div class="product-image">
                    <img src="<%= rs.getString("image") %>" alt="<%= rs.getString("name") %>">
                    <span class="badge">Top Sellers</span>
                </div>
                <div class="product-info">
                    <p class="title"><%= rs.getString("name") %></p>
                    <p class="price">Rs. <%= rs.getBigDecimal("price") %></p>
                </div>
            </div>
        </a>
        <%
            }
            rs.close();
            stmt.close();
            conn.close();
        %>
    </div>

</div>

</body>
</html>
