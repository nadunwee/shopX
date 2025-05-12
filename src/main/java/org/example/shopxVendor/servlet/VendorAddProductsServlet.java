package org.example.shopxVendor.servlet;

import org.example.shopx.DBConnection;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import org.example.shopxVendor.controller.VendorProductController;

import java.io.*;
import java.sql.*;

@MultipartConfig
public class VendorAddProductsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                response.sendRedirect("accessPages/login.jsp");
                return;
            }

            String name = request.getParameter("productName");
            String category = request.getParameter("category");
            String additional_details = request.getParameter("description");
            float price = Float.parseFloat(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            HttpSession session = request.getSession(false);
            int vendorID = (session != null) ? (int) session.getAttribute("vendorID") : null;

            //uploading a photo and displaying in a page//////////////////////////////////////////////
            Part productImage = request.getPart("productImage");
            String productImageFileName = productImage.getSubmittedFileName();
            String productImageUploadPath = getServletContext().getRealPath("/photos") + File.separator + productImageFileName;

            try {
                FileOutputStream fos = new FileOutputStream(productImageUploadPath);
                InputStream is = productImage.getInputStream();

                byte[] data = new byte[is.available()];
                is.read(data);
                fos.write(data);
                fos.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            ////////////////////////////////////////////////////////////////////////////////////////////
            boolean isInserted = VendorProductController.addProduct(name, category, additional_details, price, stock, productImageFileName, vendorID);

            if (isInserted) {
                response.getWriter().println("<script>alert('Insertion successful'); window.location.href='Vendor/vendorViewProducts.jsp';</script>");
            } else {
                response.sendRedirect("Vendor/vendorAddProducts.jsp?error=item not added");
            }


        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("accessPages/vendorRegistration.jsp?error=" + e.getMessage());
        }


    }
}
