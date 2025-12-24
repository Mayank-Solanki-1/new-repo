<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.ecomm.dao.ProductDAO, com.ecomm.model.Product" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // Retaining core JSP logic to fetch and calculate cart totals
    HttpSession s = request.getSession();
    // Safely casting the cart attribute
    Map<Integer,Integer> cart = (Map<Integer,Integer>) s.getAttribute("cart");
    if (cart == null) cart = new HashMap<>();

    ProductDAO dao = new ProductDAO();
    double subTotal = 0;
    // Placeholder variables for tax and shipping have been removed as requested.
%>

<html>
<head>
    <title>Advanced Shopping Cart</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Load Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

</head>
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
</style>


<body class="bg-gray-50 text-gray-800 font-sans">
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
<div class="max-w-7xl mx-auto p-4 md:p-8">
    <h1 class="text-3xl md:text-4xl font-extrabold text-blue-800 mb-6 border-b pb-3">
        🛒 Your Shopping Cart
    </h1>

    <%
        if (cart.isEmpty()) {
    %>
        <!-- Empty Cart Message -->
        <div class="text-center py-20 bg-white rounded-xl shadow-lg border-2 border-dashed border-gray-300">
            <i class="fas fa-shopping-basket text-7xl text-gray-400 mb-4"></i>
            <h2 class="text-2xl font-semibold text-gray-600">Your Cart is Empty!</h2>
            <p class="text-gray-500 mt-2">Looks like you haven't added anything yet. Start shopping!</p>
            <a href="${pageContext.request.contextPath}/product/list"
               class="mt-6 inline-block px-8 py-3 bg-blue-600 text-white font-medium rounded-full hover:bg-blue-700 transition duration-200 shadow-md hover:shadow-lg">
                Continue Shopping
            </a>
        </div>

    <%
        } else {
    %>

    <div class="flex flex-col lg:flex-row gap-8">

        <!-- CART ITEMS (70% width on large screens) -->
        <div class="lg:w-3/4 space-y-4">
            <%
                for (Map.Entry<Integer,Integer> e : cart.entrySet()) {
                    Product p = dao.findById(e.getKey());
                    int qty = e.getValue();
                    double total = p.getPrice() * qty;
                    subTotal += total;

                    // Advanced Feature: Stock Check
                    // NOTE: Assumes the Product model has a getStock() method.
                    int stockAvailable = p.getStock();
                    boolean outOfStock = qty > stockAvailable;
            %>

            <!-- Single Cart Item Card -->
            <div class="flex flex-col sm:flex-row bg-white p-4 md:p-6 rounded-xl shadow-lg border <%= outOfStock ? "border-red-400" : "border-gray-100" %> transition duration-200 hover:shadow-xl">

                <!-- Product Image -->
                <div class="flex-shrink-0 mb-4 sm:mb-0 sm:mr-6">
                    <img src="<%=request.getContextPath()%>/product_images/<%=p.getImage()%>"
                         onerror="this.src='https:placehold.co/120x120/e0e0e0/555555?text=Item'"
                         alt="<%= p.getName() %>"
                         class="w-full h-32 sm:w-32 sm:h-32 object-cover rounded-lg border border-gray-200" />
                </div>

                <!-- Product Details and Actions -->
                <div class="flex-grow flex flex-col justify-between">

                    <div>
                        <!-- Title and Price -->
                        <div class="flex justify-between items-start">
                            <h2 class="text-xl font-bold text-gray-900 leading-tight"><%= p.getName() %></h2>
                            <span class="text-xl font-extrabold text-blue-600 ml-4">₹<%= String.format("%.2f", total) %></span>
                        </div>
                        <p class="text-sm text-gray-500 mt-1 mb-3 line-clamp-1"><%= p.getDescription() %></p>
                    </div>

                    <!-- Quantity and Action Buttons -->
                    <div class="flex flex-col space-y-3 mt-2">

                        <!-- Stock Warning Display -->
                        <% if (outOfStock) { %>
                            <div class="text-red-700 text-sm font-semibold p-2 bg-red-100 rounded-lg flex items-center border border-red-300">
                                <i class="fas fa-exclamation-triangle mr-2"></i>
                                WARNING: Only <%= stockAvailable %> available in stock! Please reduce quantity.
                            </div>
                        <% } %>

                        <div class="flex items-center space-x-4">
                            <!-- Update Quantity Form -->
                            <form action="<%=request.getContextPath()%>/cart/add" method="post" class="flex items-center space-x-2">
                                <input type="hidden" name="productId" value="<%=p.getId()%>" />
                                <label for="qty-<%=p.getId()%>" class="text-sm font-medium text-gray-700">Qty:</label>
                                <input type="number" name="quantity" id="qty-<%=p.getId()%>" value="<%=qty%>"
                                       class="w-16 px-3 py-1.5 text-center border <%= outOfStock ? "border-red-500 ring-red-200" : "border-gray-300" %> rounded-lg focus:ring-blue-500 focus:border-blue-500"
                                       min="1" max="<%= stockAvailable > 0 ? stockAvailable : 1 %>" />
                                <button type="submit"
                                        class="text-sm px-4 py-1.5 bg-green-500 text-white rounded-lg hover:bg-green-600 transition duration-150 shadow-sm">
                                    <i class="fas fa-sync-alt"></i> Update
                                </button>
                            </form>

                            <!-- Remove Button -->
                            <form action="<%=request.getContextPath()%>/cart/remove" method="post">
                                <input type="hidden" name="productId" value="<%=p.getId()%>" />
                                <button type="submit"
                                        class="text-sm px-4 py-1.5 bg-red-500 text-white rounded-lg hover:bg-red-600 transition duration-150 shadow-sm">
                                    <i class="fas fa-trash-alt"></i> Remove
                                </button>
                            </form>
                        </div>

                        <!-- Stock Status/Availability Hint -->
                        <p class="text-xs text-gray-500 mt-1">
                            Current Stock:
                            <% if (stockAvailable > 0) { %>
                                <span class="text-green-600 font-semibold"><%= stockAvailable %> available</span>
                            <% } else { %>
                                <span class="text-red-600 font-semibold">Out of Stock</span>
                            <% } %>
                        </p>
                    </div>
                </div>
            </div>

            <% }
                // Final calculation: Shipping and tax removed. Grand total is now just the subtotal.
                double grandTotal = subTotal;
            %>
        </div>

        <!-- SUMMARY BOX (30% width on large screens) -->
        <div class="lg:w-1/4">
            <div class="bg-white p-6 rounded-xl sticky top-8 shadow-2xl border-t-4 border-blue-500">
                <h2 class="text-2xl font-bold text-gray-800 mb-4 pb-2 border-b">Order Summary</h2>

                <div class="space-y-3 text-gray-600">

                    <!-- Subtotal / Order Total breakdown -->
                    <div class="flex justify-between items-center border-b pb-3">
                        <span>Subtotal (<%= cart.size() %> items):</span>
                        <span class="font-medium">₹<%= String.format("%.2f", subTotal) %></span>
                    </div>

                    <!-- Grand Total -->
                    <div class="flex justify-between items-center pt-3 text-lg font-extrabold text-gray-900">
                        <span>Order Total:</span>
                        <span class="text-xl text-blue-600">₹<%= String.format("%.2f", grandTotal) %></span>
                    </div>

                </div>

                <!-- CHECKOUT -->
                <form action="${pageContext.request.contextPath}/order/Checkout" method="get">
                    <button class="mt-6 w-full py-3 bg-indigo-600 text-white border border-transparent rounded-xl
                                   text-lg font-semibold shadow-md hover:bg-indigo-700 transition duration-200
                                   transform hover:scale-[1.01]"
                            type="submit">
                        Proceed to Checkout <i class="fas fa-arrow-right ml-2"></i>
                    </button>
                </form>
            </div>
        </div>

    </div>

    <%
        }
    %>

</div>
</div>

</body>
</html>