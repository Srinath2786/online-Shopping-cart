package com.example.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import com.example.dao.CartItemDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(CartServlet.class.getName());
    private final CartItemDAO cartItemDAO = new CartItemDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Fetch cart items from database
            List<Map<String, Object>> items = cartItemDAO.getAllCartItems();

            // Calculate totals
            double subtotal = 0;
            for (Map<String, Object> item : items) {
                double price = ((Number) item.get("price")).doubleValue();
                int quantity = ((Number) item.get("quantity")).intValue();
                subtotal += price * quantity;
            }
            double tax = Math.round(subtotal * 0.08 * 100.0) / 100.0;
            double total = subtotal + tax;

            // Set attributes for JSP
            request.setAttribute("cartItems", items);
            request.setAttribute("cartSubtotal", subtotal);
            request.setAttribute("cartTax", tax);
            request.setAttribute("cartTotal", total);

            // Forward to JSP
            request.getRequestDispatcher("/cart.jsp").forward(request, response);

        } catch (SQLException e) {
            LOGGER.severe(String.format("Database error in GET: %s", e.getMessage()));
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Database error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "update" -> {
                    long itemId = Long.parseLong(request.getParameter("id"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    cartItemDAO.updateCartItem(itemId, quantity);
                }
                case "delete" -> {
                    long itemId = Long.parseLong(request.getParameter("id"));
                    cartItemDAO.deleteCartItem(itemId);
                }
                case "add" -> {
                    String name = request.getParameter("name");
                    String sku = request.getParameter("sku");
                    String imageUrl = request.getParameter("imageUrl");
                    double price = Double.parseDouble(request.getParameter("price"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    cartItemDAO.addCartItem(name, sku, imageUrl, price, quantity);
                }
                default -> { /* No action */ }
            }

            // Redirect back to cart
            response.sendRedirect(request.getContextPath() + "/cart");

        } catch (SQLException e) {
            LOGGER.severe(String.format("Database error in POST: %s", e.getMessage()));
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Database error: " + e.getMessage());
        }
    }
}
