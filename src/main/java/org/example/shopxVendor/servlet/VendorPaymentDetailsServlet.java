package org.example.shopxVendor.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import org.example.shopxVendor.controller.VendorSubscriptionController;
import java.io.IOException;

public class VendorPaymentDetailsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String cardType = request.getParameter("cardType");
        String cardNo = request.getParameter("cardNo");
        String cardEXP = request.getParameter("cardEXP");
        String cardCVN = request.getParameter("cardCVN");

        HttpSession session = request.getSession(false);
        int vendorID = (session != null) ? (int) session.getAttribute("vendorID") : null;

        boolean isPaymentSuccess = VendorSubscriptionController.paymentSystemInsertion(cardType, cardNo, cardEXP, cardCVN, vendorID);
        if(isPaymentSuccess){
            session.setAttribute("verificationStatus", "pending");
            response.getWriter().println("<script>alert('Your subscription request is successfully submitted.'); window.location.href='Vendor/vendorGetVerifiedPage.jsp';</script>");
        }else{
            response.getWriter().println("<script>alert('Payment failed!'); window.location.href='Vendor/vendorPaymentPage.jsp';</script>");
        }
    }
}
