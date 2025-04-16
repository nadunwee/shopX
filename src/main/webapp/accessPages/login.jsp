<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>ShopX | Login</title>
  <link rel="stylesheet" type="text/css" href="login.css">
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>

<main class="login-main">
  <div class="login-container">
    <h2>Login to ShopX</h2>
    <form action="${pageContext.request.contextPath}/loginUser" method="POST" class="login-form">
      <div class="input-group">
        <label for="type">Login As</label>
        <select id="type" name="type" required>
          <option value="customer">Customer</option>
          <option value="vendor">Vendor</option>
        </select>
      </div>

      <div class="input-group">
        <label for="username">Username or Email</label>
        <input type="text" id="username" name="username" required>
      </div>
      <div class="input-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>
      </div>
      <div class="login-actions">
        <button type="submit" class="login-btn">Login</button>
        <a href="#" class="forgot-password">Forgot Password?</a>
        <p>not a member <a href="./register.jsp">register here</a></p>
      </div>
    </form>
  </div>
</main>

</body>
</html>
