package org.example.shopx.Checkout;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class UpdateAddressServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String addressIdStr = request.getParameter("addressId");
            String zipStr = request.getParameter("zip");

            if (addressIdStr == null || zipStr == null) {
                throw new NumberFormatException("Address ID or ZIP is missing");
            }

            int addressId = Integer.parseInt(addressIdStr);
            int zip = Integer.parseInt(zipStr);

            String fullName = request.getParameter("fullName");
            String street = request.getParameter("street");
            String city = request.getParameter("city");

            AddressModel address = new AddressModel();
            address.setAddressId(addressId);
            address.setFullname(fullName);
            address.setStreet(street);
            address.setCity(city);
            address.setZip(zip);

            boolean updated = AddressModel.updateAddress(address);

            if (updated) {
                response.sendRedirect("CheckOut/checkout.jsp");
            } else {
                response.getWriter().println("Error updating address.");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().println("Invalid address ID or ZIP.");
        }
    }
}
