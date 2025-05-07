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

<script>
    //edit modal
    function openModal(id) {
        document.getElementById(id).style.display = "block";
    }

    function closeModal(id) {
        document.getElementById(id).style.display = "none";
    }

</script>

<body>

<div class="main-layout">
    <div class="sidebar">
        <%@ include file="vendorNavBar.jsp" %>
    </div>

    <div class="content">
        <h2 class="mainTopic" style=".mainTopic; margin-left: 20px; padding: 10px">Published Products</h2>
        <div class="product-grid">
            <%
                while (rs.next()) {
                    session.setAttribute("vendorID", rs.getInt("vendorID"));
                    int productId = rs.getInt("product_id");
            %>
            <div class="product-block">
                <div class="product-image">
                    <img src="<%= request.getContextPath() + "/photos/" + rs.getString("productImageFileName") %>"
                         alt="<%= rs.getString("name") %>">
                </div>
                <div class="product-info">
                    <p class="title"><%= rs.getString("name") %>
                    </p>
                    <p class="price">Rs. <%= rs.getFloat("price") %>
                    </p>
                    <p class="rating">Overall rating: <%= rs.getFloat("rating") %>
                    </p>
                    <div class="action-buttons">
                        <button class="vendor-actionBtn" id="editModal-<%= rs.getInt("product_id") %>"
                                onclick="openModal('editModal-<%= rs.getInt("product_id") %>')">Edit Details
                        </button>
                        <button class="vendor-deleteBtn" id="deleteModal-<%= rs.getString("name") %>"
                                onclick="openModal('deleteModal-<%= rs.getString("name") %>')">Delete Item
                        </button>
                    </div>
                </div>
            </div>


            <div id="editModal-<%= rs.getString("name") %>" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal('editModal-<%= rs.getString("name") %>')">&times;</span>
                    <h2>Edit Your Details</h2>
                    <form action="${pageContext.request.contextPath}/vendorProductUpdate" method="post"
                          enctype="multipart/form-data">
                        <input type="hidden" name="name" value="<%= rs.getInt("product_id") %>">
                        <div class="input-group">
                            <label>Product Name:</label>
                            <input type="text" name="name" value="<%= rs.getString("name") %>"><br>
                        </div>
                        <div class="input-group">
                            <label>Price:</label>
                            <input type="text" name="price" value="<%= rs.getFloat("price") %>"><br>
                        </div>
                        <div class="input-group">
                            <label>Stock:</label>
                            <input type="text" name="stock" value="<%= rs.getInt("stock") %>"><br>
                        </div>
                        <div class="input-group">
                            <label>Description:</label>
                            <textarea name="additionalDetails"><%= rs.getString("additionalDetails") %></textarea><br>
                        </div>
                        <div class="input-group">
                            <label>Update Product Image:</label>
                            <input type="file" name="productImage" accept=".jpg,.jpeg,.png" required><br><br>
                        </div>
                        <button type="submit" class="vendor-actionBtn">Save Changes</button>
                    </form>
                </div>
            </div>

        </div>
        <div id="deleteModal-<%= rs.getString("name") %>" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal('deleteModal-<%= rs.getString("name") %>')">&times;</span>
                <h2>Are You Sure?</h2>
                <form action="${pageContext.request.contextPath}/vendorProductDelete" method="post">
                    <input type="hidden" name="product_id" value="<%= rs.getString("name") %>">
                    <div class="input-group">
                        <label>Product Name:</label>
                        <input type="text" name="name" value="<%= rs.getString("name") %>" readonly><br>
                    </div>
                    <button type="submit" class="vendor-deleteBtn">Delete Item</button>
                </form>
            </div>
        </div>
        <%
            }
        %>
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

    } catch (SQLException e) {
        e.printStackTrace();
    }

%>
</body>
</html>
