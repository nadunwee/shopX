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
<div class="sidebar">
    <%@ include file="vendorNavBar.jsp" %>
</div>
<div class="content">
        <h2 style="padding: 20px">Your Profile</h2>
    <div class="vendor-profile-section">
        <div class="vendor-profile-block">
            <div class="vendor-profile-image">
                <img src="#" alt="Profile pic">
            </div>
            <div class="vendor-profile-info">
                <p class="vendorProfileName">Name : <span class="vendorProfileName">name 1</span></p>

                <p class="vendorProfileAddress">Address : <span class="vendorProfileAddress">address 1</span></p>

                <p class="vendorProfileContactNo">Contact No : <span class="vendorProfileContactNo">contact 1</span></p>

                <p class="vendorProfileEmail">Email : <span class="vendorProfileEmail">email 1</span></p>
            </div>

                <div class="vendor-profileActionBtns">
                    <a href="vendorSelectSubscription.jsp"><button class="vendor-actionBtn" value="edit" name="edit" style="margin-right: 150px">Edit Details</button></a>
                    <a href="vendorSelectSubscription.jsp"><button class="vendor-deleteBtn" value="delete" name="delete" >Delete Account</button></a>
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