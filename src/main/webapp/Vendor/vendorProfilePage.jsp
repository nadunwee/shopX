<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.example.shopx.DBConnection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.shopxVendor.model.VendorProfileModel" %>
<%@ page import="org.example.shopxVendor.controller.VendorProfileController" %>
<%@ page import="java.util.ArrayList" %>

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
    //image validation
    document.addEventListener("DOMContentLoaded", function () {
        const input = document.getElementById("vendorLogo");
        const counter = document.getElementById("charCount");
        const submitButton = document.querySelector("#editModal.vendor-actionBtn");
        const maxLength = 20;

        function updateCharCount() {
            if (input.files.length > 0) {
                const fileName = input.files[0].name;
                const length = fileName.length;

                if (length > maxLength) {
                    counter.textContent = "Image name exceeds 20 character limit!";
                    counter.style.color = "red";
                    submitButton.disabled = true;
                } else {
                    counter.textContent = (maxLength - length) + " characters remaining";
                    counter.style.color = "gray";
                    submitButton.disabled = false;
                }
            } else {
                counter.textContent = maxLength + " characters remaining";
                counter.style.color = "gray";
                submitButton.disabled = false;
            }
        }

        input.addEventListener("change", updateCharCount);
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

        <%
            String username = (String) request.getSession().getAttribute("username");
            ArrayList<VendorProfileModel> vendorDetails = VendorProfileController.getByUsername(username);
            VendorProfileModel vendorInfo = null;

            if (!vendorDetails.isEmpty()) {
                vendorInfo = vendorDetails.get(0);
            }
        %>
        <% if (vendorInfo != null) { %>
        <div class="vendor-profile-section">
            <div class="vendor-profile-block">
                <img src="../photos/<%= vendorInfo.getImageFileName()%>" class="vendorLOGO" alt="logo">
                <div class="vendor-profile-info">
                    <div class="vendorProfileRow">
                        <label class="vendorProfileLabel" style="font-size: 20px"><b>Store Name:</b></label>
                        <span class="vendorProfileValue"><b><%= vendorInfo.getStoreName()%></b></span>
                    </div>
                    <div class="vendorProfileRow">
                        <label class="vendorProfileLabel">User Name:</label>
                        <span class="vendorProfileValue"><%=vendorInfo.getUsername()%></span>
                    </div>
                    <div class="vendorProfileRow">
                        <label class="vendorProfileLabel">Date Of Birth:</label>
                        <span class="vendorProfileValue"><%=vendorInfo.getVendorDOB()%></span>
                    </div>
                    <div class="vendorProfileRow">
                        <label class="vendorProfileLabel">Address:</label>
                        <span class="vendorProfileValue"><%=vendorInfo.getVendorAddress()%></span>
                    </div>
                    <div class="vendorProfileRow">
                        <label class="vendorProfileLabel">Email:</label>
                        <span class="vendorProfileValue"><%=vendorInfo.getEmail()%></span>
                    </div>
                    <div class="vendorProfileRow">
                        <label class="vendorProfileLabel">Joined at:</label>
                        <span class="vendorProfileValue"><%=vendorInfo.getCreatedAt().split(" ")[0]%></span>
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
                        <form action="${pageContext.request.contextPath}/VendorProfileUpdate" method="post" enctype="multipart/form-data">
                            <div class="input-group">
                                <label>Store Name:</label>
                                <input type="text" name="store_name" value="<%=vendorInfo.getStoreName()%>"><br>
                            </div>
                            <div class="input-group">
                                <label>Date Of Birth:</label>
                                <input type="text" name="vendorDOB" value="<%=vendorInfo.getVendorDOB()%>"><br>
                            </div>
                            <div class="input-group">
                                <label>Address:</label>
                                <input type="text" name="vendorAddress" value="<%=vendorInfo.getVendorAddress()%>"><br>
                            </div>
                            <div class="input-group">
                                <label>Email:</label>
                                <input style="margin-left: 75px" type="email" name="email" value="<%=vendorInfo.getEmail()%>"><br>
                            </div>
                            <div class="input-group">
                                <label>New Image:</label>
                                <div class="prompt" style="display: flex; flex-direction: column">
                                    <input type="file" id="vendorLogo" name="vendorLogo"><br>
                                    <small id="charCount" style="color: gray;">20 characters remaining</small>
                                </div>
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
                        <form action="${pageContext.request.contextPath}/VendorProfileDelete" method="post">
                            <div class="input-group">
                                <label>Store Name:</label>
                                <input type="text" name="store_name" value="<%=vendorInfo.getStoreName()%>" readonly><br>
                            </div>
                            <div class="input-group">
                                <label>Date Of Birth:</label>
                                <input type="text" name="username" value="<%=vendorInfo.getVendorDOB()%>" readonly><br>
                            </div>
                            <div class="input-group">
                                <label>Address:</label>
                                <input type="text" name="vendorAddress" value="<%=vendorInfo.getVendorAddress()%>" readonly><br>
                            </div>
                            <div class="input-group">
                                <label>Email:</label>
                                <input style="margin-left: 75px" type="email" name="email" value="<%=vendorInfo.getEmail()%>" readonly><br>
                            </div>
                            <button type="submit" class="vendor-deleteBtn">Delete Account</button>
                        </form>
                    </div>
                </div>


            </div>
        </div>
        <% } else { %>
        <p style="color: red;">Vendor profile not found for user: <%= username %></p>
        <% } %>

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

</body>
</html>
