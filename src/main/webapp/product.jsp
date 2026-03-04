<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${product.name}</title>
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
            max-width: 1100px;
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
        .topbar h1 {
            font-family: "Fraunces", serif;
            font-size: clamp(26px, 4vw, 38px);
            margin: 0;
        }
        .topbar p {
            margin: 6px 0 0;
            color: var(--muted);
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
        .detail {
            display: grid;
            grid-template-columns: 1.1fr 0.9fr;
            gap: 24px;
            align-items: start;
        }
        .media {
            border-radius: 22px;
            overflow: hidden;
            border: 1px solid var(--border);
            background: #fff;
            box-shadow: 0 14px 30px rgba(36, 24, 10, 0.12);
        }
        .media img {
            width: 100%;
            height: 420px;
            object-fit: cover;
            display: block;
        }
        .panel {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 20px;
            box-shadow: 0 10px 26px rgba(36, 24, 10, 0.1);
            display: flex;
            flex-direction: column;
            gap: 16px;
        }
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 6px 12px;
            border-radius: 999px;
            background: var(--chip);
            color: var(--muted);
            font-size: 12px;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            border: 1px solid var(--border);
        }
        .sku {
            color: var(--muted);
            font-size: 13px;
        }
        .price {
            font-size: 22px;
            font-weight: 600;
        }
        .desc {
            color: var(--muted);
            margin: 0;
            line-height: 1.6;
        }
        .cta {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }
        .qty {
            width: 90px;
            padding: 10px 12px;
            border-radius: 999px;
            border: 1px solid var(--border);
            background: #fff;
        }
        .meta {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 12px;
        }
        .meta-card {
            border: 1px solid var(--border);
            border-radius: 14px;
            padding: 12px;
            background: #fff;
        }
        .meta-card span {
            display: block;
            font-size: 12px;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.08em;
        }
        @media (max-width: 900px) {
            .detail {
                grid-template-columns: 1fr;
            }
            .media img {
                height: 320px;
            }
            .meta {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="topbar">
            <div>
                <h1>${product.name}</h1>
                <p>Focus-ready gear, curated for your setup.</p>
            </div>
            <div class="cta">
                <a class="btn" href="${pageContext.request.contextPath}/catalog">Back to catalog</a>
                <a class="btn" href="${pageContext.request.contextPath}/cart">View cart</a>
            </div>
        </div>

        <div class="detail">
            <div class="media">
                <img src="${product.imageUrl}" alt="${product.name}" />
            </div>
            <div class="panel">
                <c:if test="${not empty product.badge}">
                    <span class="badge">${product.badge}</span>
                </c:if>
                <div class="sku">SKU: ${product.sku}</div>
                <div class="price"><fmt:formatNumber value="${product.price}" type="currency" /></div>
                <p class="desc">${product.description}</p>

                <form action="${pageContext.request.contextPath}/cart" method="post" class="cta">
                    <input type="hidden" name="action" value="add" />
                    <input type="hidden" name="name" value="${product.name}" />
                    <input type="hidden" name="sku" value="${product.sku}" />
                    <input type="hidden" name="imageUrl" value="${product.imageUrl}" />
                    <input type="hidden" name="price" value="${product.price}" />
                    <input class="qty" type="number" name="quantity" min="1" value="1" aria-label="Quantity" />
                    <button class="btn primary" type="submit">Add to cart</button>
                </form>

                <div class="meta">
                    <div class="meta-card">
                        <span>Delivery</span>
                        <strong>2-4 business days</strong>
                    </div>
                    <div class="meta-card">
                        <span>Returns</span>
                        <strong>30-day free returns</strong>
                    </div>
                    <div class="meta-card">
                        <span>Support</span>
                        <strong>Live chat 9am-6pm</strong>
                    </div>
                    <div class="meta-card">
                        <span>Warranty</span>
                        <strong>12-month coverage</strong>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
