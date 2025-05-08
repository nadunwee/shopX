package org.example.shopxVendor;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.example.shopx.DBConnection;
import java.io.File;
import java.io.IOException;
import java.sql.*;

public class vendorProductDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int vendorID;
        HttpSession session = request.getSession(false);
        if (session != null) {
            vendorID = (Integer) session.getAttribute("vendorID");
        }else{
                System.out.println("<h2>Error: You are not logged in as a vendor.</h2>");
                return;
        }

        String name = request.getParameter("name");
        int product_id = Integer.parseInt(request.getParameter("product_id"));

        try (Connection conn = DBConnection.getConnection()) {
            String productImageFileName = null;
            String getImageQuery = "SELECT productImageFileName FROM products WHERE product_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(getImageQuery)) {
                stmt.setInt(1, product_id);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    productImageFileName = rs.getString("productImageFileName");
                }
            }

            // Delete from products table
            String deleteProductsQuery = "DELETE FROM products WHERE product_id = ? AND vendorID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteProductsQuery)) {
                stmt.setInt(1, product_id);
                stmt.setInt(2, vendorID);
                stmt.executeUpdate();
            }

            // Delete the image file from photos folder
            if (productImageFileName != null) {
                String imagePath = getServletContext().getRealPath("/photos") + File.separator + productImageFileName;
                File imageFile = new File(imagePath);
                if (imageFile.exists()) {
                    imageFile.delete();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getSession().setAttribute("deleteSuccess", "You have successfully deleted the product.");
        response.sendRedirect("Vendor/vendorViewProducts.jsp");
    }

}
