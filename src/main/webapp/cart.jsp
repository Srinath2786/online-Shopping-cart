<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.*" %>
<%
    // Demo data if none supplied by a controller
    if (request.getAttribute("cartItems") == null) {
        List<Map<String, Object>> items = new ArrayList<>();

        Map<String, Object> item1 = new HashMap<>();
        item1.put("name", "Wireless Headphones");
        item1.put("sku", "SKU-1001");
        item1.put("imageUrl", "https://picsum.photos/80?1");
        item1.put("price", 89.99);
        item1.put("quantity", 1);
        items.add(item1);

        Map<String, Object> item2 = new HashMap<>();
        item2.put("name", "Mechanical Keyboard");
        item2.put("sku", "SKU-1002");
        item2.put("imageUrl", "https://picsum.photos/80?2");
        item2.put("price", 129.50);
        item2.put("quantity", 2);
        items.add(item2);

        Map<String, Object> item3 = new HashMap<>();
        item3.put("name", "Ergonomic Mouse");
        item3.put("sku", "SKU-1003");
        item3.put("imageUrl", "https://picsum.photos/80?3");
        item3.put("price", 49.95);
        item3.put("quantity", 1);
        items.add(item3);

        double subtotal = 0;
        for (Map<String, Object> i : items) {
            double price = ((Number) i.get("price")).doubleValue();
            int quantity = ((Number) i.get("quantity")).intValue();
            subtotal += price * quantity;
        }
        double tax = Math.round(subtotal * 0.08 * 100.0) / 100.0;
        double total = subtotal + tax;

        request.setAttribute("cartItems", items);
        request.setAttribute("cartSubtotal", subtotal);
        request.setAttribute("cartTax", tax);
        request.setAttribute("cartTotal", total);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Cart</title>
    <style>
        :root {
            color-scheme: light;
            --bg: #f7f7fb;
            --card: #ffffff;
            --text: #1f2937;
            --muted: #6b7280;
            --border: #e5e7eb;
            --accent: #2563eb;
            --danger: #dc2626;
        }
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, sans-serif;
            background: var(--bg);
            color: var(--text);
        }
        .container {
            max-width: 1100px;
            margin: 32px auto;
            padding: 0 16px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .header h1 {
            margin: 0;
            font-size: 28px;
        }
        .card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            text-align: left;
            padding: 12px 8px;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }
        th {
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: var(--muted);
        }
        .item {
            display: flex;
            gap: 12px;
            align-items: center;
        }
        .thumb {
            width: 56px;
            height: 56px;
            border: 1px solid var(--border);
            border-radius: 8px;
            background: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .item-name {
            font-weight: 600;
        }
        .item-sku {
            color: var(--muted);
            font-size: 12px;
        }
        .qty {
            width: 72px;
        }
        .actions {
            display: flex;
            gap: 8px;
        }
        .btn {
            appearance: none;
            border: 1px solid var(--border);
            background: #fff;
            color: var(--text);
            padding: 8px 12px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
        }
        .btn.primary {
            background: var(--accent);
            border-color: var(--accent);
            color: #fff;
        }
        .btn.danger {
            border-color: var(--danger);
            color: var(--danger);
        }
        .summary {
            margin-top: 20px;
            display: grid;
            grid-template-columns: 1fr 280px;
            gap: 16px;
            align-items: start;
        }
        .add-item {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 12px;
            align-items: end;
            margin-bottom: 16px;
        }
        .add-item label {
            display: block;
            font-size: 12px;
            color: var(--muted);
            margin-bottom: 6px;
        }
        .add-item input {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid var(--border);
            border-radius: 8px;
        }
        .summary-card {
            padding: 16px;
            border: 1px solid var(--border);
            border-radius: 12px;
            background: #fff;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin: 8px 0;
        }
        .summary-row.total {
            font-size: 18px;
            font-weight: 700;
        }
        .empty {
            text-align: center;
            padding: 40px 20px;
            color: var(--muted);
        }
        @media (max-width: 800px) {
            .summary {
                grid-template-columns: 1fr;
            }
            .actions {
                flex-direction: column;
                align-items: stretch;
            }
            .add-item {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Your Cart</h1>
            <a class="btn" href="${pageContext.request.contextPath}/catalog">Continue Shopping</a>
        </div>

        <c:choose>
            <c:when test="${empty cartItems}">
                <div class="card empty">
                    <p>Your cart is empty.</p>
                    <a class="btn primary" href="${pageContext.request.contextPath}/catalog">Browse products</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card" style="margin-bottom: 16px;">
                    <h2 style="margin: 0 0 12px 0; font-size: 18px;">Add item</h2>
                    <form class="add-item" action="${pageContext.request.contextPath}/cart" method="post">
                        <div>
                            <label for="name">Product name</label>
                            <input id="name" name="name" type="text" placeholder="e.g., USB-C Cable" required />
                        </div>
                        <div>
                            <label for="sku">SKU</label>
                            <input id="sku" name="sku" type="text" placeholder="SKU-0000" required />
                        </div>
                        <div>
                            <label for="price">Price</label>
                            <input id="price" name="price" type="number" min="0" step="0.01" required />
                        </div>
                        <div>
                            <label for="quantity">Qty</label>
                            <input id="quantity" name="quantity" type="number" min="1" value="1" required />
                        </div>
                        <div>
                            <label for="imageUrl">Image URL</label>
                            <input id="imageUrl" name="imageUrl" type="url" placeholder="https://..." />
                        </div>
                        <div style="align-self: end;">
                            <input type="hidden" name="action" value="add" />
                            <button class="btn primary" type="submit">Add to cart</button>
                        </div>
                    </form>
                </div>
                <div class="card">
                    <table aria-label="Shopping cart">
                        <thead>
                            <tr>
                                <th>Item</th>
                                <th>Price</th>
                                <th>Qty</th>
                                <th>Subtotal</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${cartItems}">
                                <tr>
                                    <td>
                                        <div class="item">
                                            <div class="thumb">
                                                <c:choose>
                                                    <c:when test="${not empty item.imageUrl}">
                                                        <img src="${item.imageUrl}" alt="${item.name}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span>IMG</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div>
                                                <div class="item-name">${item.name}</div>
                                                <div class="item-sku">SKU: ${item.sku}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${item.price}" type="currency" />
                                    </td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/cart" method="post">
                                            <input type="hidden" name="action" value="update" />
                                            <input type="hidden" name="id" value="${item.id}" />
                                            <input class="qty" type="number" name="quantity" min="1" value="${item.quantity}" />
                                            <button class="btn" type="submit">Update</button>
                                        </form>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${item.price * item.quantity}" type="currency" />
                                    </td>
                                    <td>
                                        <div class="actions">
                                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                                <input type="hidden" name="action" value="delete" />
                                                <input type="hidden" name="id" value="${item.id}" />
                                                <button class="btn danger" type="submit">Remove</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="summary">
                    <div></div>
                    <div class="summary-card">
                        <div class="summary-row">
                            <span>Subtotal</span>
                            <span><fmt:formatNumber value="${cartSubtotal}" type="currency" /></span>
                        </div>
                        <div class="summary-row">
                            <span>Tax</span>
                            <span><fmt:formatNumber value="${cartTax}" type="currency" /></span>
                        </div>
                        <div class="summary-row total">
                            <span>Total</span>
                            <span><fmt:formatNumber value="${cartTotal}" type="currency" /></span>
                        </div>
                        <form action="${pageContext.request.contextPath}/checkout" method="get">
                            <button class="btn primary" style="width:100%; margin-top: 12px;" type="submit">Checkout</button>
                        </form>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
