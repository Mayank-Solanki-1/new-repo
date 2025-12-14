<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.ecomm.model.Product" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="p" value="${product}" />

<html>
<head>
    <title>${p.name} - Details</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f7f9fc; }
        .product-info-card { @apply bg-white p-6 md:p-10 rounded-2xl shadow-xl; }
        .product-image-container { @apply aspect-w-4 aspect-h-3; }
        .product-price { @apply text-4xl font-extrabold text-blue-700; }
        .discount-badge { @apply bg-red-500 text-white text-sm font-bold px-3 py-1 rounded-full ml-4; }
        .btn-action { @apply w-full py-3 rounded-lg font-semibold transition duration-200 ease-in-out flex items-center justify-center; }
        .btn-cart { @apply bg-blue-600 text-white hover:bg-blue-700 disabled:bg-gray-400; }
        .btn-wishlist-add { @apply bg-pink-500 text-white hover:bg-pink-600; }
        .btn-wishlist-remove { @apply bg-gray-200 text-gray-700 hover:bg-gray-300; }
    </style>
</head>
<body>

<!-- Navigation/Back Button Placeholder -->
<div class="max-w-7xl mx-auto p-4 sm:p-6 lg:p-8">
    <a href="${pageContext.request.contextPath}/product/list"
       class="inline-flex items-center text-blue-600 hover:text-blue-800 transition duration-150 mb-6 font-medium">
        <i class="fas fa-arrow-left mr-2"></i> Back to Products
    </a>

    <!-- Product Detail Layout -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-10 product-info-card">

        <!-- Left Column: Image -->
        <div class="lg:sticky lg:top-8 self-start">
             <img src="${pageContext.request.contextPath}/product_images/${p.image}"
                  alt="${p.name}"
                  class="w-full h-96 object-cover rounded-xl shadow-lg"
                  onerror="this.onerror=null; this.src='https://placehold.co/600x400/a0a0a0/ffffff?text=Full+Product+View';"
            >
        </div>

        <!-- Right Column: Details and Actions -->
        <div class="flex flex-col">
            <!-- Product Name -->
            <h1 class="text-4xl font-extrabold text-gray-900 mb-4">${p.name}</h1>



            <!-- Full Description -->
            <h2 class="text-2xl font-semibold text-gray-800 mb-3">Product Description</h2>
            <p class="text-gray-600 mb-8 leading-relaxed whitespace-pre-wrap">${p.description}</p>

            <!-- Availability and Quantity -->
            <div class="mb-8 p-4 bg-gray-50 rounded-lg">
                <p class="text-lg font-medium text-gray-700">
                    Availability:
                    <span class="${p.stock > 0 ? 'text-green-600' : 'text-red-600'} font-bold ml-2">
                        ${p.stock > 0 ? 'In Stock' : 'Out of Stock'}
                    </span>
                </p>
                <c:if test="${p.stock > 0}">
                    <p class="text-sm text-gray-500 mt-1">
                        Only ${p.stock} units currently available.
                    </p>
                </c:if>
            </div>

            <!-- Action Forms -->
            <div class="space-y-4">

                <!-- Add to Cart Form -->
                <form action="${pageContext.request.contextPath}/cart/add" method="post" class="flex gap-4">
                    <input type="hidden" name="productId" value="${p.id}" />

                    <input type="number" name="quantity" value="1" min="1" max="${p.stock}"
                           class="w-1/4 p-3 text-center border-2 border-gray-300 rounded-lg focus:ring-blue-500 focus:border-blue-500 text-lg" />

                    <button class="btn-action btn-cart w-3/4" ${p.stock == 0 ? 'disabled' : ''}>
                        <i class="fas fa-cart-plus mr-2 text-xl"></i> Add to Cart
                    </button>
                </form>

                <!-- Wishlist Button Form -->
                <form action="${pageContext.request.contextPath}/buyer/wishlist" method="post">
                    <input type="hidden" name="productId" value="${p.id}" />
                    <c:choose>
                        <c:when test="${wishlistProducts != null && wishlistProducts.contains(p)}">
                            <button class="btn-action btn-wishlist-remove" name="action" value="remove">
                                <i class="fas fa-heart text-red-500 mr-2"></i> Remove from Wishlist
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button class="btn-action btn-wishlist-add" name="action" value="add">
                                <i class="far fa-heart mr-2"></i> Add to Wishlist
                            </button>
                        </c:otherwise>
                    </c:choose>
                </form>
            </div>

        </div>
    </div>
</div>

</body>
</html>