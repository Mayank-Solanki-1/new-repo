<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Order Management</title>

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
            padding: 14px 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            border-radius: 8px;
            margin: 8px 15px;
            text-decoration: none;
            transition: 0.3s;
        }

        .sidebar a:hover { background: #334155; color: white; }
        .sidebar .active { background: #2563eb; color: white; }

        .content {
            margin-left: 270px;
            padding: 25px;
        }

        .table-wrapper {
            background: white;
            padding: 25px;
            border-radius: 14px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        thead { background: #e5e7eb; }

        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        /* Color-coded badges */
        .pending { background: #fef3c7; color: #b45309; }
        .processing { background: #e0f2fe; color: #0369a1; }
        .shipped { background: #ede9fe; color: #5b21b6; }
        .delivered { background: #dcfce7; color: #166534; }
        .cancelled { background: #fee2e2; color: #b91c1c; }

        .btn-update {
            background: #2563eb;
            border-radius: 20px;
            color: white;
            padding: 6px 15px;
            font-size: 14px;
            transition: 0.3s;
        }

        .btn-update:hover { background: #1d4ed8; }

        .badge-paid {
                    background-color: #28a745 !important;
                }
        .badge-unpaid {
             background-color: #dc3545 !important;

        .badge-refunded {
                    background-color: #0d6efd !important;
                }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h4 class="text-center fw-bold mb-4">⚙ Admin Panel</h4>

    <a href="dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/products" ><i class="bi bi-box-seam"></i> Manage Products</a>
<a href="${pageContext.request.contextPath}/admin/orders" class="active"><i class="bi bi-receipt"></i> Manage Orders</a>
    <a href="${pageContext.request.contextPath}/admin/users"><i class="bi bi-people"></i> Manage Users</a>

    <a href="${pageContext.request.contextPath}/logout" class="mt-3"><i class="bi bi-power text-danger"></i> Logout</a>
</div>


<!-- PAGE CONTENT -->
<div class="content">

    <h3 class="fw-bold mb-3">📦 Order Management</h3>

    <!-- Alerts -->
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>


    <div class="table-wrapper mt-3">
        <table class="table align-middle table-hover">
            <thead>
            <tr>
                <th>#ID</th>
                <th>Buyer</th>
                <th>Total (₹)</th>
                <th>Status</th>
                <th>Invoice</th>
                <th>Processing Stage</th>
                <th class="text-center">Action</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="o" items="${orders}">
                <tr>
                    <td>${o.id}</td>
                    <td>${o.buyerId}</td>
                    <td><strong>₹${o.totalAmount}</strong></td>

                    <!-- STATUS BADGE -->
                    <!-- PAYMENT STATUS BADGE -->
                                        <td>
                                            <c:choose>
                                                <c:when test="${o.status == 'Paid'}">
                                                    <span class="badge badge-paid px-3 py-2">Paid</span>
                                                </c:when>
                                                <c:when test="${o.status == 'Refunded'}">
                                                    <span class="badge badge-refunded px-3 py-2">Refunded</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-unpaid px-3 py-2">Unpaid</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                    <!-- Invoice -->

                    <td>
                                                       <a href="${pageContext.request.contextPath}/order/invoice?id=${o.id}"
                                                          target="_blank" class="btn btn-sm btn-success">
                                                           View Invoice
                                                       </a>


                                                    </td>

                    <!-- PROCESS -->
                    <td>${o.process}</td>

                    <td class="text-center">

                        <!-- Update Order Status Form -->
                        <form action="${pageContext.request.contextPath}/admin/orders/action"
                              method="post" class="d-flex justify-content-center align-items-center">

                            <input type="hidden" name="action" value="updateProcess"/>
                            <input type="hidden" name="id" value="${o.id}"/>

                            <select name="process" class="form-select form-select-sm w-auto me-2 rounded-pill">
                                <option value="Pending"    ${o.process == 'Pending' ? 'selected' : ''}>Pending</option>
                                <option value="Processing" ${o.process == 'Processing' ? 'selected' : ''}>Processing</option>
                                <option value="Shipped"    ${o.process == 'Shipped' ? 'selected' : ''}>Shipped</option>
                                <option value="Delivered"  ${o.process == 'Delivered' ? 'selected' : ''}>Delivered</option>
                                <option value="Cancelled"  ${o.process == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                            </select>

                            <button class="btn-update">Update</button>
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
