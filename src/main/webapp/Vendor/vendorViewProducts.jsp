+ <%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<body>

<div class="main-layout">
    <%@ include file="vendorNavBar.jsp" %>  <!-- Sidebar -->

    <div class="main-content-area">
        <div class="product-section">
            <h2 style="padding: 20px">Published Products</h2>
            <div class="product-grid">
                <%-- Example repeated product blocks (you can dynamically generate these later) --%>
                <div class="product-block">
                    <div class="product-image">
                        <img src="#" alt="Product 1">
                    </div>
                    <div class="product-info">
                        <p class="title">See Top Selling Avurudu Products</p>
                        <p class="price">Rs. 5,280</p>
                        <p class="rating">Overall rating: ★★★★☆</p>
                        <div class="action-buttons">
                            <a href="vendorSelectSubscription.jsp"><button class="vendor-actionBtn">Edit Details</button></a>
                            <a href="vendorSelectSubscription.jsp"><button class="vendor-deleteBtn">Delete Item</button></a>
                        </div>
                    </div>
                </div>

                <!-- Repeat the above .product-block for each product (as you already have) -->
                <!-- Tip: Eventually replace these hardcoded blocks with dynamic JSP logic -->
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
