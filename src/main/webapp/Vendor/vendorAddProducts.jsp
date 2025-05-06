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
            <form action="">
                <label>Product Name :</label>
                <input type="text" id="productName" name="productName" required><br><br>

                <label>Category :</label>
                <select name="category" id="category" required>
                    <option value="Select">Select</option>
                    <option value="Food">Food</option>
                    <option value="Clothes">Clothes</option>
                    <option value="Perfumes">Perfumes</option>
                    <option value="Flowers">Flowers</option>
                </select><br><br>

                <label>Description :</label><br>
                <textarea name="description" id="description" cols="45" rows="5" required></textarea><br><br>

                <label>Upload Product Images (JPG/PNG, Max 2MB):</label>
                <input type="file" name="productImage" accept=".jpg,.jpeg,.png" required><br><br>

                <label>Price :</label>
                <input type="number" name="price" id="price" required><br><br>

                <label>Stock :</label>
                <input type="number" name="stock" id="stock" required><br><br>

                <button type="submit" class="vendor-actionBtn" name="submitBtn">Submit</button>
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