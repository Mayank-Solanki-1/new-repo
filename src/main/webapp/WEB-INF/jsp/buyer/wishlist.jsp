<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>My Wishlist</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">


    <style>

        .sidebar {
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }

        .nav-link {
            color: #2d3436 !important;
            font-size: 15px;
        }

        .nav-link:hover {
            color: #1f8a70 !important;
            background: #eef7f3;
            border-radius: 8px;
        }


        body {
            background: #f4f6f9;
            font-family: 'Poppins', sans-serif;
        }

        .wishlist-wrapper {
            width: 85%;
            margin: 40px auto;
        }

        .wishlist-table {
            background: #fff;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        }

        table {
            width: 100%;
        }

        thead {
            background: #eef2f6;
            border-radius: 12px;
        }

        thead th {
            padding: 14px;
            font-weight: 600;
            color: #555;
        }

        tbody tr {
            transition: 0.2s ease;
        }

        tbody tr:hover {
            background: #fafafa;
        }

        td {
            padding: 15px;
            vertical-align: middle;
        }

        .product-img {
            width: 65px;
            height: 65px;
            border-radius: 12px;
            object-fit: cover;
            box-shadow: 0 4px 10px rgba(0,0,0,0.12);
        }

        .price {
            font-size: 18px;
            font-weight: bold;
            color: #2e7d32;
        }

        .btn-icon {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            border: none;
            cursor: pointer;
            font-size: 18px;
            margin: 3px;
            transition: 0.3s;
        }

        .btn-remove {
            background: #ff4757;
            color: white;
        }

        .btn-remove:hover {
            background: #c0392b;
        }

        .btn-cart {
            background: #3498db;
            color: white;
        }

        .btn-cart:hover {
            background: #216fa6;
        }

        .stock-badge {
            font-size: 13px;
            padding: 6px 12px;
            border-radius: 20px;
            color: white;
        }

        .in-stock { background: #2ecc71; }
        .out-stock { background: #e74c3c; }

        .empty {
            text-align: center;
            font-size: 22px;
            margin-top: 80px;
            color: #777;
        }

        .back-btn {
            background: #222;
            color: white;
            border-radius: 25px;
            padding: 10px 20px;
        }

        .back-btn:hover {
            background: #000;
        }
        .btn-action {
            border: none;
            padding: 8px 18px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            margin: 3px;
            transition: 0.25s ease-in-out;
        }

        .btn-add-text {
            background: #3498db;
            color: white;
        }

        .btn-add-text:hover {
            background: #1f6faf;
        }

        .btn-remove-text {
            background: #ff4757;
            color: white;
        }

        .btn-remove-text:hover {
            background: #c0392b;
        }

    </style>
</head>

<body>
<!-- BUYER SIDEBAR -->
<div class="sidebar bg-white shadow"
     style="width: 240px; height: 100vh; position: fixed; left: 0; top: 0; padding-top: 25px;">

    <h3 class="text-center fw-bold mb-4" style="color:#1f8a70;">MyStore</h3>

    <ul class="nav flex-column px-3">

        <li class="nav-item mb-2">
            <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/buyer/dashboard">
                <i class="bi bi-speedometer2 me-2"></i> Dashboard
            </a>
        </li>

        <li class="nav-item mb-2">
            <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/buyer/profile">
                <i class="bi bi-person-circle me-2"></i> Manage Profile
            </a>
        </li>

        <li class="nav-item mb-2">
            <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/product/list">
                <i class="bi bi-grid me-2"></i> Browse Products
            </a>
        </li>

        <li class="nav-item mb-2">
            <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/cart">
                <i class="bi bi-cart me-2"></i> Cart
            </a>
        </li>

        <li class="nav-item mb-2">
            <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/buyer/wishlist">
                <i class="bi bi-heart me-2"></i> Wishlist
            </a>
        </li>

        <li class="nav-item mb-2">
            <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/order/history">
                <i class="bi bi-bag-check me-2"></i> Orders
            </a>
        </li>

        <li class="nav-item mt-3">
            <a class="nav-link text-danger fw-semibold" href="${pageContext.request.contextPath}/logout">
                <i class="bi bi-box-arrow-right me-2"></i> Logout
            </a>
        </li>

    </ul>
</div>
<div style="margin-left:260px; padding:30px;">

<div class="wishlist-wrapper">

    <a href="${pageContext.request.contextPath}/buyer/dashboard" class="btn back-btn mb-3">⬅ Back</a>

    <h2 class="mb-4">❤️ My Wishlist</h2>

    <c:choose>
        <c:when test="${empty wishlistProducts}">
            <p class="empty">Your wishlist is empty 😕</p>
        </c:when>

        <c:otherwise>
            <div class="wishlist-table">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Details</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th style="text-align:center;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="product" items="${wishlistProducts}">
                        <tr>
                            <td>
                                <img src="${pageContext.request.contextPath}/product_images/${product.image}" class="product-img">
                            </td>

                            <td>
                                <strong>${product.name}</strong><br>
                                <small style="color:#888;">${product.description}</small>
                            </td>

                            <td class="price">₹${product.price}</td>

                            <td>
                                <span class="stock-badge ${product.stock > 0 ? 'in-stock' : 'out-stock'}">
                                    ${product.stock > 0 ? 'In Stock' : 'Out of Stock'}
                                </span>
                            </td>

                            <td style="text-align:center; white-space:nowrap;">

                                <!-- REMOVE BUTTON -->
                                <form action="${pageContext.request.contextPath}/buyer/wishlist" method="post" style="display:inline;">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <input type="hidden" name="action" value="remove">
                                    <button class="btn-action btn-remove-text" type="submit">Remove</button>
                                </form>

                                <!-- ADD TO CART BUTTON -->
                                <c:if test="${product.stock > 0}">
                                    <form action="${pageContext.request.contextPath}/cart/add" method="post" style="display:inline;">
                                        <input type="hidden" name="productId" value="${product.id}">
                                        <input type="hidden" name="quantity" value="1">
                                        <button class="btn-action btn-add-text" type="submit">Add to Cart</button>
                                    </form>
                                </c:if>
                            </td>

                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>

</div>
</div>

</body>
</html>
