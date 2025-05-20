package org.example.shopx.Checkout;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.shopx.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class EditAddressServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int addressId = Integer.parseInt(request.getParameter("addressId"));

        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM delivery_address WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, addressId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                AddressModel address = new AddressModel();
                address.setAddressId(addressId);
                address.setFullname(rs.getString("full_name"));
                address.setStreet(rs.getString("street"));
                address.setCity(rs.getString("city"));
                address.setZip(rs.getInt("zip"));

                request.setAttribute("address", address);
                request.getRequestDispatcher("CheckOut/editAddress.jsp").forward(request, response);
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("checkout.jsp?error=Address+not+found");
        }
    }
}
