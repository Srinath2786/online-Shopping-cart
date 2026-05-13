package com.example.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductDAO {
    public List<Map<String, Object>> getAllProducts() throws SQLException {
        List<Map<String, Object>> items = new ArrayList<>();
        String query = "SELECT id, name, sku, image_url, price, description, badge FROM products ORDER BY id";

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
                item.put("description", rs.getString("description"));
                item.put("badge", rs.getString("badge"));
                items.add(item);
            }
        }
        return items;
    }

    public Map<String, Object> getProductById(long id) throws SQLException {
        String query = "SELECT id, name, sku, image_url, price, description, badge FROM products WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Map<String, Object> item = new HashMap<>();
                    item.put("id", rs.getLong("id"));
                    item.put("name", rs.getString("name"));
                    item.put("sku", rs.getString("sku"));
                    item.put("imageUrl", rs.getString("image_url"));
                    item.put("price", rs.getDouble("price"));
                    item.put("description", rs.getString("description"));
                    item.put("badge", rs.getString("badge"));
                    return item;
                }
            }
        }
        return null;
    }
}
