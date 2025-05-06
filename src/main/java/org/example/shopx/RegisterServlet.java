package org.example.shopx;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.*;
import java.sql.*;

@MultipartConfig
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get user type
        String userType = request.getParameter("type");

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                response.sendRedirect("accessPages/login.jsp");
                return;
            }

            String query;
            PreparedStatement stmt;

            if ("vendor".equalsIgnoreCase(userType)) {
                // Vendor specific fields
                String vendorEmail = request.getParameter("vendorEmail");
                String vendorUsername = request.getParameter("vendorUsername");
                String storeName = request.getParameter("storeName");
                String businessId = request.getParameter("businessId");
                String vendorPassword = request.getParameter("vendorPassword");

                //uploading a photo and displaying in a page//////////////////////////////////////////////
                Part vendorLogo = request.getPart("vendorLogo");
                String imageFileName = vendorLogo.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("/photos") + File.separator + imageFileName;

                try{
                    FileOutputStream fos = new FileOutputStream(uploadPath);
                    InputStream is = vendorLogo.getInputStream();

                    byte [] data = new byte[is.available()];
                    is.read(data);
                    fos.write(data);
                    fos.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                ////////////////////////////////////////////////////////////////////////////////////////////
                if (businessId == null || businessId.trim().isEmpty()) {
                    businessId = null;
                }

                System.out.println(storeName);
                System.out.println(businessId);
                System.out.println(vendorUsername);
                System.out.println(vendorEmail);

                query = "INSERT INTO vendors (store_name, username, email, password, business_id, imageFileName) VALUES (?, ?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, storeName);
                stmt.setString(2, vendorUsername);
                stmt.setString(3, vendorEmail);
                stmt.setString(4, vendorPassword);
                stmt.setString(5, businessId);
                stmt.setString(6, imageFileName);
            } else {
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                //customer
                query = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, username);
                stmt.setString(2, email);
                stmt.setString(3, password);
            }

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("accessPages/login.jsp");
            } else {
                response.sendRedirect("accessPages/register.jsp?error=Failed%20to%20register,%20please%20try%20again.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("accessPages/vendorRegistration.jsp?error=" + e.getMessage());
        }
    }
}
