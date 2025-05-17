<%@ page import="org.example.shopx.DBConnection" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="org.example.shopxVendor.model.VendorProductModel" %>
<%@ page import="org.example.shopxVendor.controller.VendorProductController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


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
        <input type="text" class="searchInput" id="SearchInput" placeholder="Search Product" style="width: 1000px; margin-left: 100px; border: 2px solid #9026dc">
        <table class="product-table">
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
                Integer vendorIDObj = (session != null) ? (Integer) session.getAttribute("vendorID") : null;
                if (vendorIDObj == null) {
                    response.sendRedirect("../accessPages/login.jsp");
                    return;
                }
                int vendorID = vendorIDObj;
                ArrayList<VendorProductModel> vendorProductDetails = VendorProductController.getProductbyVendorID(vendorID);
            %>

            <% if (!vendorProductDetails.isEmpty()) {
                for (VendorProductModel vendorProductInfo : vendorProductDetails) {%>
            <tr style="text-align: center;">
                <td>
                    <img src="<%= request.getContextPath() + "/photos/" + vendorProductInfo.getProductImageFileName() %>"
                         alt="<%= vendorProductInfo.getProductImageFileName() %>" width="100">
                </td>
                <td><%= vendorProductInfo.getProduct_id() %>
                </td>
                <td><%= vendorProductInfo.getName() %>
                </td>
                <td><%= vendorProductInfo.getAdditional_details() %>
                </td>
                <td><%= vendorProductInfo.getCategory() %>
                </td>
                <td><%= vendorProductInfo.getPrice() %>
                </td>
                <td><%= vendorProductInfo.getStock() %>
                </td>
                <td><%= vendorProductInfo.getRating() %>
                </td>
                <td>
                    <button class="vendor-actionBtn" id="editBtn-<%=vendorProductInfo.getProduct_id()%>">Edit</button>
                    <button class="vendor-deleteBtn" id="vendor-deleteBtn-<%=vendorProductInfo.getProduct_id()%>">Delete
                    </button>
                </td>
            </tr>

            <!-- Edit Modal -->
            <div id="editModal-<%=vendorProductInfo.getProduct_id()%>" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span><br>
                    <h2>Edit Your Details</h2>
                    <form action="${pageContext.request.contextPath}/vendorProductUpdate?product_id=<%=vendorProductInfo.getProduct_id()%>"
                          method="post" enctype="multipart/form-data">
                        <div class="input-group">
                            <label>Product ID:</label>
                            <input class="editInput" type="text" name="product_id"
                                   value="<%=vendorProductInfo.getProduct_id()%>" readonly><br>
                        </div>
                        <div class="input-group">
                            <label>Product Name:</label>
                            <input class="editInput" type="text" name="name"
                                   value="<%=vendorProductInfo.getName()%>"><br>
                        </div>
                        <div class="input-group">
                            <label>Price:</label>
                            <input class="editInput" type="number" name="price" value="<%=vendorProductInfo.getPrice()%>"><br>
                        </div>
                        <div class="input-group">
                            <label>Stock:</label>
                            <input class="editInput" type="number" name="stock" value="<%=vendorProductInfo.getStock()%>"><br>
                        </div>
                        <div class="input-group">
                            <label>Description:</label>
                            <textarea name="additionalDetails"><%=vendorProductInfo.getAdditional_details()%></textarea><br>
                        </div>
                        <div class="input-group">
                            <label>Update Product Image:</label>
                            <div class="prompt" style="display: flex; flex-direction: column">
                                <input class="editInput" id="productImage" type="file" name="productImage" accept=".jpg,.jpeg,.png"><br><br>
                                <small id="charCount" style="color: gray;">20 characters remaining</small>
                            </div>

                        </div>
                        <button type="submit" class="vendor-actionBtn">Save Changes</button>
                    </form>
                </div>
            </div>

            <!-- Delete Modal -->
            <div id="deleteModal-<%=vendorProductInfo.getProduct_id()%>" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <h2>Are You Sure?</h2>
                    <form action="${pageContext.request.contextPath}/vendorProductDelete?product_id=<%=vendorProductInfo.getProduct_id()%>"
                          method="post">
                        <div class="input-group">
                            <label>Product ID:</label>
                            <input type="text" name="product_id" value="<%=vendorProductInfo.getProduct_id()%>"
                                   readonly><br>
                        </div>
                        <div class="input-group">
                            <label>Product Name:</label>
                            <input type="text" name="name" value="<%=vendorProductInfo.getName()%>" readonly><br>
                        </div>
                        <button type="submit" class="vendor-deleteBtn">Delete Item</button>
                    </form>
                </div>
            </div>


            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const editBtn = document.getElementById("editBtn-<%=vendorProductInfo.getProduct_id()%>");
                    const editModal = document.getElementById("editModal-<%=vendorProductInfo.getProduct_id()%>");

                    const deleteBtn = document.getElementById("vendor-deleteBtn-<%=vendorProductInfo.getProduct_id()%>");
                    const deleteModal = document.getElementById("deleteModal-<%=vendorProductInfo.getProduct_id()%>");

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

                //Search bar
                function searchBar(){
                    let input, filter, table, tr, td, i, j, txtValue, rowMatch;
                    input = document.getElementById("SearchInput");
                    filter = input.value.toUpperCase();
                    table = document.querySelector("table");
                    tr = table.getElementsByTagName("tr");

                    for(i = 1; i < tr.length; i++){
                        td = tr[i].getElementsByTagName("td");
                        rowMatch = false;
                        for(j = 0; j < td.length; j++){
                            if(td[j]){
                                txtValue = td[j].textContent || td[j].innerText;
                                if(txtValue.toUpperCase().indexOf(filter) > -1){
                                    rowMatch = true;
                                    break;
                                }
                            }
                        }
                        tr[i].style.display = rowMatch ? "" : "none";
                    }
                }
                document.getElementById("SearchInput").addEventListener("input", searchBar);

                //image validation
                document.addEventListener("DOMContentLoaded", function () {
                    const input = document.getElementById("productImage");
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
            <%
                }
            %>
            <% } else { %>
            <p style="color: red; margin-left: 500px; margin-top: 80px">No Products Available</p>
            <% } %>
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

</body>
</html>
