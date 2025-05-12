package org.example.shopxVendor.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.example.shopxVendor.controller.VendorProfileController;

import java.io.IOException;

public class VendorProfileDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String username = (String) request.getSession().getAttribute("username");

        try {
            // Absolute path to photos folder
            String imageFolderPath = getServletContext().getRealPath("/photos");

            boolean isDeleted = VendorProfileController.deleteVendorProfile(username, imageFolderPath);

            if(isDeleted){
                if (session != null) {
                    session.invalidate();
                }
                response.getWriter().println("<script>alert('Profile is successfully removed!'); window.location.href='index.jsp';</script>");
            }else{
                response.getWriter().println("<script>alert('Profile is not removed!'); window.location.href='Vendor/vendorProfilePage.jsp';</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();

        }

    }
}
