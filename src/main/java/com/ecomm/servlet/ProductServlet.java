package com.ecomm.servlet;

import com.google.gson.Gson;


import com.ecomm.dao.ProductDAO;
import com.ecomm.model.Product;
import com.ecomm.model.User;

import com.ecomm.util.ValidationUtil;
import com.ecomm.exception.InvalidUserInputException;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.util.ArrayList;



import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductServlet", urlPatterns = {"/product/list", "/product/action","/product/product_details","/product/suggest","/product/search"})
@MultipartConfig
public class ProductServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();



    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action"); // Get action param
        if (action == null) {
            action = "list"; // default
        }

        String productIdStr = req.getParameter("productId");

        // --- 1️⃣ Product Details View (When productId exists) ---
        if (productIdStr != null && !productIdStr.isEmpty()) {
            try {
                int productId = Integer.parseInt(productIdStr);
                Product product = productDAO.findById(productId);

                if (product != null) {
                    req.setAttribute("product", product);
                    req.getRequestDispatcher("/WEB-INF/jsp/product/product_details.jsp").forward(req, resp);
                    return;
                } else {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                    return;
                }
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID format");
                return;
            }
        }

        // --- 2️⃣ AJAX Live Search ---
        if ("list_ajax".equals(action)) {
            String query = req.getParameter("query");
            List<Product> products = productDAO.search(query != null ? query.trim() : "");
            Gson gson = new Gson();
            resp.setContentType("application/json");
            resp.getWriter().write(gson.toJson(products));
            return;
        }

        // --- 3️⃣ Product Search / List View for normal page ---
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        String searchQuery = req.getParameter("query");
        List<Product> products;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            products = productDAO.search(searchQuery.trim());  // SEARCH FILTER
            req.setAttribute("query", searchQuery); // keep search text in input
        } else if (user != null && "seller".equals(user.getRole())) {
            products = productDAO.findBySeller(user.getId()); // seller view
        } else {
            products = productDAO.getAll(); // default listing
        }

        req.setAttribute("products", products);
        req.getRequestDispatcher("/WEB-INF/jsp/product/list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Login required");
            return;
        }

        String action = req.getParameter("action");
        if (!"admin".equals(user.getRole()) && !"seller".equals(user.getRole())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        try {
            if ("add".equals(action)) {
                try {
                    // Get parameters
                    String name = req.getParameter("name");
                    String description = req.getParameter("description");
                    String priceStr = req.getParameter("price");
                    String stockStr = req.getParameter("stock");

                    // Validate inputs
                    List<String> errors = new ArrayList<>();

                    if (!ValidationUtil.isValidName(name)) {
                        errors.add("Product name must be between 2 and 100 characters");
                    }

                    double price = 0;
                    try {
                        price = Double.parseDouble(priceStr);
                        if (!ValidationUtil.isValidPrice(price)) {
                            errors.add("Price must be between 0 and 1,000,000");
                        }
                    } catch (NumberFormatException e) {
                        errors.add("Invalid price format");
                    }

                    int stock = 0;
                    try {
                        stock = Integer.parseInt(stockStr);
                        if (!ValidationUtil.isValidStock(stock)) {
                            errors.add("Stock must be between 0 and 100,000");
                        }
                    } catch (NumberFormatException e) {
                        errors.add("Invalid stock format");
                    }

                    // Check for errors
                    if (!errors.isEmpty()) {
                        req.setAttribute("errors", errors);
                        req.setAttribute("products", productDAO.findBySeller(user.getId()));
                        req.getRequestDispatcher("/WEB-INF/jsp/seller/products.jsp").forward(req, resp);
                        return;
                    }

                    // Sanitize inputs
                    name = ValidationUtil.sanitizeInput(name);
                    description = ValidationUtil.sanitizeInput(description);

                    // Create product
                    Product p = new Product();
                    p.setSellerId(user.getId());
                    p.setName(name);
                    p.setDescription(description);
                    p.setPrice(price);
                    p.setStock(stock);

                    // Handle image upload
                    Part imagePart = req.getPart("image");
                    String fileName = imagePart.getSubmittedFileName();

                    if (fileName != null && !fileName.isEmpty()) {
                        String uploadPath = req.getServletContext().getRealPath("product_images");
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) uploadDir.mkdirs();
                        imagePart.write(uploadPath + File.separator + fileName);
                        p.setImage(fileName);
                    } else {
                        p.setImage("default.jpg");
                    }

                    productDAO.save(p);

                } catch (Exception e) {
                    req.setAttribute("error", "Failed to add product: " + e.getMessage());
                    req.setAttribute("products", productDAO.findBySeller(user.getId()));
                    req.getRequestDispatcher("/WEB-INF/jsp/seller/products.jsp").forward(req, resp);
                    return;
                }
            }

            else if ("update".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                if (canModify(user, id)) {
                    Product p = productDAO.findById(id);
                    if (p != null) {
                        p.setName(req.getParameter("name"));
                        p.setDescription(req.getParameter("description"));
                        p.setPrice(Double.parseDouble(req.getParameter("price")));
                        p.setStock(Integer.parseInt(req.getParameter("stock")));
                        Part imagePart = req.getPart("image");
                        String fileName = imagePart.getSubmittedFileName();

                        if (fileName != null && !fileName.isEmpty()) {
                            // user selected new image
                            String uploadPath = req.getServletContext().getRealPath("") + "product_images";
                            imagePart.write(uploadPath + File.separator + fileName);

                            p.setImage(fileName); // update new image
                        }
                        productDAO.update(p);
                        resp.setStatus(HttpServletResponse.SC_OK);
                    } else {
                        resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                    }
                } else {
                    resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Cannot update product");
                }

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                if (canModify(user, id)) {
                    productDAO.softDelete(id);
                    resp.setStatus(HttpServletResponse.SC_OK);
                } else {
                    resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Cannot delete product");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request");
        }
        if ("seller".equals(user.getRole())) { resp.sendRedirect(req.getContextPath() + "/seller/products");
        } else {
            resp.sendRedirect(req.getContextPath() + "/product/list"); }
    }




    private boolean canModify(User user, int productId) {
        // allow admin and all products for the seller (for testing)
        return "admin".equals(user.getRole()) || "seller".equals(user.getRole());
    }

    /*private boolean canModify(User user, int productId) {
        if ("admin".equals(user.getRole())) return true;
        Product p = productDAO.findById(productId);
        return p != null && p.getSellerId() == user.getId();
    }*/
}