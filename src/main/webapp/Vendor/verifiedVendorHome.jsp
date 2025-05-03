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
    <title>Vendor Home</title>
</head>
<body>
<%@ include file="verifiedVendorNavBar.jsp" %>
<div class="page-container">
    <div class="product-card">
        <img src="vendorIMG/vendorHomeIMG.jpeg" alt="vendorHomeIMG" id="vendorHomeIMG">
        <h2>Add New Product</h2>
        <a href="vendorAddProducts.jsp"><button class="add-btn">Add New +</button></a>

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
</body>
</html>