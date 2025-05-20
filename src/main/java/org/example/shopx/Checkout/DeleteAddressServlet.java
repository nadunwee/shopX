package org.example.shopx.Checkout;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.example.shopx.Checkout.AddressModel;
import org.example.shopx.DBConnection;
import org.example.shopxVendor.controller.VendorProductController;

import java.io.File;
import java.io.IOException;
import java.sql.*;

public class DeleteAddressServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        int userId;

        // Check if the user is logged in
        if (session != null && session.getAttribute("userID") != null) {
            userId = (Integer) session.getAttribute("userID");
        } else {
            response.getWriter().println("<script>alert('You must be logged in to delete an address.'); window.location.href='login.jsp';</script>");
            return;
        }

        int addressID;

        try {
            addressID = Integer.parseInt(request.getParameter("addressID"));
        } catch (NumberFormatException e) {
            response.getWriter().println("<script>alert('Invalid address ID.'); window.location.href='checkout.jsp';</script>");
            return;
        }

        boolean isDeleted = AddressModel.deleteAddress(addressID, userId);

        if (isDeleted) {
            response.getWriter().println("<script>alert('Address deleted successfully!'); window.location.href='checkout.jsp';</script>");
        } else {
            response.getWriter().println("<script>alert('Failed to delete the address.'); window.location.href='checkout.jsp';</script>");
        }


    }

}
