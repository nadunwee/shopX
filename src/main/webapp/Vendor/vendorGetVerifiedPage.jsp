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
    <title>Vendor Get Verified</title>
</head>
<body>
<%@ include file="vendorNavBar.jsp" %>
<div class="page-container">
    <div class="product-card">
        <img src="vendorIMG/verificationPageIMG.jpeg" alt="vendorGetVerifiedIMG" id="vendorGetVerifiedIMG">
        <h2>Do you like to be verified ?</h2>
        <h4>Be verified and experience our exclusive features</h4>
        <a href="vendorSelectSubscription.jsp"><button class="vendor-actionBtn">Get Verified</button></a>

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