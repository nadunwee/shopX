<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ page import="javax.servlet.http.HttpSession" %>--%>
<%@ page import="org.example.shopx.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.example.shopx.Checkout.AddressModel" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Account - MyShop</title>
    <link rel="stylesheet" href="style.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <style>
        .account-container {
            padding: 40px;
            max-width: 1000px;
            margin: auto;
        }

        .account-header {
            color: #4b1e83;
            border-left: 5px solid #ffdd00;
            padding-left: 15px;
            margin-bottom: 30px;
            font-size: 28px;
        }

        .account-sections {
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
        }

        .account-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            padding: 20px;
            flex: 1 1 300px;
            transition: 0.3s;
        }

        .account-card:hover {
            transform: translateY(-5px);
        }

        .account-card h3 {
            color: #4b1e83;
            margin-bottom: 15px;
        }

        .account-card p {
            color: #555;
            margin-bottom: 8px;
        }

        .account-actions button {
            background-color: #ffdd00;
            border: none;
            padding: 10px 16px;
            font-size: 14px;
            color: #333;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 10px;
        }

        .account-actions button:hover {
            background-color: #ffbd2d;
        }
        .modal {
            position: fixed;
            z-index: 999;
            top: 0; left: 0;
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;  /* ← This ensures vertical centering */
            background-color: rgba(0, 0, 0, 0.4);
        }
        .modal-content {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.2);
            position: relative;
            animation: fadeIn 0.3s ease-in-out;
        }

        .modal-content h2 {
            color: #4b1e83;
            margin-bottom: 20px;
            font-size: 22px;
        }

        .modal-content label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: #4b1e83;
        }

        .modal-content input {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
        }

        .modal-content button[type="submit"] {
            background-color: #ffdd00;
            border: none;
            padding: 10px 18px;
            font-size: 14px;
            color: #333;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
        }

        .modal-content button[type="submit"]:hover {
            background-color: #ffbd2d;
        }

        .close-btn {
            position: absolute;
            top: 12px;
            right: 15px;
            font-size: 22px;
            color: #888;
            cursor: pointer;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<%
    String usernameSession = (String) session.getAttribute("username");
    String name = "";
    String email = "";
    String dob = "";
    String nationalId = "";
    String password = "";

    String username = "";
    if (usernameSession != null) {
        try {
            DBConnection DBUtil = null;
            Connection conn = DBUtil.getConnection();
            String sql = "SELECT username, email, dob, national_id, password FROM users WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, usernameSession);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                name = rs.getString("username");
                email = rs.getString("email");
                dob = rs.getString("dob");
                nationalId = rs.getString("national_id");
                password = rs.getString("password");
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("login.jsp");
    }

    List<AddressModel> savedAddresses = new ArrayList<>();

    if (usernameSession != null) {
        try {
            DBConnection DBUtil = null;
            Connection conn = DBUtil.getConnection();

            String sql = "SELECT da.full_name, da.street, da.city, da.zip " +
                    "FROM delivery_address da " +
                    "INNER JOIN users u ON u.id = da.user_id " +
                    "WHERE u.username = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, usernameSession);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                AddressModel address = new AddressModel();
                address.setFullname(rs.getString("full_name"));
                address.setStreet(rs.getString("street"));
                address.setCity(rs.getString("city"));
                address.setZip(rs.getInt("zip"));
                savedAddresses.add(address);
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>


<%@ include file="/includes/navBar.jsp" %>

<div class="account-container">
    <div class="account-header">My Account</div>

    <div class="account-sections">
        <div class="account-card">
            <h3>Profile Info</h3>
            <p><strong>Name:</strong><%= name %></p>
            <p><strong>Email:</strong><%= email %></p>
            <p><strong>Date Of Birth: </strong><%= dob %> </p>
            <p><strong>National ID: </strong><%= nationalId %> </p>
        </div>

        <div class="account-card">
            <h3>Recent Orders</h3>
            <p>Order #1054 – Rs. 3,200 – <span style="color: green;">Delivered</span></p>
            <p>Order #1048 – Rs. 1,900 – <span style="color: orange;">Shipped</span></p>
            <p><a href="orders.jsp" style="color: #4b1e83; font-weight: bold;">View All Orders</a></p>
        </div>
        <div class="account-card">
            <h3>Saved Addresses</h3>

            <ul style="padding-left: 18px;">
                <% for (AddressModel addr : savedAddresses) { %>
                <li><%= addr.getFullname() %>, <%= addr.getStreet() %>, <%= addr.getCity() %>, <%= addr.getZip() %></li>
                <% } %>
            </ul>


        </div>

        <div class="account-card account-actions">
            <h3>Account Actions</h3>
            <form action="LogoutServlet" method="post">
                <button type="submit"><i class='bx bx-log-out'></i> Logout</button>
            </form>
            <br>
            <button onclick="openModal()"><i class='bx bx-edit'></i> Edit Profile</button>
            <br>
            <button onclick="openDeleteModal()" style="background-color: #e74c3c; color: white;"><i class='bx bx-trash'></i> Delete Account</button>
        </div>
    </div>
</div>

<!-- Edit Profile Modal -->
<div id="editModal" class="modal" style="display:none;">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <h2>Edit Profile</h2>
        <form action="UserServlet" method="post">
            <input type="hidden" name="action" value="updateProfile">
            <div>
                <label>Username:</label>
                <input type="text" name="username" style="color:#aaa" value="<%= name %>" readonly>
            </div>
            <div>
                <label>Email:</label>
                <input type="email" name="email" value="<%= email %>">
            </div>
            <div>
                <label>National ID:</label>
                <input type="text" name="nationalID" value="<%= nationalId %>">
            </div>
            <div>
                <label>Date Of Birth:</label>
                <input type="date" name="dob" value="<%= dob %>">
            </div>
            <div>
            <label>Password: </label>
            <input type="password" name="password" value="<%= password %>">
            </div>

            <br>
            <button type="submit">Save Changes</button>
        </form>
    </div>
</div>

<!-- Edit Profile Modal -->
<div id="editModal" class="modal" style="display:none;">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <h2>Edit Profile</h2>
        <form action="UserServlet" method="post">
            <input type="hidden" name="action" value="updateProfile">
            <div>
                <label>Username:</label>
                <input type="text" name="username" value="<%= name %>" readonly>
            </div>
            <div>
                <label>Email:</label>
                <input type="email" name="email" value="<%= email %>">
            </div>
            <br>
            <button type="submit">Save Changes</button>
        </form>
    </div>
</div>

<div id="deleteModal" class="modal" style="display:none;">
    <div class="modal-content">
        <span class="close-btn" onclick="closeDeleteModal()">&times;</span>
        <h2>Confirm Deletion</h2>
        <p style="margin-bottom: 20px;">Are you sure you want to delete your account(<%= name %>)? This action cannot be undone.</p>
        <form action="UserServlet" method="post">
            <input type="hidden" name="action" value="deleteProfile">
            <input type="hidden" name="username" value="<%= name %>">
            <button type="submit" style="background-color: #e74c3c; color: white;">Yes, Delete My Account</button>
        </form>
    </div>
</div>



</body>

<script>
    function openModal() {
        document.getElementById("editModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("editModal").style.display = "none";
    }

    // Close when clicking outside the modal
    window.onclick = function(event) {
        const modal = document.getElementById("editModal");
        if (event.target == modal) {
            modal.style.display = "none";
        }
    };

    function openDeleteModal() {
        document.getElementById("deleteModal").style.display = "flex";
    }

    function closeDeleteModal() {
        document.getElementById("deleteModal").style.display = "none";
    }

    window.onclick = function(event) {
        const editModal = document.getElementById("editModal");
        const deleteModal = document.getElementById("deleteModal");

        if (event.target === editModal) {
            closeModal();
        } else if (event.target === deleteModal) {
            closeDeleteModal();
        }
    };
</script>
</html>