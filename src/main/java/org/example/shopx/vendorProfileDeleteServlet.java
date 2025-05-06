package org.example.shopx;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

public class vendorProfileDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");

        try (Connection conn = DBConnection.getConnection()) {
            // delete vendorpendingverifications cause of fk const.
            String deleteVerificationQuery = "DELETE FROM vendorpendingverifications WHERE vendorID = (SELECT id FROM vendors WHERE username = ?)";
            try (PreparedStatement stmt = conn.prepareStatement(deleteVerificationQuery)) {
                stmt.setString(1, username);
                stmt.executeUpdate();
            }

            // then, delete vendor acc
            String deleteVendorQuery = "DELETE FROM vendors WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteVendorQuery)) {
                stmt.setString(1, username);
                stmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getSession().setAttribute("deleteSuccess", "You have successfully deleted your ShopX vendor account.");
        response.sendRedirect("index.jsp");
        request.getSession().invalidate();

    }
}
