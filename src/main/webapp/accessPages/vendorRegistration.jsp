<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>ShopX | Vendor Registration</title>
    <link rel="stylesheet" type="text/css" href="vendorregistration.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>

<main class="register-main">
    <h2 class="mainTopic" style="margin-left: 20px;font-size: 28px; color: #4b1e83; text-align: center">Vendor Registration</h2>
    <div class="register-container" style="padding: 50px; margin-bottom: 60px;">

        <form action="${pageContext.request.contextPath}/registerUser" method="POST" class="register-form" enctype="multipart/form-data">

            <input type="hidden" name="type" value="vendor">

            <div class="input-group">
                <label for="storeName">Store Name</label>
                <input type="text" id="storeName" name="storeName" required>
            </div>

            <div class="input-group">
                <label for="vendorUsername">Username</label>
                <input type="text" id="vendorUsername" name="vendorUsername" required>
            </div>

            <div class="input-group">
                <label for="vendorDOB">Date Of Birth</label>
                <input type="date" id="vendorDOB" name="vendorDOB" required>
            </div>

            <div class="input-group">
                <label for="vendorEmail">Email</label>
                <input type="email" id="vendorEmail" name="vendorEmail" required>
            </div>

            <div class="input-group">
                <label for="vendorPassword">Password</label>
                <input type="password" id="vendorPassword" name="vendorPassword" required>
            </div>

            <div class="input-group">
                <label for="vendorConfirmPassword">Confirm Password</label>
                <input type="password" id="vendorConfirmPassword" name="vendorConfirmPassword" required>
            </div>

            <div class="input-group">
                <label for="vendorAddress">Address</label>
                <input type="text" id="vendorAddress" name="vendorAddress" required>
            </div>

            <div class="input-group">
                <label for="vendorLogo">Upload Logo</label>
                <input type="file" id="vendorLogo" name="vendorLogo" required>
                <small id="charCount" style="color: gray;">20 characters remaining</small>
            </div>

            <div class="register-actions">
                <button type="submit" class="register-btn">Register as Vendor</button>
                <p>Want to shop instead? <a href="register.jsp" class="login-link">Register as Customer</a></p>
            </div>

        </form>
    </div>
</main>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const input = document.getElementById("vendorLogo");
        const counter = document.getElementById("charCount");
        const submitButton = document.querySelector(".register-btn");
        const maxLength = 20;

        function updateCharCount() {
            if (input.files.length > 0) {
                const fileName = input.files[0].name;
                const length = fileName.length;

                if (length > maxLength) {
                    counter.textContent = "Image name exceeds 20 character limit!";
                    counter.style.color = "red";
                    submitButton.disabled = true;
                } else {
                    counter.textContent = (maxLength - length) + " characters remaining";
                    counter.style.color = "gray";
                    submitButton.disabled = false;
                }
            } else {
                counter.textContent = maxLength + " characters remaining";
                counter.style.color = "gray";
                submitButton.disabled = false;
            }
        }

        input.addEventListener("change", updateCharCount);
    });
</script>
</body>

</html>
