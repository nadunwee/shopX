package org.example.shopx;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.*;
import java.sql.Connection;

import org.example.shopx.model.*;
import org.example.shopxVendor.controller.VendorProfileController;
import org.example.shopxVendor.model.VendorProfileModel;

@MultipartConfig
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userType = request.getParameter("type");

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                response.sendRedirect("accessPages/login.jsp");
                return;
            }

            boolean success = false;

            if ("vendor".equalsIgnoreCase(userType)) {
                String password = request.getParameter("vendorPassword");
                String confirmPassword = request.getParameter("vendorConfirmPassword");
                if (!password.equals(confirmPassword)) {
                    request.setAttribute("error", "Passwords do not match.");
                    request.getRequestDispatcher("accessPages/register.jsp").forward(request, response);
                    return;
                }

                // Upload image
                Part vendorLogo = request.getPart("vendorLogo");
                String imageFileName = vendorLogo.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("/photos") + File.separator + imageFileName;

                try (FileOutputStream fos = new FileOutputStream(uploadPath);
                     InputStream is = vendorLogo.getInputStream()) {
                    byte[] data = is.readAllBytes();
                    fos.write(data);
                }

                // Build vendor profile
                VendorProfileModel vendor = new VendorProfileModel(
                        0, // id will be auto-generated
                        request.getParameter("storeName"),
                        request.getParameter("vendorUsername"),
                        request.getParameter("vendorDOB"),
                        request.getParameter("vendorEmail"),
                        password,
                        request.getParameter("vendorAddress"),
                        null, // createdAt will be handled by DB
                        imageFileName
                );

                // Use your controller to insert vendor
                success = VendorProfileController.createVendorProfile(vendor);
            } else {
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                System.out.println(username);
                System.out.println(email);
                System.out.println(password);

//                if (!InputValidator.isValidUsername(username)) {
//                    request.setAttribute("error", "Invalid username. Must be 4-20 characters and alphanumeric.");
//                    request.getRequestDispatcher("accessPages/register.jsp").forward(request, response);
//                    return;
//                }

//                if (!InputValidator.isStrongPassword(password)) {
//                    request.setAttribute("error", "Password must be at least 8 characters with uppercase, number, and symbol.");
//                    request.getRequestDispatcher("accessPages/register.jsp").forward(request, response);
//                    return;
//                }
//
//                // Password match check
//                String confirmPassword = request.getParameter("confirm-password");
//                if (!password.equals(confirmPassword)) {
//                    request.setAttribute("error", "Passwords do not match.");
//                    request.getRequestDispatcher("accessPages/register.jsp").forward(request, response);
//                    return;
//                }

                // If valid, proceed
                User user = new User(username, email, password);
                success = UserDAO.registerUser(conn, user);
            }

            if (success) {
                response.sendRedirect("accessPages/login.jsp");
            } else {
                response.sendRedirect("accessPages/register.jsp?error=Registration%20failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("accessPages/register.jsp?error=" + e.getMessage());
        }
    }
}
