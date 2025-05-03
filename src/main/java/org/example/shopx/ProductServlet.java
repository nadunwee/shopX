package org.example.shopx;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.sql.*;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String action = request.getParameter("action");
//
//        switch (action) {
//            case "create":
//                createProduct(request, response);
//                break;
//            case "update":
//                updateProduct(request, response);
//                break;
//            case "delete":
//                deleteProduct(request, response);
//                break;
//            default:
//                response.getWriter().println("Invalid action");
//        }
//    }

//    private void createProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        try (Connection conn = DBUtil.getConnection()) {
//            String sql = "INSERT INTO products (name, price, image, stock, additional_details, category, rating, vendor) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
//            PreparedStatement stmt = conn.prepareStatement(sql);
//
//            stmt.setString(1, request.getParameter("name"));
//            stmt.setBigDecimal(2, new java.math.BigDecimal(request.getParameter("price")));
//            stmt.setString(3, request.getParameter("image"));
//            stmt.setInt(4, Integer.parseInt(request.getParameter("stock")));
//            stmt.setString(5, request.getParameter("additional_details"));
//            stmt.setString(6, request.getParameter("category"));
//            stmt.setBigDecimal(7, new java.math.BigDecimal(request.getParameter("rating")));
//            stmt.setString(8, request.getParameter("vendor"));
//
//            int rows = stmt.executeUpdate();
//            response.getWriter().println(rows + " product(s) inserted.");
//        } catch (Exception e) {
//            e.printStackTrace(response.getWriter());
//        }
//    }

//    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        try (Connection conn = DBUtil.getConnection()) {
//            String sql = "UPDATE products SET name=?, price=?, image=?, stock=?, additional_details=?, category=?, rating=?, vendor=? WHERE product_id=?";
//            PreparedStatement stmt = conn.prepareStatement(sql);
//
//            stmt.setString(1, request.getParameter("name"));
//            stmt.setBigDecimal(2, new java.math.BigDecimal(request.getParameter("price")));
//            stmt.setString(3, request.getParameter("image"));
//            stmt.setInt(4, Integer.parseInt(request.getParameter("stock")));
//            stmt.setString(5, request.getParameter("additional_details"));
//            stmt.setString(6, request.getParameter("category"));
//            stmt.setBigDecimal(7, new java.math.BigDecimal(request.getParameter("rating")));
//            stmt.setString(8, request.getParameter("vendor"));
//            stmt.setInt(9, Integer.parseInt(request.getParameter("product_id")));
//
//            int rows = stmt.executeUpdate();
//            response.getWriter().println(rows + " product(s) updated.");
//        } catch (Exception e) {
//            e.printStackTrace(response.getWriter());
//        }
//    }

//    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        try (Connection conn = DBUtil.getConnection()) {
//            String sql = "DELETE FROM products WHERE product_id=?";
//            PreparedStatement stmt = conn.prepareStatement(sql);
//
//            stmt.setInt(1, Integer.parseInt(request.getParameter("product_id")));
//
//            int rows = stmt.executeUpdate();
//            response.getWriter().println(rows + " product(s) deleted.");
//        } catch (Exception e) {
//            e.printStackTrace(response.getWriter());
//        }
//    }
}
