<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.ecomm.model.Product" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Product Catalog</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Load Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        /* Custom styles to ensure all cards stretch to the same height in the grid row */
        .product-card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 2rem;
            align-items: stretch; /* Crucial for making cards the same height */
        }

        /* * Search animation styles for desktop/tablet (md and up)
         * This uses max-width and opacity for a smooth slide-in effect
         */
        .search-input-wrapper {
            transition: max-width 0.3s ease-out, opacity 0.3s ease-out;
            max-width: 0;
            opacity: 0;
            margin-right: -1rem; /* Compact layout when hidden */
        }

        .search-input-wrapper.is-active {
            max-width: 300px; /* Target maximum width when active */
            opacity: 1;
            margin-right: 1rem; /* Add spacing when active */
        }

        /* Default mobile styling: search input is always visible (max-width: 767px) */
        @media (max-width: 767px) {
            .search-input-wrapper {
                max-width: 100% !important;
                opacity: 1 !important;
                margin-right: 0 !important;
                order: -1; /* Place input above buttons on mobile */
            }
            /* The toggle button serves as the submit button on mobile */
            .search-toggle-button {
                /* Display: block is needed to ensure the button is available to submit on mobile */
                display: flex;
                order: 2; /* Move icon to the right of the other utility buttons on mobile */
                background-color: rgb(59, 130, 246); /* blue-500 */
                color: white;
            }
        }
    </style>
</head>

<body class="bg-gray-50 text-gray-800 font-sans">

<div class="max-w-7xl mx-auto p-6 md:p-8">

    <!-- Main Title -->
    <div class="mb-6">
        <h1 class="text-4xl font-extrabold text-blue-800">🛍 Explore Products</h1>
    </div>

    <!-- Search Bar and Utility Buttons Container (Aligned horizontally to the right on desktop) -->
    <div class="flex flex-col md:flex-row gap-4 md:justify-end md:items-center mb-8">

        <!-- Search Widget and Toggle -->
        <div id="searchWidget" class="relative flex items-center gap-4">

            <!-- Dynamic Search Input Wrapper (The element that animates) -->
            <div id="searchWrapper"
                 class="search-input-wrapper flex items-center"
                 role="search">
                <form id="searchForm" action="${pageContext.request.contextPath}/product/list" method="GET" class="relative w-full">
                    <!-- The input field now spans the full width of its wrapper -->
                    <input id="searchBox" name="query" type="text" placeholder="Search products..."
                           value="${param.query}"
                           autocomplete="off"
                           class="w-full px-4 py-3 rounded-full border-2 border-gray-300 focus:border-blue-500 focus:ring-4 ring-blue-200 outline-none transition duration-150" />

                    <!-- Search Button inside the input field has been removed -->
                </form>
            </div>

            <!-- Single Search Icon (Toggle on desktop, Submit on mobile) -->
            <button id="searchToggle"
                    class="search-toggle-button flex-shrink-0 flex items-center justify-center w-[3rem] h-[3rem] bg-gray-200 text-gray-700 rounded-full hover:bg-gray-300 transition duration-150 transform hover:scale-105"
                    title="Search">
                <i class="fas fa-search"></i>
            </button>

            <!-- Live Suggestions - Positioned absolutely relative to the searchWidget parent div -->
            <div id="suggestions"
                 class="absolute right-0 top-full mt-2 w-64 bg-white shadow-xl rounded-lg z-10 hidden border border-gray-200 max-h-56 overflow-auto">
            </div>

        </div>

        <!-- Buttons (Wishlist and Cart) -->
        <div class="flex flex-wrap gap-4 justify-start md:justify-end">
            <!-- Wishlist Button adjusted to use py-3 for vertical height consistency with the input -->
            <a href="${pageContext.request.contextPath}/buyer/wishlist"
               class="flex items-center gap-2 px-5 py-3 bg-pink-500 hover:bg-pink-600 text-white rounded-full font-medium shadow-lg transition duration-200 ease-in-out transform hover:scale-105 hover:shadow-xl">
                <i class="fas fa-heart"></i> Wishlist
            </a>

            <!-- Cart Button adjusted to use py-3 for vertical height consistency with the input -->
            <a href="${pageContext.request.contextPath}/cart"
               class="flex items-center gap-2 px-5 py-3 bg-blue-600 hover:bg-blue-700 text-white rounded-full font-medium shadow-lg transition duration-200 ease-in-out transform hover:scale-105 hover:shadow-xl">
                <i class="fas fa-shopping-cart"></i> Cart
            </a>
        </div>

    </div>


    <!-- No Result Message -->
    <c:if test="${empty products}">
        <p class="text-center text-red-500 font-semibold text-xl py-12 border-2 border-dashed border-red-300 rounded-xl bg-red-50 mb-6">
            ❌ No products found matching your search criteria.
        </p>
    </c:if>

    <!-- Product Grid -->
    <div class="product-card-grid">

        <c:forEach var="p" items="${products}">
            <a href="${pageContext.request.contextPath}/product/product_details?productId=${p.id}"
               class="block h-full flex flex-col bg-white rounded-xl shadow-xl border border-gray-100
                      hover:shadow-2xl hover:border-blue-400 transform hover:scale-[1.02] transition duration-300">

                <!-- Product Image -->
                <div class="relative">
                    <img src="${pageContext.request.contextPath}/product_images/${p.image}"
                         onerror="this.src='https://placehold.co/400x300/a3a3a3/ffffff?text=No+Image'"
                         alt="Image of ${p.name}"
                         class="w-full h-52 object-cover rounded-t-xl" />

                    <!-- Stock Badge (Absolute Positioned) -->
                    <c:choose>
                        <c:when test="${p.stock > 0}">
                            <span class="absolute top-3 right-3 px-3 py-1 rounded-full text-xs font-bold bg-green-500 text-white shadow-md">
                                In Stock
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="absolute top-3 right-3 px-3 py-1 rounded-full text-xs font-bold bg-red-500 text-white shadow-md">
                                Out of Stock
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>


                <div class="p-5 flex flex-col justify-between flex-grow">
                    <!-- Name and Price -->
                    <div>
                        <h2 class="text-xl font-extrabold mb-1 text-gray-900 line-clamp-2">${p.name}</h2>
                        <p class="text-2xl font-black text-blue-600 mb-3">₹ ${p.price}</p>
                    </div>

                    <!-- Action/Detail Button -->
                    <div class="mt-4">
                        <span class="w-full text-center inline-block bg-blue-500 text-white py-2 rounded-lg text-sm font-semibold
                                     hover:bg-blue-600 transition duration-150">
                            View Details
                        </span>
                    </div>

                </div>
            </a>
        </c:forEach>
    </div>

