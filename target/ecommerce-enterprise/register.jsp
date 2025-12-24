remove option of admin from register.jsp --><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register | MyStore</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body {
            background: #f5f5f5;
            font-family: 'Segoe UI', sans-serif;
        }
        .register-container {
            max-width: 480px;
            margin: 50px auto;
            padding: 25px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        .register-title {
            font-weight: bold;
            color: #0052D4;
        }
        .btn-register {
            background-color: #0052D4;
            border: none;
        }
        .btn-register:hover {
            background-color: #003c9f;
        }
        .form-label {
            font-weight: 600;
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-custom shadow-sm" style="background: white; border-bottom: 1px solid #ddd;">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/index.jsp">MyStore</a>
        <div>
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-primary me-2">Login</a>
            <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary">Sign Up</a>
        </div>
    </div>
</nav>

<!-- REGISTER CARD -->
<div class="register-container">
    <h3 class="text-center register-title mb-3">Create Your Account</h3>
    <p class="text-center text-muted mb-4">Join MyStore and start shopping today!</p>

    <!-- Success & Error -->
    <c:if test="${param.success == '1'}">
        <div class="alert alert-success text-center">Registration successful! Please login.</div>
    </c:if>
    <!-- Display validation errors -->
    <c:if test="${not empty errors}">
        <div class="alert alert-danger">
            <strong>Please fix the following errors:</strong>
            <ul class="mb-0 mt-2">
                <c:forEach var="error" items="${errors}">
                    <li>${error}</li>
                </c:forEach>
            </ul>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger text-center">${error}</div>
    </c:if>
    <form action="${pageContext.request.contextPath}/register" method="post">

        <!-- Full Name -->
        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" name="name" class="form-control"
                   placeholder="Enter full name"
                   value="${name != null ? name : ''}"
                   required>
        </div>

        <!-- Email -->
        <div class="mb-3">
            <label class="form-label">Email Address</label>
            <input type="email" name="email" class="form-control"
                   placeholder="Enter email"
                   value="${email != null ? email : ''}"
                   required>
        </div>

        <!-- Password (do NOT preserve) -->
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control"
                   placeholder="Enter password"
                   required>
        </div>

        <!-- Confirm Password (do NOT preserve) -->
        <div class="mb-3">
            <label class="form-label">Confirm Password</label>
            <input type="password" name="confirm" class="form-control"
                   placeholder="Confirm password"
                   required>
        </div>

        <!-- Phone -->
        <div class="mb-3">
            <label class="form-label">Phone</label>
            <input type="text" name="phone" class="form-control"
                   placeholder="Enter phone number"
                   value="${phone != null ? phone : ''}"
                   required>
        </div>

        <!-- Address -->
        <div class="mb-3">
            <label class="form-label">Address</label>
            <input type="text" name="address" class="form-control"
                   placeholder="Street address"
                   value="${address != null ? address : ''}"
                   required>
        </div>

        <!-- City -->
        <div class="mb-3">
            <label class="form-label">City</label>
            <input type="text" name="city" class="form-control"
                   placeholder="City"
                   value="${city != null ? city : ''}"
                   required>
        </div>

        <!-- State -->
        <div class="mb-3">
            <label class="form-label">State</label>
            <input type="text" name="state" class="form-control"
                   placeholder="State"
                   value="${state != null ? state : ''}"
                   required>
        </div>

        <!-- Pincode -->
        <div class="mb-3">
            <label class="form-label">Pincode</label>
            <input type="text" name="pincode" class="form-control"
                   placeholder="Postal code"
                   value="${pincode != null ? pincode : ''}"
                   required>
        </div>

        <!-- Role -->
        <div class="mb-3">
            <label class="form-label">Register As</label>
            <select name="role" class="form-select" id="roleSelect" required>
                <option value="">Select Role</option>
                <option value="buyer" ${role == 'buyer' ? 'selected' : ''}>Buyer</option>
                <option value="seller" ${role == 'seller' ? 'selected' : ''}>Seller</option>
                <option value="admin" ${role == 'admin' ? 'selected' : ''}>Admin</option>
            </select>
        </div>

        <!-- Admin Secret Key -->
        <div class="mb-3" id="adminKeyDiv" style="display:${role == 'admin' ? 'block' : 'none'};">
            <label class="form-label">Admin Secret Key</label>
            <input type="password" name="adminKey" class="form-control"
                   placeholder="Enter Admin Key">
        </div>

        <!-- Submit -->
        <button type="submit" class="btn btn-register text-white w-100 py-2 mt-2">
            Create Account
        </button>

        <!-- Login Link -->
        <p class="text-center mt-3 mb-0">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login.jsp"
               class="fw-bold" style="color:#0052D4;">Login</a>
        </p>

    </form>

</div>

<footer class="text-center mt-5 py-3 bg-white shadow-sm">
    <p class="mb-0">© 2025 MyStore — All Rights Reserved</p>
</footer>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('form');

    form.addEventListener('submit', function(e) {
        let isValid = true;
        let errorMessages = [];

        // Get form values
        const name = document.querySelector('input[name="name"]').value.trim();
        const email = document.querySelector('input[name="email"]').value.trim();
        const password = document.querySelector('input[name="password"]').value;
        const confirm = document.querySelector('input[name="confirm"]').value;
        const phone = document.querySelector('input[name="phone"]').value.trim();
        const pincode = document.querySelector('input[name="pincode"]').value.trim();
        const role = document.querySelector('select[name="role"]').value;

        // Validate name (2-100 characters)
        if (name.length < 2 || name.length > 100) {
            isValid = false;
            errorMessages.push('Name must be between 2 and 100 characters');
        }

        // Validate email
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            isValid = false;
            errorMessages.push('Please enter a valid email address');
        }

        // Validate password (minimum 8 characters)
        if (password.length < 8) {
            isValid = false;
            errorMessages.push('Password must be at least 8 characters');
        }

        // Validate password match
        if (password !== confirm) {
            isValid = false;
            errorMessages.push('Passwords do not match');
        }

        // Validate phone (exactly 10 digits)
        const phoneRegex = /^[0-9]{10}$/;
        if (!phoneRegex.test(phone)) {
            isValid = false;
            errorMessages.push('Phone number must be exactly 10 digits');
        }

        // Validate pincode (exactly 6 digits)
        const pincodeRegex = /^[0-9]{6}$/;
        if (!pincodeRegex.test(pincode)) {
            isValid = false;
            errorMessages.push('Pincode must be exactly 6 digits');
        }

        // Validate role
        if (!role) {
            isValid = false;
            errorMessages.push('Please select a role');
        }

        // If validation fails, prevent submission and show errors
        if (!isValid) {
            e.preventDefault();
            alert('Please fix the following errors:\n\n' + errorMessages.join('\n'));
            return false;
        }
    });

    // Show/hide admin key field
    const roleSelect = document.getElementById('roleSelect');
    const adminKeyDiv = document.getElementById('adminKeyDiv');

    roleSelect.addEventListener('change', function() {
        if (this.value === 'admin') {
            adminKeyDiv.style.display = 'block';
        } else {
            adminKeyDiv.style.display = 'none';
        }
    });
});
</script>

</body>
</html>
