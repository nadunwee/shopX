package org.example.shopxVendor.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import org.example.shopx.DBConnection;
import org.example.shopxVendor.controller.VendorProductController;

import java.io.*;
import java.sql.*;

@MultipartConfig
public class VendorProductUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int product_id = Integer.parseInt(request.getParameter("product_id"));
        String name = request.getParameter("name");
        float price = Float.parseFloat(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String additionalDetails = request.getParameter("additionalDetails");

        int vendorID;
        HttpSession session = request.getSession(false);
        if (session != null) {
            vendorID = (Integer) session.getAttribute("vendorID");
        }else{
            System.out.println("<h2>Error: You are not logged in as a vendor.</h2>");
            return;
        }
        //uploading a photo and displaying in a page//////////////////////////////////////////////
        Part productImage = request.getPart("productImage");
        String productImageFileName = productImage.getSubmittedFileName();
        String productImageUploadPath = getServletContext().getRealPath("/photos") + File.separator + productImageFileName;

        if (productImageFileName == null || productImageFileName.trim().isEmpty()) {
            try (Connection conn = DBConnection.getConnection()) {
                PreparedStatement getImgStmt = conn.prepareStatement("SELECT productImageFileName FROM products WHERE product_id = ? AND vendorID = ?");
                getImgStmt.setInt(1, product_id);
                getImgStmt.setInt(2, vendorID);
                ResultSet rs = getImgStmt.executeQuery();
                if (rs.next()) {
                    productImageFileName = rs.getString("productImageFileName");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // Save updated image
            try (FileOutputStream fos = new FileOutputStream(productImageUploadPath);
                 InputStream is = productImage.getInputStream()) {
                byte[] data = new byte[is.available()];
                is.read(data);
                fos.write(data);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        ////////////////////////////////////////////////////////////////////////////////////////////

        boolean isUpdated = VendorProductController.updateProductDetails(product_id, name, price, stock, additionalDetails, vendorID, productImageFileName);

        if(isUpdated){
            response.getWriter().println("<script>alert('Update successful'); window.location.href='Vendor/vendorViewProducts.jsp';</script>");
        }else{
            response.getWriter().println("<script>alert('Item is not updated'); window.location.href='Vendor/vendorViewProducts.jsp';</script>");
        }

    }
}
