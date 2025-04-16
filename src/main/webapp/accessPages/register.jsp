<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>ShopX | Register</title>
  <link rel="stylesheet" type="text/css" href="register.css">
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>

<main class="register-main">
  <div class="register-container">
    <h2>Create Your Account</h2>
    <form action="${pageContext.request.contextPath}/registerUser" method="POST" class="register-form">
      <div class="input-group">
        <label for="username">Username</label>
        <input type="text" id="username" name="username" required>
      </div>
      <div class="input-group">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" required>
      </div>
      <div class="input-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>
      </div>
      <div class="input-group">
        <label for="confirm-password">Confirm Password</label>
        <input type="password" id="confirm-password" name="confirm-password" required>
      </div>
      <div class="register-actions">
        <button type="submit" class="register-btn">Register</button>
        <p>Already have an account? <a href="login.jsp" class="login-link">Login here</a></p>
      </div>
    </form>
  </div>
</main>

<%--<footer class="landing-footer">--%>
<%--  <div class="landing-footer-content">--%>
<%--    <div class="landing-footer-logo">ShopX</div>--%>
<%--    <div class="landing-footer-links">--%>
<%--      <a href="#">About</a>--%>
<%--      <a href="#">Contact</a>--%>
<%--      <a href="#">Privacy</a>--%>
<%--      <a href="#">Terms</a>--%>
<%--    </div>--%>
<%--    <p class="landing-footer-copy">&copy; 2025 ShopX. All rights reserved.</p>--%>
<%--  </div>--%>
<%--</footer>--%>

</body>
</html>
