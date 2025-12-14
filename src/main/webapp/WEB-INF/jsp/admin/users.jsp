<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Manage Users</title>

    <!-- Bootstrap + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body { font-family: 'Poppins', sans-serif; background: #f5f7fb; }

        /* Sidebar */
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

        /* Content */
        .content {
            margin-left: 270px;
            padding: 25px;
        }

        /* Table Wrapper */
        .table-wrapper {
            background: white;
            padding: 25px;
            border-radius: 14px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        thead { background: #e5e7eb; }

        .btn-delete {
            padding: 5px 12px;
            font-size: 13px;
            border-radius: 20px;
        }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h4 class="text-center fw-bold mb-4">⚙ Admin Panel</h4>

    <a href="dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/products" ><i class="bi bi-box-seam"></i> Manage Products</a>
    <a href="${pageContext.request.contextPath}/admin/orders"><i class="bi bi-cart-check"></i> Manage Orders</a>
        <a href="${pageContext.request.contextPath}/admin/users" class="active"><i class="bi bi-people"></i> Manage Users</a>

    <a href="${pageContext.request.contextPath}/logout" class="mt-3"><i class="bi bi-power text-danger"></i> Logout</a>
</div>


<!-- MAIN CONTENT -->
<div class="content">

    <h3 class="fw-bold mb-3">👥 User Management</h3>

    <div class="table-wrapper mt-3">
        <table class="table align-middle table-hover">
            <thead>
            <tr>
                <th>#ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th class="text-center">Action</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.name}</td>
                    <td>${user.email}</td>
                    <td>
                        <span class="badge bg-primary rounded-pill px-3">
                            ${user.role}
                        </span>
                    </td>

                    <td class="text-center">
                        <form action="${pageContext.request.contextPath}/admin/users/action"
                              method="post" style="display:inline-block;">
                            <input type="hidden" name="id" value="${user.id}"/>
                            <input type="hidden" name="action" value="delete"/>

                            <button class="btn btn-danger btn-sm btn-delete"
                                    onclick="return confirm('Are you sure you want to delete this user?')">
                                <i class="bi bi-trash"></i> Delete
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
