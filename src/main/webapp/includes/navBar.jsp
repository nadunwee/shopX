<div class="navbar">
  <div class="left-section">
    <button class="menu-btn"><i class='bx bx-menu'></i></button>
    <select class="category-dropdown">
      <option>All Categories</option>
      <option>Food</option>
      <option>Gifts</option>
    </select>
  </div>

  <div class="search-section">
    <input type="text" placeholder="Search the entire store...">
    <button class="search-btn"><i class='bx bx-search'></i></button>
  </div>

  <div class="right-section">
    <a href="#"><i class='bx bx-cart'></i></a>
    <%
      String username = (String) session.getAttribute("username");
      if (username != null) {
    %>
    <a href="#"><i class='bx bx-user'></i> <%= username %></a>
    <a href="LogoutServlet">Logout</a>
    <%
    } else {
    %>
    <a href="./accessPages/login.jsp"><i class='bx bx-user'></i></a>
    <%
      }
    %>
  </div>
</div>