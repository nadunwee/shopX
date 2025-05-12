package org.example.shopxVendor.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.example.shopx.DBConnection;
import org.example.shopxVendor.controller.VendorProductController;

import java.io.File;
import java.io.IOException;
import java.sql.*;

public class VendorProductDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int vendorID;
        HttpSession session = request.getSession(false);
        if (session != null) {
            vendorID = (Integer) session.getAttribute("vendorID");
        }else{
                System.out.println("<h2>Error: You are not logged in as a vendor.</h2>");
                return;
        }

        String name = request.getParameter("name");
        int product_id = Integer.parseInt(request.getParameter("product_id"));
        String productPhotosPath = getServletContext().getRealPath("/photos");

        boolean isDeleted = VendorProductController.vendorDeleteProduct(vendorID, name, product_id, productPhotosPath);

        if(isDeleted){
            response.getWriter().println("<script>alert('Delete successful'); window.location.href='Vendor/vendorViewProducts.jsp';</script>");
        }else{
            response.getWriter().println("<script>alert('Item is not deleted'); window.location.href='Vendor/vendorViewProducts.jsp';</script>");
        }

    }

}
