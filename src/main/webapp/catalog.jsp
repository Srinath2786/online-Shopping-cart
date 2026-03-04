<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Browse Products</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:wght@500;700&family=Space+Grotesk:wght@400;500;600&display=swap" rel="stylesheet" />
    <style>
        :root {
            color-scheme: light;
            --bg: #f4f0e7;
            --card: #fefbf6;
            --ink: #1f1b16;
            --muted: #6b5f52;
            --accent: #d1643d;
            --accent-dark: #9f3b1d;
            --border: #eadfce;
            --chip: #efe3d2;
        }
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: "Space Grotesk", "Segoe UI", sans-serif;
            color: var(--ink);
            background:
                radial-gradient(600px 300px at 10% 10%, #f9f2e8 0%, transparent 60%),
                radial-gradient(600px 300px at 90% 0%, #f2e1d0 0%, transparent 55%),
                var(--bg);
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 28px 18px 56px;
        }
        .topbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 24px;
        }
        .brand h1 {
            margin: 0;
            font-family: "Fraunces", serif;
            font-size: clamp(28px, 4vw, 40px);
        }
        .brand p {
            margin: 6px 0 0;
            color: var(--muted);
        }
        .actions {
            display: flex;
            gap: 12px;
        }
        .btn {
            appearance: none;
            border: 1px solid var(--border);
            background: var(--card);
            color: var(--ink);
            padding: 10px 16px;
            border-radius: 999px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }
        .btn.primary {
            background: var(--accent);
            border-color: var(--accent);
            color: #fff;
        }
        .btn.primary:hover {
            background: var(--accent-dark);
        }
        .hero {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 20px 22px;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            gap: 14px;
            margin-bottom: 28px;
            box-shadow: 0 12px 30px rgba(36, 24, 10, 0.08);
        }
        .hero h2 {
            margin: 0 0 4px;
            font-size: 22px;
        }
        .hero p {
            margin: 0;
            color: var(--muted);
        }
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 18px;
        }
        .card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 16px;
            display: flex;
            flex-direction: column;
            gap: 14px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(36, 24, 10, 0.08);
            animation: fadeUp 0.6s ease forwards;
        }
        .card:nth-child(2) { animation-delay: 0.05s; }
        .card:nth-child(3) { animation-delay: 0.1s; }
        .card:nth-child(4) { animation-delay: 0.15s; }
        .card:nth-child(5) { animation-delay: 0.2s; }
        .card:nth-child(6) { animation-delay: 0.25s; }
        .media {
            border-radius: 14px;
            overflow: hidden;
            border: 1px solid var(--border);
            background: #fff;
        }
        .media img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            display: block;
        }
        .badge {
            position: absolute;
            top: 16px;
            left: 16px;
            background: var(--chip);
            color: var(--muted);
            font-size: 12px;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            padding: 6px 10px;
            border-radius: 999px;
            border: 1px solid var(--border);
        }
        .title {
            font-weight: 600;
            font-size: 18px;
        }
        .sku {
            color: var(--muted);
            font-size: 12px;
        }
        .desc {
            color: var(--muted);
            margin: 0;
        }
        .price {
            font-size: 18px;
            font-weight: 600;
        }
        .footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
        }
        .qty {
            width: 72px;
            padding: 8px 10px;
            border-radius: 999px;
            border: 1px solid var(--border);
            background: #fff;
        }
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(16px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @media (max-width: 720px) {
            .topbar {
                flex-direction: column;
                align-items: flex-start;
            }
            .actions {
                width: 100%;
                flex-wrap: wrap;
            }
            .hero {
                align-items: flex-start;
            }
            .footer {
                flex-direction: column;
                align-items: stretch;
            }
            .qty {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="topbar">
            <div class="brand">
                <h1>Browse Products</h1>
                <p>Curated essentials for your workspace and commute.</p>
            </div>
            <div class="actions">
                <a class="btn" href="${pageContext.request.contextPath}/cart">View cart</a>
                <a class="btn primary" href="${pageContext.request.contextPath}/cart">Checkout</a>
            </div>
        </div>

        <div class="hero">
            <div>
                <h2>New arrivals, ready to ship</h2>
                <p>Mix and match accessories designed for focus and comfort.</p>
            </div>
            <form action="${pageContext.request.contextPath}/cart" method="post">
                <input type="hidden" name="action" value="add" />
                <input type="hidden" name="name" value="Starter Bundle" />
                <input type="hidden" name="sku" value="SKU-BUNDLE" />
                <input type="hidden" name="imageUrl" value="https://picsum.photos/640/480?random=19" />
                <input type="hidden" name="price" value="199.00" />
                <input type="hidden" name="quantity" value="1" />
                <button class="btn primary" type="submit">Add bundle to cart</button>
            </form>
        </div>

        <c:choose>
            <c:when test="${empty catalogItems}">
                <div class="hero" style="margin-top: 10px;">
                    <div>
                        <h2>No products yet</h2>
                        <p>Run the schema to load sample products into the database.</p>
                    </div>
                    <a class="btn primary" href="${pageContext.request.contextPath}/cart">Go to cart</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="grid">
                    <c:forEach var="item" items="${catalogItems}">
                        <div class="card">
                            <c:if test="${not empty item.badge}">
                                <span class="badge">${item.badge}</span>
                            </c:if>
                            <div class="media">
                                <img src="${item.imageUrl}" alt="${item.name}" />
                            </div>
                            <div>
                                <div class="title">
                                    <a href="${pageContext.request.contextPath}/product?id=${item.id}" style="color: inherit; text-decoration: none;">
                                        ${item.name}
                                    </a>
                                </div>
                                <div class="sku">${item.sku}</div>
                            </div>
                            <p class="desc">${item.description}</p>
                            <div class="footer">
                                <div class="price"><fmt:formatNumber value="${item.price}" type="currency" /></div>
                                <form action="${pageContext.request.contextPath}/cart" method="post">
                                    <input type="hidden" name="action" value="add" />
                                    <input type="hidden" name="name" value="${item.name}" />
                                    <input type="hidden" name="sku" value="${item.sku}" />
                                    <input type="hidden" name="imageUrl" value="${item.imageUrl}" />
                                    <input type="hidden" name="price" value="${item.price}" />
                                    <div style="display:flex; gap:10px; align-items:center;">
                                        <input class="qty" type="number" name="quantity" min="1" value="1" aria-label="Quantity" />
                                        <button class="btn primary" type="submit">Add</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
