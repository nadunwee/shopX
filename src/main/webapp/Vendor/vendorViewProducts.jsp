<%@ page import="org.example.shopx.DBConnection" %>

<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" type="text/css" href="vendorStyles.css">
    <link rel="stylesheet" type="text/css" href="vendorNavBar.css">
    <title>Vendor View Products</title>
</head>

<%
    DBConnection DBUtil = null;
    Connection conn = DBUtil.getConnection();
    String sql = "SELECT * FROM products";
    PreparedStatement stmt = conn.prepareStatement(sql);
    ResultSet rs = stmt.executeQuery();
%>

<body>

<div class="main-layout">
    <div class="sidebar">
        <%@ include file="vendorNavBar.jsp" %>
    </div>

    <div class="content">
        <h2 class="mainTopic" style=".mainTopic; margin-left: 20px">Published Products</h2>
            <div class="product-grid">

                <div class="product-block">
                    <div class="product-image">
                        <img src="#" alt="Product 1">
                    </div>
                    <div class="product-info">
                        <p class="title">See Top Selling Avurudu Products</p>
                        <p class="price">Rs. 5,280</p>
                        <p class="rating">Overall rating: 4/5</p>
                        <div class="action-buttons">
                            <a href="vendorSelectSubscription.jsp"><button class="vendor-actionBtn">Edit Details</button></a>
                            <a href="vendorSelectSubscription.jsp"><button class="vendor-deleteBtn">Delete Item</button></a>
                        </div>
                    </div>
                </div>

                <div class="product-block">
                    <div class="product-image">
                        <img src="#" alt="Product 1">
                    </div>
                    <div class="product-info">
                        <p class="title">See Top Selling Avurudu Products</p>
                        <p class="price">Rs. 5,280</p>
                        <p class="rating">Overall rating: 4/5</p>
                        <div class="action-buttons">
                            <a href="vendorSelectSubscription.jsp"><button class="vendor-actionBtn">Edit Details</button></a>
                            <a href="vendorSelectSubscription.jsp"><button class="vendor-deleteBtn">Delete Item</button></a>
                        </div>
                    </div>
                </div>

                <div class="product-block">
                    <div class="product-image">
                        <img src="#" alt="Product 1">
                    </div>
                    <div class="product-info">
                        <p class="title">See Top Selling Avurudu Products</p>
                        <p class="price">Rs. 5,280</p>
                        <p class="rating">Overall rating: 4/5</p>
                        <div class="action-buttons">
                            <a href="vendorSelectSubscription.jsp"><button class="vendor-actionBtn">Edit Details</button></a>
                            <a href="vendorSelectSubscription.jsp"><button class="vendor-deleteBtn">Delete Item</button></a>
                        </div>
                    </div>
                </div>

                <div class="product-block">
                    <div class="product-image">
                        <img src="#" alt="Product 1">
                    </div>
                    <div class="product-info">
                        <p class="title">See Top Selling Avurudu Products</p>
                        <p class="price">Rs. 5,280</p>
                        <p class="rating">Overall rating: 4/5</p>
                        <div class="action-buttons">
                            <a href="vendorSelectSubscription.jsp"><button class="vendor-actionBtn">Edit Details</button></a>
                            <a href="vendorSelectSubscription.jsp"><button class="vendor-deleteBtn">Delete Item</button></a>
                        </div>
                    </div>
                </div>

                <div class="product-block">
                    <div class="product-image">
                        <img src="#" alt="Product 1">
                    </div>
                    <div class="product-info">
                        <p class="title">See Top Selling Avurudu Products</p>
                        <p class="price">Rs. 5,280</p>
                        <p class="rating">Overall rating: 4/5</p>
                        <div class="action-buttons">
                            <a href="vendorSelectSubscription.jsp"><button class="vendor-actionBtn">Edit Details</button></a>
                            <a href="vendorSelectSubscription.jsp"><button class="vendor-deleteBtn">Delete Item</button></a>
                        </div>
                    </div>
                </div>

                <div class="product-block">
                    <div class="product-image">
                        <img src="#" alt="Product 1">
                    </div>
                    <div class="product-info">
                        <p class="title">See Top Selling Avurudu Products</p>
                        <p class="price">Rs. 5,280</p>
                        <p class="rating">Overall rating: 4/5</p>
                        <div class="action-buttons">
                            <a href="#"><button class="vendor-actionBtn">Edit Details</button></a>
                            <a href="#"><button class="vendor-deleteBtn">Delete Item</button></a>
                        </div>
                    </div>
                </div>



            </div>


        <footer class="landing-footer">
            <div class="landing-footer-content">
                <div class="landing-footer-logo">ShopX</div>
                <div class="landing-footer-links">
                    <a href="#">About</a>
                    <a href="#">Contact</a>
                    <a href="#">Privacy</a>
                    <a href="#">Terms</a>
                </div>
                <p class="landing-footer-copy">&copy; 2025 ShopX. All rights reserved.</p>
            </div>
        </footer>
    </div>
</div>

</body>
</html>
