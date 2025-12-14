<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Manage Products</title>

    <!-- Bootstrap + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body { font-family: 'Poppins', sans-serif; background: #f5f7fb; }

        .sidebar {
            width: 250px;
            background: #0f172a;
            height: 100vh;
            position: fixed;
            padding-top: 30px;
            color: white;
        }

        .sidebar a {
            color: #cbd5e1;
            text-decoration: none;
            padding: 14px 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            border-radius: 8px;
            margin: 8px 15px;
            transition: 0.3s;
        }

        .sidebar a:hover { background: #334155; color: white; }
        .sidebar .active { background: #2563eb; color: white; }

        .content { margin-left: 270px; padding: 25px; }

        .table-container {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        table thead { background: #e2e8f0; font-weight: bold; }

        .product-img {
            width: 55px;
            height: 55px;
            border-radius: 10px;
            object-fit: cover;
            border: 2px solid #ddd;
        }

        .btn-delete {
            background: #ef4444;
            color: white;
            border-radius: 20px;
            padding: 6px 15px;
            font-size: 14px;
        }

        .btn-delete:hover { background: #b91c1c; }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h4 class="text-center fw-bold mb-4">⚙ Admin Panel</h4>

    <a href="dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/products" class="active"><i class="bi bi-box-seam"></i> Manage Products</a>
    <a href="${pageContext.request.contextPath}/admin/orders"><i class="bi bi-cart-check"></i> Manage Orders</a>
    <a href="${pageContext.request.contextPath}/admin/users"><i class="bi bi-people"></i> Manage Users</a>

    <a href="${pageContext.request.contextPath}/logout" class="mt-3"><i class="bi bi-power text-danger"></i> Logout</a>
</div>

<!-- PAGE CONTENT -->
<div class="content">
    <h3 class="fw-bold mb-3">📦 Manage Products</h3>

    <div class="table-container">
        <table class="table table-hover align-middle">
            <thead>
            <tr>
                <th>#ID</th>
                <th>Image</th>
                <th>Name</th>
                <th>Description</th>
                <th>Price (₹)</th>
                <th>Stock</th>
                <th>Seller</th>
                <th class="text-center">Action</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="p" items="${products}">
                <tr>
                    <td>${p.id}</td>

                    <!-- Product Image -->
                    <td>
                        <img src="${pageContext.request.contextPath}/product_images/${p.image}"
                             alt="Product Image" class="product-img"/>
                    </td>

                    <td>${p.name}</td>
                    <td>${p.description}</td>
                    <td>${p.price}</td>
                    <td>${p.stock}</td>
                    <td>${p.sellerId}</td>

                    <td class="text-center">
                        <form action="${pageContext.request.contextPath}/admin/products/action" method="post">
                            <input type="hidden" name="id" value="${p.id}"/>
                            <input type="hidden" name="action" value="delete"/>

                            <button class="btn-delete" onclick="return confirm('Delete product permanently?')">
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
