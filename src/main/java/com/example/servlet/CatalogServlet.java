package com.example.servlet;

import java.io.IOException;
import java.util.List;

import com.example.dao.ProductDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/catalog")
public class CatalogServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<java.util.Map<String, Object>> items = productDAO.getAllProducts();
            request.setAttribute("catalogItems", items);
            request.getRequestDispatcher("/catalog.jsp").forward(request, response);
        } catch (java.sql.SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Database error: " + e.getMessage());
        }
    }
}
