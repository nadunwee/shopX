package org.example.shopx;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.File;
import java.io.IOException;
import java.sql.*;

public class vendorProfileDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");

        try (Connection conn = DBConnection.getConnection()) {
            //Get the image filename for the vendor
            String imageFileName = null;
            String getImageQuery = "SELECT imageFileName FROM vendors WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(getImageQuery)) {
                stmt.setString(1, username);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    imageFileName = rs.getString("imageFileName");
                }
            }

            // Delete from vendorpendingverifications because of FK
            String deleteVerificationQuery = "DELETE FROM vendorpendingverifications WHERE vendorID = (SELECT id FROM vendors WHERE username = ?)";
            try (PreparedStatement stmt = conn.prepareStatement(deleteVerificationQuery)) {
                stmt.setString(1, username);
                stmt.executeUpdate();
            }

            // Delete from vendors table
            String deleteVendorQuery = "DELETE FROM vendors WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteVendorQuery)) {
                stmt.setString(1, username);
                stmt.executeUpdate();
            }

            // Delete the image file from photos folder
            if (imageFileName != null) {
                String imagePath = getServletContext().getRealPath("/photos") + File.separator + imageFileName;
                File imageFile = new File(imagePath);
                if (imageFile.exists()) {
                    imageFile.delete();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getSession().setAttribute("deleteSuccess", "You have successfully deleted your ShopX vendor account.");
        response.sendRedirect("index.jsp");
        request.getSession().invalidate();
    }

}
