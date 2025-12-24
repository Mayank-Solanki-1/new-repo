<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Manage Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .action-btns form { display:inline-block; margin:0; }
        img.product-img { width:60px; height:60px; object-fit:cover; border-radius:6px; }
    </style>
</head>

<body>

<div class="container mt-4">

    <a href="${pageContext.request.contextPath}/seller/dashboard" class="btn btn-link mb-3">← Back</a>

    <h2 class="mt-2">My Product Listings</h2>

    <!-- ADD PRODUCT FORM -->
    <div class="card p-3 mb-4 bg-light">
        <h5>Add New Product</h5>
        <!-- Display validation errors -->
        <c:if test="${not empty errors}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong>Please fix the following errors:</strong>
                <ul class="mb-0 mt-2">
                    <c:forEach var="error" items="${errors}">
                        <li>${error}</li>
                    </c:forEach>
                </ul>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <form action="${pageContext.request.contextPath}/product/action"
              method="post"
              enctype="multipart/form-data"
              class="row g-2">

            <input type="hidden" name="action" value="add"/>

            <div class="col-md-3">
                <input name="name" class="form-control" placeholder="Product Name" required>
            </div>

            <div class="col-md-2">
                <input name="price" type="number" step="0.01" class="form-control" placeholder="Price" required>
            </div>

            <div class="col-md-2">
                <input name="stock" type="number" class="form-control" placeholder="Stock" required>
            </div>

            <div class="col-md-3">
                <input name="description" class="form-control" placeholder="Description">
            </div>

            <!-- ⭐ IMAGE UPLOAD -->
            <div class="col-md-2">
                <input type="file" name="image" class="form-control" accept="image/*" required>
            </div>

            <div class="col-md-1">
                <button class="btn btn-success w-100" type="submit">Add</button>
            </div>
        </form>
    </div>

    <!-- PRODUCT TABLE -->
    <table class="table table-bordered align-middle">
        <thead>
        <tr>
            <th>Image</th>
            <th>Name</th>
            <th>Price</th>
            <th>Stock</th>
            <th>Description</th>
            <th width="220">Action</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="p" items="${products}">
            <tr id="productRow${p.id}">
                <td>
                    <img src="${pageContext.request.contextPath}/product_images/${p.image}"
                         class="product-img">
                </td>
                <td class="name">${p.name}</td>
                <td class="price">₹ ${p.price}</td>
                <td class="stock">${p.stock}</td>
                <td class="description">${p.description}</td>

                <td class="action-btns">

                    <!-- EDIT BUTTON -->
                    <button type="button" class="btn btn-primary btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#editModal${p.id}">
                        Edit
                    </button>

                    <!-- DELETE BUTTON AJAX -->
                    <button type="button" class="btn btn-danger btn-sm"
                            onclick="deleteProduct(${p.id}, '${p.name}')">
                        Remove
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- EDIT MODALS -->
    <c:forEach var="p" items="${products}">
        <div class="modal fade" id="editModal${p.id}" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">

                <form class="modal-content"
                      action="${pageContext.request.contextPath}/product/action"
                      method="post" enctype="multipart/form-data">

                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${p.id}">

                    <div class="modal-header">
                        <h5 class="modal-title">Edit Product — ${p.name}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        <div class="mb-2">
                            <label class="form-label">Name</label>
                            <input name="name" class="form-control" value="${p.name}" required>
                        </div>

                        <div class="mb-2">
                            <label class="form-label">Price</label>
                            <input name="price" type="number" step="0.01" class="form-control" value="${p.price}" required>
                        </div>

                        <div class="mb-2">
                            <label class="form-label">Stock</label>
                            <input name="stock" type="number" class="form-control" value="${p.stock}" required>
                        </div>

                        <div class="mb-2">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-control" rows="2">${p.description}</textarea>
                        </div>

                        <!-- ⭐ EDIT IMAGE -->
                        <div class="mb-3">
                            <label class="form-label">Change Image</label>
                            <input type="file" name="image" class="form-control" accept="image/*">
                            <small class="text-muted">Leave empty to keep old image.</small>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-primary" type="submit">Save Changes</button>
                        <button class="btn btn-secondary" data-bs-dismiss="modal" type="button">Cancel</button>
                    </div>

                </form>
            </div>
        </div>
    </c:forEach>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>

</script>

<script>
    document.querySelector('form[action*="product/action"]').addEventListener('submit', function(e) {
        const name = this.querySelector('input[name="name"]').value.trim();
        const price = parseFloat(this.querySelector('input[name="price"]').value);
        const stock = parseInt(this.querySelector('input[name="stock"]').value);

        let errors = [];

        if (name.length < 2 || name.length > 100) {
            errors.push('Product name must be between 2 and 100 characters');
        }

        if (isNaN(price) || price <= 0 || price >= 1000000) {
            errors.push('Price must be between 0 and 1,000,000');
        }

        if (isNaN(stock) || stock < 0 || stock >= 100000) {
            errors.push('Stock must be between 0 and 100,000');
        }

        if (errors.length > 0) {
            e.preventDefault();
            alert('Please fix the following errors:\n\n' + errors.join('\n'));
            return false;
        }
    });

    // AJAX Delete (Fixed)
    function deleteProduct(id, name) {
        if (!confirm(`Remove product ${name}?`)) return;

        $.post('<c:url value="/product/action"/>',
            { action: 'delete', id: id },
            function() {
                // Hide the row instead of reloading page
                $('#productRow' + id).fadeOut(300, function() { $(this).remove(); });
            }
        ).fail(function(xhr){
            alert('Cannot delete product: ' + xhr.responseText);
        });
    }

    // AJAX Edit (same as before)
    function updateProduct(id, form) {
        const data = {
            action: 'update',
            id: id,
            name: $(form).find('[name=name]').val(),
            price: $(form).find('[name=price]').val(),
            stock: $(form).find('[name=stock]').val(),
            description: $(form).find('[name=description]').val()
        };

        $.post('<c:url value="/product/action"/>', data, function() {
            const row = $('#productRow' + id);
            row.find('.name').text(data.name);
            row.find('.price').text('₹ ' + data.price);
            row.find('.stock').text(data.stock);
            row.find('.description').text(data.description);
            $('#editModal' + id).modal('hide');
        }).fail(function(xhr){
            alert('Cannot update product: ' + xhr.responseText);
        });
    }
</script>

</body>
</html>
