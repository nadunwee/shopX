package org.example.shopxVendor.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import org.example.shopxVendor.controller.VendorSubscriptionController;
import java.io.IOException;


public class vendorSubscriptionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String companyName = request.getParameter("companyName");
        String businessAddress = request.getParameter("businessAddress");
        String businessEmail = request.getParameter("businessEmail");
        String businessContactNo = request.getParameter("businessContactNo");
        String businessRegNo = request.getParameter("businessRegNo");

        HttpSession session = request.getSession(false);
        String type = (session != null) ? (String) session.getAttribute("subscriptionType") : null;
        int vendorID = (session != null) ? (int) session.getAttribute("vendorID") : null;


        boolean isSubSuccess = VendorSubscriptionController.insertSubscriptionForm(companyName, businessAddress, businessEmail, businessContactNo, businessRegNo, type, vendorID);

        if(isSubSuccess) {
            response.sendRedirect("Vendor/vendorPaymentPage.jsp");
        }else {
            response.getWriter().println("<script>alert('Subscription request failed!'); window.location.href='Vendor/vendorSelectSubscription.jsp';</script>");
        }
    }
}
