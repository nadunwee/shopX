package org.example.shopx;

import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.example.shopx.model.*;
import org.example.shopx.model.UserDAO;
import org.example.shopxVendor.controller.VendorProfileController;
import org.example.shopxVendor.model.VendorProfileModel;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String type = request.getParameter("type");

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                response.sendRedirect("accessPages/login.jsp?error=Database%20connection%20failed");
                return;
            }

            HttpSession session = request.getSession();

            if ("vendor".equals(type)) {
// Get vendor list (should have 0 or 1 element)
                ArrayList<VendorProfileModel> vendors = VendorProfileController.getByUsername(username);

                if (!vendors.isEmpty()) {
                    VendorProfileModel vendor = vendors.getFirst(); // Get the first (and only) result

                    if (vendor.getPassword().equals(password)) {
                        // ✅ Successful login
                        session.setAttribute("username", vendor.getUsername());
                        session.setAttribute("type", "vendor");
                        session.setAttribute("vendorID", vendor.getId());

                        // If needed, you can retrieve verificationStatus here (like in your commented code)
                        // String verificationStatus = VendorDAO.getVerificationStatus(conn, vendor.getId());
                        // session.setAttribute("verificationStatus", verificationStatus);

                        response.sendRedirect("Vendor/vendorHome.jsp");
                        return;
                    }
                }
            } else {
                User user = UserDAO.authenticateUser(conn, username, password);
                if (user != null) {
                    session.setAttribute("username", user.getUsername());
                    session.setAttribute("type", "user");
                    response.sendRedirect("homePage.jsp");
                    return;
                }
            }

            response.sendRedirect("accessPages/login.jsp?error=Invalid%20credentials");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("accessPages/login.jsp?error=" + e.getMessage());
        }
    }

    private int getVendorIDByUsername(Connection conn, String username) throws Exception {
        String query = "SELECT id FROM vendors WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        }
        return -1;
    }
}
