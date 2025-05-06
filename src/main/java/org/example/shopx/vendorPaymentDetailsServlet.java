package org.example.shopx;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class vendorPaymentDetailsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String cardType = request.getParameter("cardType");
        String cardNo = request.getParameter("cardNo");
        String cardEXP = request.getParameter("cardEXP");
        String cardCVN = request.getParameter("cardCVN");

        HttpSession session = request.getSession(false);
        int vendorID = (session != null) ? (int) session.getAttribute("vendorID") : null;

        try (Connection conn = DBConnection.getConnection()) {
            String query = "UPDATE vendorpendingverifications SET cardType = ?, cardNo = ?, cardEXP = ?, cardCVN = ?, verificationStatus = ? WHERE vendorID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, cardType);
                stmt.setString(2, cardNo);
                stmt.setString(3, cardEXP);
                stmt.setString(4, cardCVN);
                stmt.setString(5, "pending");
                stmt.setInt(6, vendorID);


                int rowsUpdated = stmt.executeUpdate();
                if (rowsUpdated > 0) {
                    session.setAttribute("verificationStatus", "pending");
                    response.sendRedirect("Vendor/vendorGetVerifiedPage.jsp");
                } else {
                    response.sendRedirect("Vendor/vendorPaymentPage.jsp?error=No matching vendor");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("Vendor/vendorPaymentPage.jsp?error=database");
        }
    }
}
