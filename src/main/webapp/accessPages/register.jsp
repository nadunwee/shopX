<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>ShopX | Register</title>
  <link rel="stylesheet" type="text/css" href="register.css">
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>

<div class="register-wrapper">
  <div class="register-container">

    <!-- Left side -->
    <div class="register-left">
      <img src="../photos/loginImg.png" alt="Mascot" class="register-mascot">
      <h2>Join ShopX Today!</h2>
      <p>Create your account and start shopping with exclusive deals.</p>
      <a href="login.jsp" class="login-link">Already have an account? Login here</a>
    </div>

    <!-- Right side -->
    <div class="register-right">
      <h2>Create Your Account</h2>
      <% String errorMessage = (String) request.getAttribute("error"); %>
      <% if (errorMessage != null) { %>
      <div class="error-message"><%= errorMessage %></div>
      <% } %>

      <form action="${pageContext.request.contextPath}/registerUser" method="POST" class="register-form">
        <input type="hidden" name="type" value="customer" />

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

        <div class="input-group">
          <label for="dob">Date of Birth</label>
          <input type="date" id="dob" name="dob" required>
        </div>

        <div class="input-group">
          <label for="national-id">National ID </label>
          <input type="text" id="national-id" name="national-id" required>
        </div>

        <button type="submit" class="register-btn">Register</button>
      </form>
    </div>

  </div>
</div>

<% String error = (String) request.getAttribute("error"); %>
<% if (error != null) { %>
<script>
  alert("<%= error %>");
  window.location.href = "accessPages/register.jsp";
</script>
<% } %>

</body>
</html>
