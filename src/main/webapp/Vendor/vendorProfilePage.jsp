<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.example.shopx.DBConnection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("../accessPages/login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        conn = DBConnection.getConnection();
        String sql = "SELECT * FROM vendors WHERE username = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        rs = stmt.executeQuery();

        if (rs.next()) {
            session.setAttribute("username", rs.getString("username"));
%>

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
    <title>Vendor Profile</title>
</head>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const modal = document.getElementById("editModal");
        const btn = document.getElementById("editBtn");
        const span = document.querySelector(".close");

        btn.onclick = function () {
            modal.style.display = "block";
        }

        span.onclick = function () {
            modal.style.display = "none";
        }

        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    });
</script>



<body>
<div class="main-layout">
    <div class="sidebar">
        <%@ include file="vendorNavBar.jsp" %>
    </div>

    <div class="content">
        <h2 class="mainTopic" style=".mainTopic; margin-left: 20px; padding: 10px" >Your Profile</h2>
        <a href="${pageContext.request.contextPath}/LogoutServlet"><button type="button" class="vendor-actionBtn" id="logoutBTN" name="backBtn" style="width: 100px; margin-left: 1000px; background-color: #CD7F32; padding: 20px">Log Out</button></a>

        <div class="vendor-profile-section">
            <div class="vendor-profile-block">
                <div class="vendor-profile-info">
                    <p class="vendorProfileName" style="margin-bottom: 30px"><span class="vendorProfileName"><%= rs.getString("store_name") %></span></p>
                    <p class="vendorProfileAddress">User Name : <span class="vendorProfileAddress"><%= rs.getString("username") %></span></p>
                    <p class="vendorProfileContactNo">Business ID : <span class="vendorProfileContactNo"><%= rs.getString("business_id") %></span></p>
                    <p class="vendorProfileEmail">Email : <span class="vendorProfileEmail"><%= rs.getString("email") %></span></p>
                </div>

                <div class="vendor-profileActionBtns">
                    <button id="editBtn" class="vendor-actionBtn" value="edit" name="edit" style="margin-right: 150px">Edit Details</button>
                    <button class="vendor-deleteBtn" value="delete" name="delete" >Delete Account</button>
                </div>

                <div id="editModal" class="modal">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <h2>Edit Your Details</h2>
                        <form action="${pageContext.request.contextPath}/vendorProfileUpdate" method="post">
                            <div class="input-group">
                                <label>Store Name:</label>
                                <input type="text" name="store_name" value="<%= rs.getString("store_name") %>"><br>
                            </div>
                            <div class="input-group">
                                <label>Email:</label>
                                <input style="margin-left: 75px" type="email" name="email" value="<%= rs.getString("email") %>"><br>
                            </div>
                            <button type="submit" class="vendor-actionBtn">Save Changes</button>
                        </form>
                    </div>
                </div>


            </div>
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

<%
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>

</body>
</html>
