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
            <button type="button" class="vendor-actionBtn" name="backBtn"
                    style="width: 100px; margin-left: 20px; margin-top: 20px">Go
                Back
            </button>
        </a>
        <div class="product-add-form-card" id="vendorVerificationForm">
            <h2 class="mainTopic" style=".mainTopic; padding: 20px">Payment System</h2>
            <div class="selectedSubDisplay" style="margin-bottom: 25px;">

                <%
                    String subType = (String) session.getAttribute("subscriptionType");
                %>
                <h3 style="color: rgb(8,227,8); font-weight: bold">You selected the <%= subType %> subscription !</h3>
                <%
                  if ("gold".equals(subType)) {
                %>
                <h4 style="color: rgba(203,171,4,0.99); font-weight: bold; font-size: 22px">Rs.5000/=</h4>
                <%
                  } else if ("silver".equals(subType)) {
                %>
                <h4 style="color: #7b7a7a; font-weight: bold; font-size: 22px">Rs.3000/=</h4>
                <%
                  } else if ("bronze".equals(subType)) {
                %>
                <h4 style="color: #CD7F32; font-weight: bold; font-size: 22px">Rs.1000/=</h4>
                <%
                  }
                %>
            </div>

            <form action="${pageContext.request.contextPath}/vendorPaymentDetails" method="POST" class="subPayment-form">

                <div class="form-row">
                    <label for="cardType">Card Type :</label>
                    <select id="cardType" name="cardType" required>
                        <option value="visa">VISA</option>
                        <option value="master">MASTER CARD</option>
                    </select>
                </div>

                <div class="form-row">
                    <label for="cardNo">Card No :</label>
                    <div class="promptRemaining" style="display: flex; flex-direction: column;">
                        <input type="text" id="cardNo" name="cardNo" required maxlength="16" oninput="updateCharCount()">
                        <small id="charCount" style="color: gray;">16 characters remaining</small>
                    </div>

                </div>

                <div class="form-row">
                    <label for="cardEXP">Expiry Date :</label>
                    <input type="date" id="cardEXP" name="cardEXP" required>
                </div>

                <div class="form-row">
                    <label for="cardCVN">CVN :</label>
                    <input type="text" id="cardCVN" name="cardCVN" required>
                </div>

                <div class="form-row" style="justify-content: flex-end;">
                    <button type="submit" class="vendor-actionBtn" name="submitBtn" style="width: 200px;">Submit Your Request</button>
                </div>

            </form>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const input = document.getElementById("cardNo");
                const counter = document.getElementById("charCount");

                function updateCharCount() {
                    const maxLength = parseInt(input.getAttribute("maxlength"));
                    const currentLength = input.value.length;
                    const remaining = maxLength - currentLength;
                    counter.textContent = remaining + " characters remaining";
                }

                input.addEventListener("input", updateCharCount);
                updateCharCount();
            });
        </script>

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