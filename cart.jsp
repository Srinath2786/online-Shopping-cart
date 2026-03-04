<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                                        <form action="${pageContext.request.contextPath}/cart/update" method="post">
                                            <input type="hidden" name="sku" value="${item.sku}" />
                                            <input class="qty" type="number" name="quantity" min="1" value="${item.quantity}" />
                                            <button class="btn" type="submit">Update</button>
                                        </form>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${item.price * item.quantity}" type="currency" />
                                    </td>
                                    <td>
                                        <div class="actions">
                                            <form action="${pageContext.request.contextPath}/cart/remove" method="post">
                                                <input type="hidden" name="sku" value="${item.sku}" />
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
