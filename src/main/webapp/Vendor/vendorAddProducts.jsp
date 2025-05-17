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
    <title>Vendor Add Products</title>
</head>
<body>

<div class="main-layout">

    <div class="sidebar">
        <%@ include file="vendorNavBar.jsp" %>
    </div>

    <div class="content">
        <div class="product-add-form-card">
            <h2 style="padding: 15px; margin-bottom: 15px">Enter Item Details</h2>
            <form action="${pageContext.request.contextPath}/vendorAddProducts" method="post" enctype="multipart/form-data">
                <div class="form-row">
                    <label>Product Name :</label>
                    <input type="text" id="productName" name="productName" required>
                </div>

                <div class="form-row">
                    <label>Category :</label>
                    <select name="category" id="category" required>
                        <option name="none" value="none">None</option>
                        <option name="food" value="food">Food</option>
                        <option name="clothes" value="clothes">Clothes</option>
                        <option name="perfumes" value="perfumes">Perfumes</option>
                        <option name="flowers" value="flowers">Flowers</option>
                    </select>
                </div>

                <div class="form-row">
                    <label>Description :</label>
                    <textarea name="description" id="description" rows="4" required></textarea>
                </div>

                <div class="form-row">
                    <label>Upload Image :</label>
                    <div class="prompt" style="display: flex; flex-direction: column">
                        <input type="file" id="productImage" name="productImage" accept=".jpg,.jpeg,.png" required>
                        <small id="charCount" style="color: gray;">20 characters remaining</small>
                    </div>

                </div>

                <div class="form-row">
                    <label>Price :</label>
                    <input type="number" name="price" id="price" required>
                </div>

                <div class="form-row">
                    <label>Stock :</label>
                    <input type="number" name="stock" id="stock" required>
                </div>

                <div class="form-row" style="justify-content: flex-end;">
                    <button type="submit" class="vendor-actionBtn" name="submitBtn">Submit</button>
                </div>
            </form>

        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const input = document.getElementById("productImage");
                const counter = document.getElementById("charCount");
                const submitButton = document.querySelector(".vendor-actionBtn");
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