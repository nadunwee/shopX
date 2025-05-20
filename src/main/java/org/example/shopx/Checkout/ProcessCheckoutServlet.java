package org.example.shopx.Checkout;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class ProcessCheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            session.setAttribute("errorMessage", "You must be logged in to complete checkout.");
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve selected delivery address
        String addressIdStr = request.getParameter("addressId");
        if (addressIdStr == null || addressIdStr.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Please select a delivery address.");
            response.sendRedirect("checkout.jsp");
            return;
        }

        int addressId = Integer.parseInt(addressIdStr);

        // Retrieve selected payment method
        String paymentMethod = request.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Please select a payment method.");
            response.sendRedirect("checkout.jsp");
            return;
        }

        // Optional: Handle card details if payment method is CARD
        if (paymentMethod.equals("CARD")) {
            String cardNumber = request.getParameter("cardNumber");
            String expiry = request.getParameter("expiry");
            String cvv = request.getParameter("cvv");

            if (cardNumber == null || expiry == null || cvv == null ||
                    cardNumber.isEmpty() || expiry.isEmpty() || cvv.isEmpty()) {
                session.setAttribute("errorMessage", "Please provide complete card details.");
                response.sendRedirect("checkout.jsp");
                return;
            }

            // Validate or store card details here (not recommended to store raw card data!)
        }

        // ✅ Continue processing the order
        // You would insert order into the database, generate an order ID, etc.
        // We'll just simulate success for now.

        session.setAttribute("successMessage", "Your order has been placed successfully!");
        response.sendRedirect("orderConfirmation.jsp");
    }
}
