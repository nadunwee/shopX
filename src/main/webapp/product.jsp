    <%@ page import="java.sql.Connection" %>
    <%@ page import="java.sql.PreparedStatement" %>
    <%@ page import="java.sql.ResultSet" %>
    <%@ page import="org.example.shopx.DBConnection" %>
    <%@ page import="java.sql.SQLException" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>
    <head>
        <title>Product Details</title>
        <link rel="stylesheet" type="text/css" href="product.css">
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>

    <%@ include file="/includes/navBar.jsp" %>

    <%
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String sessionUsername = (String) session.getAttribute("username");
            String productIdParam = request.getParameter("product_id");

            if (productIdParam == null || productIdParam.trim().isEmpty()) {
                out.println("<h2>Invalid product link. No product ID provided. <a href='index.jsp'>Go back</a></h2>");
                return;
            }

            int productId = Integer.parseInt(productIdParam);

            conn = DBConnection.getConnection();

            String sql2 = "SELECT p.*, v.store_name FROM vendors v, products p WHERE v.id = p.vendorID AND product_id = ?";
            stmt = conn.prepareStatement(sql2);
            stmt.setInt(1, productId);

            rs = stmt.executeQuery();

            if (rs.next()) {
    %>

    <div class="product-full-width">
        <div class="product-image-section">
            <img src="<%= request.getContextPath() + "/photos/" + rs.getString("productImageFileName") %>" alt="<%= rs.getString("name") %>" class="main-product-image">
        </div>

        <div class="product-details-section">
            <div class="vendor-store-name">shopX partner : <%= rs.getString("store_name") %></div>
            <p class="product-name"><%= rs.getString("name") %></p>
            <div class="price-tag">Rs. <%= rs.getFloat("price") %></div>
            <div class="availability"><%= rs.getInt("stock") %> available</div>

            <div class="btn-wrapper" style="margin-top: 10px">
                <% if (sessionUsername != null) { %>
                    <form action="${pageContext.request.contextPath}/UpdateCart" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="product_id" value="<%= rs.getInt("product_id") %>">
                        <button type="submit" class="add-to-cart-btn">🛒 Add to Cart</button>
                    </form>
                <% } else { %>
                <a href="accessPages/login.jsp?redirect=productDetails.jsp?product_id=<%= rs.getInt("product_id") %>" class="add-to-cart-btn">🛒 Add to Cart</a>

                <% } %>
            </div>

            <ul class="highlights" style="margin-top: 30px">
                <%
                    String additionalDetails = rs.getString("additional_details");
                    if (additionalDetails != null && !additionalDetails.trim().isEmpty()) {
                        String[] highlights = additionalDetails.split("\\r?\\n");
                        for (String highlight : highlights) {
                %>
                <li>✔️ <%= highlight.trim() %></li>
                <%
                    }
                } else {
                %>
                <li>✔️ No additional highlights available</li>
                <%
                    }
                %>
            </ul>

            <p class="category-heading">Belongs to shopping categories of:</p>
            <div class="category-tags">
                <span class="tag"><%= rs.getString("category") %></span>
            </div>
        </div>
    </div>

    <%
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    %>

    </body>
    </html>
