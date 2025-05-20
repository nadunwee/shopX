<div class="navbar">
  <div class="left-section">
    <h1 style="font-size: 28px; font-weight: bold; margin: 0;">shopX</h1>
  </div>

  <div class="right-section">
    <a href="#"><i class='bx bx-cart'></i></a>
    <%
      if (session.getAttribute("username") != null) {
    %>
    <a href="./account.jsp"><i class='bx bx-user navbar-icons'></i> <%= session.getAttribute("username") %></a>
    <a href="LogoutServlet">Logout</a>
    <%
    } else {
    %>
    <a href="./accessPages/login.jsp"><i class='bx bx-user navbar-icons'></i></a>
    <%
      }
    %>
  </div>
</div>
