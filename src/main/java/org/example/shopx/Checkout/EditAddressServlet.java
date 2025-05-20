package org.example.shopx.Checkout;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class EditAddressServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)  {

            HttpSession session = request.getSession(false);

            int userId = (int) session.getAttribute("userId");

            try {
                int addressID = Integer.parseInt(request.getParameter("addressID"));
                String fullName = request.getParameter("fullName");
                String street = request.getParameter("street");
                String city = request.getParameter("city");
                int zip = Integer.parseInt(request.getParameter("zip"));

                boolean isUpdated = AddressModel.updateAddress(addressID, userId, fullName, street, city, zip);

                if (isUpdated) {
                    response.getWriter().println("<script>alert('Address updated successfully!'); window.location.href='checkout.jsp';</script>");
                } else {
                    response.getWriter().println("<script>alert('Failed to update address.'); window.location.href='checkout.jsp';</script>");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
    }
}
