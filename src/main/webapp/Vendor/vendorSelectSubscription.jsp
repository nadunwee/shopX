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
  <div class="product-section">
    <h2 style="padding: 20px">Select a Subscription</h2>
    <div class="product-grid">
      <div class="product-block">
        <div class="subscription-image">
          <img src="./vendorIMG/gold.jpeg" alt="goldSub">
        </div>
        <div class="product-info">
          <p class="title">
            <b>Features</b><br>
            <p class="subInfo" style="text-align: left">
            + Get annual business summery.<br>
            + Direct contact admin.<br>
            + Real time transaction monitering.<br>
            + Get 100% money from a sold item.
            </p>
          <p class="price">Rs.5000</p>
          <a href="./vendorVerificationForm.jsp?sub=gold"><button class="add-btn" value="gold" name="gold">Select Gold</button></a>
        </div>
      </div>

      <div class="product-block">
        <div class="subscription-image">
          <img src="./vendorIMG/silver.jpeg" alt="silverSub">
        </div>
        <div class="product-info">
          <p class="title">
            <b>Features</b><br>
          <p class="subInfo" style="text-align: left; height: 120px">
            + Get annual business summery.<br>
            + Direct contact admin.<br>
            + Get 95% money from a sold item.
          </p>
          <p class="price">Rs.3000</p>
          <a href="./vendorVerificationForm.jsp?sub=silver"><button class="add-btn" value="silver" name="silver">Select Silver</button></a>
        </div>
      </div>

      <div class="product-block">
        <div class="subscription-image" style="margin-left: 10px">
          <img src="./vendorIMG/bronze.jpeg" alt="bronzeSub">
        </div>
        <div class="product-info">
          <p class="title">
            <b>Features</b><br>
          <p class="subInfo" style="text-align: left; height: 110px">
            + Get annual business summery.<br>
            + Get 80% money from a sold item.
          </p>
          <p class="price">Rs.1000</p>
          <a href="./vendorVerificationForm.jsp?sub=bronze"><button class="add-btn" value="bronze" name="bronze">Select Bronze</button></a>
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
</body>
</html>