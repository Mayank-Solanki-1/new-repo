<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Sales History</title>

    <!-- Bootstrap + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f5f7fb;
        }

        .navbar-custom {
            background: #0f172a;
            padding: 14px 20px;
        }
        .navbar-custom a {
            color: #f1f5f9;
            text-decoration: none;
            font-weight: 500;
            font-size: 15px;
        }

        .container-box {
            background: white;
            padding: 25px;
            border-radius: 14px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.08);
        }

        .table thead {
            background: #e2e8f0;
            font-weight: 600;
        }

        .badge-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
        }

        .badge-paid {
                            background-color: #28a745 !important;
                        }
        .badge-unpaid {
                     background-color: #dc3545 !important;



        .btn-back {
            background: none;
            border: none;
            color: #2563eb;
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 10px;
            cursor: pointer;
        }
        .btn-back:hover {
            text-decoration: underline;
            color: #1d4ed8;
        }
    </style>
</head>

<body>

<!-- SELLER NAVBAR -->
<nav class="navbar navbar-dark bg-primary p-3 shadow">
  <span class="navbar-brand">Seller Portal</span>

</nav>

<div class="container mt-3">

    <button onclick="history.back()" class="btn-back">
        ← Back
    </button>

    <div class="container-box mt-2">

        <h3 class="fw-bold mb-3">📊 Sales History</h3>

        <table class="table table-hover align-middle">
            <thead>
            <tr>
                <th>Order #</th>
                <th>Product</th>
                <th>Qty</th>
                <th>Unit Price (₹)</th>
                <th>Total (₹)</th>
                <th>Status</th>
                <th>Date</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="i" items="${items}">
                <tr>
                    <td>${i.orderId}</td>
                    <td>${i.productName}</td>
                    <td>${i.quantity}</td>
                    <td>₹ ${i.unitPrice}</td>
                    <td><strong>₹ ${i.quantity * i.unitPrice}</strong></td>

                    <td>
                        <c:choose>
                            <c:when test="${i.status == 'Paid'}">
                                <span class="badge-status badge-paid px-3 py-2">Paid</span>
                            </c:when>

                            <c:otherwise>
                                <span class="badge-status badge-unpaid">Pending</span>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>${i.date}</td>
                </tr>
            </c:forEach>
            </tbody>

        </table>

    </div>

</div>

</body>
</html>
