package org.example.shopxVendor;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import org.example.shopx.DBConnection;

import java.io.*;
import java.sql.*;

@MultipartConfig
public class vendorProfileUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String storeName = request.getParameter("store_name");
        String vendorDOB = request.getParameter("vendorDOB");
        String vendorAddress = request.getParameter("vendorAddress");
        String email = request.getParameter("email");

        String username = (String) request.getSession().getAttribute("username");

        Part vendorLogo = request.getPart("vendorLogo");
        String imageFileName = vendorLogo.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("/photos") + File.separator + imageFileName;

        if (imageFileName == null || imageFileName.trim().isEmpty()) {
            try (Connection conn = DBConnection.getConnection()) {
                PreparedStatement getImgStmt = conn.prepareStatement("SELECT imageFileName FROM vendors WHERE username = ?");
                getImgStmt.setString(1, username);

                ResultSet rs = getImgStmt.executeQuery();
                if (rs.next()) {
                    imageFileName = rs.getString("imageFileName");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // Save updated image
            try (FileOutputStream fos = new FileOutputStream(uploadPath);
                 InputStream is = vendorLogo.getInputStream()) {
                byte[] data = new byte[is.available()];
                is.read(data);
                fos.write(data);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }


        try (Connection conn = DBConnection.getConnection()) {
            String query = "UPDATE vendors SET store_name = ?, vendorDOB = ?, vendorAddress = ?, email = ?, imageFileName = ? WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, storeName);
                stmt.setString(2, vendorDOB);
                stmt.setString(3, vendorAddress);
                stmt.setString(4, email);
                stmt.setString(5, imageFileName);
                stmt.setString(6, username);

                stmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("Vendor/vendorProfilePage.jsp");
    }
}
