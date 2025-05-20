package org.example.shopx.Checkout;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class UpdateAddressServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int addressId = Integer.parseInt(request.getParameter("addressId"));
        String fullName = request.getParameter("fullName");
        String street = request.getParameter("street");
        String city = request.getParameter("city");
        int zip = Integer.parseInt(request.getParameter("zip"));

        AddressModel address = new AddressModel();
        address.setAddressId(addressId);
        address.setFullname(fullName);
        address.setStreet(street);
        address.setCity(city);
        address.setZip(zip);

        boolean updated = AddressModel.updateAddress(address); // You need this method

        if (updated) {
            response.sendRedirect("checkout.jsp");
        } else {
            response.getWriter().println("Error updating address.");
        }
    }
}
