package org.example.shopxVendor;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.example.shopx.DBConnection;
import java.io.File;
import java.io.IOException;
import java.sql.*;

public class vendorProductDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        int vendorID = (session != null) ? (int) session.getAttribute("vendorID") : null;
        String name = request.getParameter("name");
//        int product_id = Integer.parseInt(request.getParameter("product_id"));

        try (Connection conn = DBConnection.getConnection()) {
            //Get the image filename for the vendor
            String productImageFileName = null;
            String getImageQuery = "SELECT productImageFileName FROM products WHERE name = ?";
            try (PreparedStatement stmt = conn.prepareStatement(getImageQuery)) {
                stmt.setString(1, name);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    productImageFileName = rs.getString("productImageFileName");
                }
            }

            // Delete from products table
            String deleteVendorQuery = "DELETE FROM products WHERE name = ? AND vendorID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteVendorQuery)) {
                stmt.setString(1, name);
                stmt.setInt(1, vendorID);
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
        response.sendRedirect("index.jsp");
        request.getSession().invalidate();
    }

}
