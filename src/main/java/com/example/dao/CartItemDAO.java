package com.example.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CartItemDAO {

    public List<Map<String, Object>> getAllCartItems() throws SQLException {
        List<Map<String, Object>> items = new ArrayList<>();
        String query = "SELECT id, name, sku, image_url, price, quantity FROM cart_items";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("id", rs.getLong("id"));
                item.put("name", rs.getString("name"));
                item.put("sku", rs.getString("sku"));
                item.put("imageUrl", rs.getString("image_url"));
                item.put("price", rs.getDouble("price"));
                item.put("quantity", rs.getInt("quantity"));
                items.add(item);
            }
        }
        return items;
    }

    public void addCartItem(String name, String sku, String imageUrl, double price, int quantity) throws SQLException {
        String query = "INSERT INTO cart_items (name, sku, image_url, price, quantity) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, name);
            stmt.setString(2, sku);
            stmt.setString(3, imageUrl);
            stmt.setDouble(4, price);
            stmt.setInt(5, quantity);
            stmt.executeUpdate();
        }
    }

    public void updateCartItem(long id, int quantity) throws SQLException {
        String query = "UPDATE cart_items SET quantity = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, quantity);
            stmt.setLong(2, id);
            stmt.executeUpdate();
        }
    }

    public void deleteCartItem(long id) throws SQLException {
        String query = "DELETE FROM cart_items WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setLong(1, id);
            stmt.executeUpdate();
        }
    }
}
