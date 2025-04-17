<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>ShopX | Login</title>
  <link rel="stylesheet" type="text/css" href="login.css">
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>

<main class="login-wrapper">
  <div class="login-card">

    <!-- New Customers Section -->
    <div class="login-left">
      <img src="../photos/loginImg.png" alt="Mascot" class="login-mascot">
      <h2>New Customers</h2>
      <p>If you create an account with us, you will get additional benefits such as order history, bonus cash and more.</p>
      <a href="register.jsp" class="create-account-btn">Create Account</a>
    </div>

    <!-- Login Form -->
    <div class="login-right">
      <h2>shopX Members</h2>
      <p>If you have a ShopX account, then enter your email and password here.</p>
      <form action="${pageContext.request.contextPath}/loginUser" method="POST" class="login-form">
        <div class="input-group">
          <label for="type">Login As</label>
          <select id="type" name="type" required>
            <option value="customer">Customer</option>
            <option value="vendor">Vendor</option>
          </select>
        </div>
        <input type="text" name="username" placeholder="Enter email" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit" class="login-btn">Login</button>
        <div class="login-links">
          <a href="#">Forgot your password</a> |
          <a href="#">Account benefits</a>
        </div>
        <div class="login-divider">Or Sign In With</div>
        <button class="google-signin">
          <img src="https://developers.google.com/identity/images/g-logo.png" alt="Google icon"> Signed in with Google
        </button>
      </form>
    </div>

  </div>
</main>

</body>
</html>
