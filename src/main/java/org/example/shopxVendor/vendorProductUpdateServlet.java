package org.example.shopxVendor;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import org.example.shopx.DBConnection;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.*;

@MultipartConfig
public class vendorProductUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String name = request.getParameter("name");
        float price = Float.parseFloat(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String additionalDetails = request.getParameter("additionalDetails");

        HttpSession session = request.getSession(false);
        int vendorID = (session != null) ? (int) session.getAttribute("vendorID") : null;

        int product_id = Integer.parseInt(request.getParameter("product_id"));

        //uploading a photo and displaying in a page//////////////////////////////////////////////
        Part productImage = request.getPart("productImage");
        String productImageFileName = productImage.getSubmittedFileName();
        String productImageUploadPath = getServletContext().getRealPath("/photos") + File.separator + productImageFileName;

        try{
            FileOutputStream fos = new FileOutputStream(productImageUploadPath);
            InputStream is = productImage.getInputStream();

            byte [] data = new byte[is.available()];
            is.read(data);
            fos.write(data);
            fos.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        ////////////////////////////////////////////////////////////////////////////////////////////


        try (Connection conn = DBConnection.getConnection()) {
            String query = "UPDATE products SET name = ?, price = ?, productImageFileName = ?, stock = ?, additionalDetails = ? WHERE product_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, name);
                stmt.setFloat(2, price);
                stmt.setString(3, productImageFileName);
                stmt.setInt(4, stock);
                stmt.setString(5, additionalDetails);
                stmt.setInt(6, product_id);
                stmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("Vendor/vendorViewProducts.jsp");
    }
}
