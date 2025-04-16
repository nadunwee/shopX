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

<%--include the navbar--%>
<%@ include file="/includes/navBar.jsp" %>

<div class="product-section">
    <h2>Featured Products</h2>
    <div class="product-grid">
        <div class="product-card">
            <div class="product-image">
                <img src="images/product1.jpg" alt="Product 1">
                <span class="badge">Top Sellers</span>
            </div>
            <div class="product-info">
                <p class="title">See Top Selling Avurudu Products</p>
                <p class="price">From</p>
            </div>
        </div>

        <div class="product-card">
            <div class="product-image">
                <img src="images/product2.jpg" alt="Product 2">
                <span class="badge yellow">Best Seller</span>
            </div>
            <div class="product-info">
                <p class="title">Sinhala New Year Betel Leaf Avurudu Celebration..</p>
                <p class="price">Rs.4,970</p>
            </div>
        </div>

        <div class="product-card">
            <div class="product-image">
                <img src="images/product3.jpg" alt="Product 3">
                <span class="badge yellow">Best Seller</span>
                <span class="discount">10% off</span>
            </div>
            <div class="product-info">
                <p class="title">Avurudu Asiriya' Delight Box With Avurudu Betel...</p>
                <p class="price">Rs.14,500</p>
            </div>
        </div>
    </div>
</div>

</body>
</html>
