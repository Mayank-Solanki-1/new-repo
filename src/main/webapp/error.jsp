<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error - MyStore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f5f7fa;
            font-family: 'Segoe UI', sans-serif;
        }
        .error-container {
            max-width: 600px;
            margin: 100px auto;
            padding: 40px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-align: center;
        }
        .error-icon {
            font-size: 80px;
            color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">⚠️</div>
        <h2 class="mt-3">Oops! Something Went Wrong</h2>
        <p class="text-muted mt-3">
            <c:choose>
                <c:when test="${not empty error}">
                    ${error}
                </c:when>
                <c:otherwise>
                    An unexpected error occurred. Please try again.
                </c:otherwise>
            </c:choose>
        </p>
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary me-2">Go Home</a>
            <a href="javascript:history.back()" class="btn btn-outline-secondary">Go Back</a>
        </div>
    </div>
</body>
</html>