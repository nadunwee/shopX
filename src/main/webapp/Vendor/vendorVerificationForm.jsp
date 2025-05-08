<%@ page import="java.sql.SQLOutput" %>
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
    <title>Vendor Subscription Form</title>
</head>
<body>
<div class="main-layout">
    <div class="sidebar">
        <%@ include file="vendorNavBar.jsp" %>
    </div>
    <div class="content">
        <a href="./vendorSelectSubscription.jsp">
            <button type="button" class="vendor-actionBtn" name="backBtn" style="width: 100px; margin-left: 20px; margin-top: 20px">Go
                Back
            </button>
        </a>
        <div class="product-add-form-card" id="vendorVerificationForm">
            <h2 class="mainTopic" style=".mainTopic; padding: 20px">Enter Business Details</h2>
            <div class="selectedSubDisplay" style="margin-bottom: 25px;">
                <%
                    String selectedSub = request.getParameter("sub");
                    if (selectedSub != null) {
                        session.setAttribute("subscriptionType", selectedSub);
                    }
                    System.out.println(selectedSub);
                %>

                <%
                    String sub = request.getParameter("sub");
                    if ("gold".equals(sub)) {
                %>
                <h3 style="color: rgba(203,171,4,0.99)">You selected the gold subscription !</h3>
                <%
                } else if ("silver".equals(sub)) {
                %>
                <h3 style="color: #7b7a7a">You selected the silver subscription !</h3>
                <%
                } else if ("bronze".equals(sub)) {
                %>
                <h3 style="color: #CD7F32">You selected the bronze subscription !</h3>
                <%
                    }
                %>
            </div>

            <form action="${pageContext.request.contextPath}/vendorSubscription" method="POST" class="subscription-form">
                <div class="form-row">
                    <label for="companyName">Legal company name :</label>
                    <input type="text" id="companyName" name="companyName" required>
                </div>

                <div class="form-row">
                    <label for="businessAddress">Business address :</label>
                    <input type="text" id="businessAddress" name="businessAddress" required>
                </div>

                <div class="form-row">
                    <label for="businessEmail">Business email :</label>
                    <input type="email" id="businessEmail" name="businessEmail" required>
                </div>

                <div class="form-row">
                    <label for="businessContactNo">Business Contact No. :</label>
                    <input type="tel" id="businessContactNo" name="businessContactNo" required>
                </div>

                <div class="form-row">
                    <label for="businessRegNo">Business Registration No. :</label>
                    <input type="text" id="businessRegNo" name="businessRegNo" required>
                </div>

                <div class="form-row" style="justify-content: flex-end;">
                    <button type="submit" class="vendor-actionBtn" name="submitBtn">Proceed To Pay</button>
                </div>
            </form>


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