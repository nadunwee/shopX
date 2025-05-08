<%@ page import="org.example.shopx.DBConnection" %>

<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    int vendorID = (session != null) ? (int) session.getAttribute("vendorID") : null;

    try {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM products WHERE vendorID = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, vendorID);
        ResultSet rs = stmt.executeQuery();
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
    <title>Vendor View Products</title>
</head>

<body>

<div class="main-layout">
    <div class="sidebar">
        <%@ include file="vendorNavBar.jsp" %>
    </div>

    <div class="content">
        <h2 class="mainTopic" style=".mainTopic; margin-left: 20px; padding: 10px">Published Products</h2>

        <table class="product-table" >
            <thead>
            <tr>
                <th>Image</th>
                <th>Product ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Category</th>
                <th>Price (Rs)</th>
                <th>Stock</th>
                <th>Rating</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                while (rs.next()) {
            %>
            <tr style="text-align: center;">
                <td>
                    <img src="<%= request.getContextPath() + "/photos/" + rs.getString("productImageFileName") %>"
                         alt="<%= rs.getString("name") %>" width="100">
                </td>
                <td><%= rs.getString("product_id") %>
                </td>
                <td><%= rs.getString("name") %>
                </td>
                <td><%= rs.getString("additional_details") %>
                </td>
                <td><%= rs.getString("category") %>
                </td>
                <td><%= rs.getFloat("price") %>
                </td>
                <td><%= rs.getInt("stock") %>
                </td>
                <td><%= rs.getFloat("rating") %>
                </td>
                <td>
                    <button class="vendor-actionBtn" id="editBtn-<%= rs.getString("product_id") %>" >Edit</button>
                    <button class="vendor-deleteBtn" id="vendor-deleteBtn-<%= rs.getString("product_id") %>">Delete
                    </button>
                </td>
            </tr>

            <!-- Edit Modal -->
            <div id="editModal-<%= rs.getInt("product_id") %>" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span><br>
                    <h2>Edit Your Details</h2>
                    <form action="${pageContext.request.contextPath}/vendorProductUpdate?product_id=<%= rs.getInt("product_id") %>" method="post" enctype="multipart/form-data">
                        <div class="input-group">
                            <label>Product ID:</label>
                            <input class="editInput" type="text" name="product_id" value="<%= rs.getInt("product_id") %>" readonly><br>
                        </div>
                        <div class="input-group">
                            <label>Product Name:</label>
                            <input class="editInput" type="text" name="name" value="<%= rs.getString("name") %>"><br>
                        </div>
                        <div class="input-group">
                            <label>Price:</label>
                            <input class="editInput" type="text" name="price" value="<%= rs.getFloat("price") %>"><br>
                        </div>
                        <div class="input-group">
                            <label>Stock:</label>
                            <input class="editInput" type="text" name="stock" value="<%= rs.getInt("stock") %>"><br>
                        </div>
                        <div class="input-group">
                            <label>Description:</label>
                            <textarea name="additionalDetails"><%= rs.getString("additional_details") %></textarea><br>
                        </div>
                        <div class="input-group">
                            <label>Update Product Image:</label>
                            <input class="editInput" type="file" name="productImage" accept=".jpg,.jpeg,.png"><br><br>
                        </div>
                        <button type="submit" class="vendor-actionBtn">Save Changes</button>
                    </form>
                </div>
            </div>

            <!-- Delete Modal -->
            <div id="deleteModal-<%= rs.getInt("product_id") %>" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <h2>Are You Sure?</h2>
                    <form action="${pageContext.request.contextPath}/vendorProductDelete?product_id=<%= rs.getInt("product_id") %>"
                          method="post">
                        <div class="input-group">
                            <label>Product ID:</label>
                            <input type="text" name="product_id" value="<%= rs.getInt("product_id") %>" readonly><br>
                        </div>
                        <div class="input-group">
                            <label>Product Name:</label>
                            <input type="text" name="name" value="<%= rs.getString("name") %>" readonly><br>
                        </div>
                        <button type="submit" class="vendor-deleteBtn">Delete Item</button>
                    </form>
                </div>
            </div>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const editBtn = document.getElementById("editBtn-<%= rs.getString("product_id") %>");
                    const editModal = document.getElementById("editModal-<%= rs.getInt("product_id") %>");

                    const deleteBtn = document.getElementById("vendor-deleteBtn-<%= rs.getString("product_id") %>");
                    const deleteModal = document.getElementById("deleteModal-<%= rs.getInt("product_id") %>");

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
            <%
                }
            %>
            </tbody>
        </table>


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

    } catch (SQLException e) {
        e.printStackTrace();
    }

%>
</body>
</html>