</div>

<!-- JavaScript -->
<script>
    const contextPath = "${pageContext.request.contextPath}";
    const searchToggle = document.getElementById("searchToggle");
    const searchWrapper = document.getElementById("searchWrapper");
    const searchBox = document.getElementById("searchBox");
    const suggestions = document.getElementById("suggestions");

    // Identify the utility container for checking clicks outside
    const utilityContainer = searchToggle.closest('.flex.md\\:flex-row');

    function showSearch() {
        if (window.innerWidth >= 768) { // Only animate on desktop/tablet
            searchWrapper.classList.add("is-active");
            searchBox.focus();
        }
    }

    function hideSearch() {
        if (window.innerWidth >= 768) { // Only animate on desktop/tablet
            searchWrapper.classList.remove("is-active");
            suggestions.classList.add("hidden"); // Hide suggestions when closing
            searchBox.value = ""; // Optional: Clear search query on hide
        }
    }

    // Toggle search bar visibility on desktop, or submit on mobile/desktop based on content
    searchToggle.addEventListener("click", (e) => {
        e.stopPropagation();

        const isDesktop = window.innerWidth >= 768;
        const isActive = searchWrapper.classList.contains("is-active");

        if (isDesktop) {
            if (isActive) {
                if (searchBox.value.trim() !== "") {
                    // Desktop: Active and has text: Submit
                    document.getElementById("searchForm").submit();
                } else {
                    // Desktop: Active but empty: Hide
                    hideSearch();
                }
            } else {
                // Desktop: Not active: Show
                showSearch();
            }
        } else {
            // Mobile: Always submit (since the search input is always visible on mobile)
            document.getElementById("searchForm").submit();
        }
    });

    // Handle hiding the search bar when clicking outside the utility block (Desktop only)
    document.addEventListener('click', (event) => {
        if (window.innerWidth >= 768) {
            // Check if search is active and the click target is not inside the entire search widget
            const searchWidget = document.getElementById("searchWidget");
            if (searchWrapper.classList.contains("is-active") && !searchWidget.contains(event.target)) {
                 hideSearch();
            }
        }
    });

    // Ensure search input is visible on load for mobile devices
    if (window.innerWidth < 768) {
        searchWrapper.classList.add("is-active");
    }

    // Function to handle the exponential backoff for API calls
    async function fetchWithRetry(url, options = {}, retries = 3) {
        for (let i = 0; i < retries; i++) {
            try {
                const response = await fetch(url, options);
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response;
            } catch (error) {
                if (i < retries - 1) {
                    const delay = Math.pow(2, i) * 1000; // 1s, 2s, 4s
                    await new Promise(resolve => setTimeout(resolve, delay));
                } else {
                    console.error("Fetch failed after multiple retries:", error);
                    throw error;
                }
            }
        }
    }

    // Existing search box input listener
    searchBox.addEventListener("input", () => {
        let q = searchBox.value.trim();

        // Clear suggestions if the query is empty
        if (q.length < 1) {
            suggestions.classList.add("hidden");
            suggestions.innerHTML = "";
            return;
        }

        // Fetch suggestions using the retry function
        fetchWithRetry(`${contextPath}/product/suggest?query=${q}`)
            .then(res => res.json())
            .then(data => {
                suggestions.innerHTML = "";

                if (data.length === 0) {
                    suggestions.innerHTML = `<p class="p-3 text-gray-500 italic">No suggestions found.</p>`;
                } else {
                    data.forEach(item => {
                        let div = document.createElement("div");
                        div.className = "p-3 cursor-pointer hover:bg-blue-50 text-gray-800 transition duration-100 border-b border-gray-100 last:border-b-0";
                        div.innerText = item;
                        div.onclick = () => {
                            searchBox.value = item;
                            suggestions.classList.add("hidden");
                            // Optional: Submit the form immediately after selecting a suggestion
                            searchBox.closest('form').submit();
                        };
                        suggestions.appendChild(div);
                    });
                }

                suggestions.classList.remove("hidden");
            })
            .catch(error => {
                 console.error("Failed to load product suggestions.");
            });
    });

    // Hide suggestions when clicking outside
    document.addEventListener('click', (event) => {
        if (!suggestions.contains(event.target) && event.target !== searchBox) {
            suggestions.classList.add('hidden');
        }
    });

    // Show suggestions again if the box is focused and has text
    searchBox.addEventListener('focus', () => {
        if (searchBox.value.trim().length > 0 && suggestions.children.length > 0) {
             suggestions.classList.remove('hidden');
        }
    });

</script>

</body>
</html>