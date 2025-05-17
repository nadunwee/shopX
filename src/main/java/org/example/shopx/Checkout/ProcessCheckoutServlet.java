package org.example.shopx.Checkout;

import org.example.shopx.DBConnection;
import org.example.shopx.model.CartItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ProcessCheckoutServlet  {
    public static ArrayList<OrderItems>  getCartItems(String username) {
       //DATA
        ArrayList<OrderItems> OItem = new ArrayList<OrderItems>();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM cart_items c , users u WHERE u.id=c.user_id AND username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        int orderId = rs.getInt("order_id");
                        int cartItemId = rs.getInt("cart_item_id");
                        int productId = rs.getInt("product_id");
                        int quantity = rs.getInt("quantity");
                        float price = rs.getFloat("price");
                        String productName = rs.getString("product_name");
                        String productImageFileName = rs.getString("product_image_file_name");

                        OrderItems orderItems =  new OrderItems(orderId , productId , quantity , price );
                        OItem.add(orderItems);
                    }
                }
            }

        }catch(Exception e) {
            e.printStackTrace();

        }
        return OItem;
    }

    public static boolean updateQuantity(int userId, int productId, int quantity) {
        try (Connection conn = DBConnection.getConnection()) {
            String query = "UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, quantity);
                stmt.setInt(2, userId);
                stmt.setInt(3, productId);
                return stmt.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}