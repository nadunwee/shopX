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

        session.setAttribute("successMessage", "Your order has been placed successfully!");
        response.sendRedirect("orderConfirmation.jsp");
    }
}
