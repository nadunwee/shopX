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
        const editBtn = document.getElementById("editBtn");
        const editModal = document.getElementById("editModal");

        const deleteBtn = document.getElementById("vendor-deleteBtn");
        const deleteModal = document.getElementById("deleteModal");

        const closeButtons = document.querySelectorAll(".close");

        closeButtons.forEach(function (btn) {
            btn.addEventListener("click", function () {
                btn.closest(".modal").style.display = "none";
            });
        });

        editBtn.onclick = () => editModal.style.display = "block";
        deleteBtn.onclick = () => deleteModal.style.display = "block";

        window.onclick = function (event) {
            if (event.target === editModal) editModal.style.display = "none";
            if (event.target === deleteModal) deleteModal.style.display = "none";
        };
    });
</script>

<body>
<div class="main-layout">
    <div class="sidebar">
        <%@ include file="vendorNavBar.jsp" %>
    </div>

    <div class="content">
        <h2 class="mainTopic" style=".mainTopic; margin-left: 20px; padding: 10px">Your Profile</h2>
        <a href="${pageContext.request.contextPath}/LogoutServlet">
            <button type="button" class="vendor-LogoutBtn" id="logoutBTN" name="vendor-LogoutBtn"
                    style="width: 100px; height: 80px; margin-left: 1000px; background-color: #CD7F32; padding: 20px">
                Log Out
            </button>
        </a>
        <%--  reading data from the up, go to the top--%>
        <div class="vendor-profile-section">
            <div class="vendor-profile-block">
                <img src="../photos/<%= rs.getString("imageFileName") %>" class="vendorLOGO" alt="logo">
                <p class="vendorProfileStoreName" style="margin-bottom: 30px;  "><span
                        class="vendorProfileStoreName"><%= rs.getString("store_name") %></span></p>
                <div class="vendor-profile-info">
                    <div class="vendorProfileRow">
                        <label class="vendorProfileLabel">User Name:</label>
                        <span class="vendorProfileValue"><%= rs.getString("username") %></span>
                    </div>
                    <div class="vendorProfileRow">
                        <label class="vendorProfileLabel">Date Of Birth:</label>
                        <span class="vendorProfileValue"><%= rs.getString("vendorDOB") %></span>
                    </div>
                    <div class="vendorProfileRow">
                        <label class="vendorProfileLabel">Address:</label>
                        <span class="vendorProfileValue"><%= rs.getString("vendorAddress") %></span>
                    </div>
                    <div class="vendorProfileRow">
                        <label class="vendorProfileLabel">Email:</label>
                        <span class="vendorProfileValue"><%= rs.getString("email") %></span>
                    </div>
                    <div class="vendorProfileRow">
                        <label class="vendorProfileLabel">Joined at:</label>
                        <span class="vendorProfileValue"><%= rs.getString("created_at").split(" ")[0] %></span>
                    </div>

                </div>
                <div class="vendor-profileActionBtns">
                    <button id="editBtn" class="vendor-actionBtn" value="edit" name="edit" style="margin-right: 150px">
                        Edit Details
                    </button>
                    <button id="vendor-deleteBtn" class="vendor-deleteBtn" value="delete" name="delete">Delete Account
                    </button>
                </div>

                <div id="editModal" class="modal">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <h2>Edit Your Details</h2>
                        <form action="${pageContext.request.contextPath}/vendorProfileUpdate" method="post" enctype="multipart/form-data">
                            <div class="input-group">
                                <label>Store Name:</label>
                                <input type="text" name="store_name" value="<%= rs.getString("store_name") %>"><br>
                            </div>
                            <div class="input-group">
                                <label>Date Of Birth:</label>
                                <input type="text" name="vendorDOB" value="<%= rs.getString("vendorDOB") %>"><br>
                            </div>
                            <div class="input-group">
                                <label>Address:</label>
                                <input type="text" name="vendorAddress"
                                       value="<%= rs.getString("vendorAddress") %>"><br>
                            </div>
                            <div class="input-group">
                                <label>Email:</label>
                                <input style="margin-left: 75px" type="email" name="email"
                                       value="<%= rs.getString("email") %>"><br>
                            </div>
                            <div class="input-group">
                                <label>New Image:</label>
                                <input type="file" name="vendorLogo"><br>
                            </div>
                            <button type="submit" class="vendor-actionBtn">Save Changes</button>
                        </form>
                    </div>
                </div>

                <div id="deleteModal" class="modal">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <h2>Are You Sure ?</h2>
                        <h4 style="color: #e74c3c; font-family: 'Century',serif; margin-bottom: 8px">You about to
                            permanently delete your data from ShopX</h4>
                        <form action="${pageContext.request.contextPath}/vendorProfileDelete" method="post">
                            <div class="input-group">
                                <label>Store Name:</label>
                                <input type="text" name="store_name" value="<%= rs.getString("store_name") %>" readonly><br>
                            </div>
                            <div class="input-group">
                                <label>Date Of Birth:</label>
                                <input type="text" name="username" value="<%= rs.getString("vendorDOB") %>"
                                       readonly><br>
                            </div>
                            <div class="input-group">
                                <label>Business ID:</label>
                                <input type="text" name="vendorAddress" value="<%= rs.getString("vendorAddress") %>"
                                       readonly><br>
                            </div>
                            <div class="input-group">
                                <label>Email:</label>
                                <input style="margin-left: 75px" type="email" name="email"
                                       value="<%= rs.getString("email") %>" readonly><br>
                            </div>
                            <button type="submit" class="vendor-deleteBtn">Delete Account</button>
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
    }
%>

</body>
</html>
