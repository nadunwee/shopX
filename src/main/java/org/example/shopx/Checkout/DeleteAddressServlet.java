package org.example.shopx.Checkout;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.example.shopx.Checkout.AddressModel;

import java.io.IOException;

public class DeleteAddressServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        int userId;

        // Check if the user is logged in
        if (session != null && session.getAttribute("userID") != null) {
            userId = (Integer) session.getAttribute("userID");
        } else {
            response.getWriter().println("<script>alert('You must be logged in to delete an address.'); window.location.href='accessPages/login.jsp';</script>");
            return;
        }

        int addressID;

        try {
            // Changed from "addressID" to "addressId" to match JSP input name
            addressID = Integer.parseInt(request.getParameter("addressId"));
        } catch (NumberFormatException e) {
            response.getWriter().println("<script>alert('Invalid address ID.'); window.location.href='CheckOut/checkout.jsp';</script>");
            return;
        }

        boolean isDeleted = AddressModel.deleteDeliveryAddress(addressID, userId);

        if (isDeleted) {
            response.getWriter().println("<script>alert('Address deleted successfully!'); window.location.href='CheckOut/checkout.jsp';</script>");
        } else {
            response.getWriter().println("<script>alert('Failed to delete the address.'); window.location.href='CheckOut/checkout.jsp';</script>");
        }
    }
}
