package org.example.shopxVendor.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import org.example.shopxVendor.controller.VendorProfileController;
import org.example.shopx.DBConnection;

import java.io.*;
import java.sql.*;

@MultipartConfig
public class VendorProfileUpdateServlet extends HttpServlet {
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
            try (FileOutputStream fos = new FileOutputStream(uploadPath); InputStream is = vendorLogo.getInputStream()) {
                byte[] data = new byte[is.available()];
                is.read(data);
                fos.write(data);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        boolean isSuccess = VendorProfileController.updateData(storeName, vendorDOB, vendorAddress, email, imageFileName, username);
        if (isSuccess) {
            response.getWriter().println("<script>alert('Update successful'); window.location.href='Vendor/vendorProfilePage.jsp';</script>");
        } else {
            response.getWriter().println("<script>alert('Update failed'); window.location.href='Vendor/vendorProfilePage.jsp';</script>");
        }
    }
}
