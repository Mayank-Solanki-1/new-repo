package com.ecomm.service;

import com.ecomm.dao.ProductDAO;
import com.ecomm.model.Product;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

public class CartService {

    private final ProductDAO productDAO;

    public CartService() {
        this.productDAO = new ProductDAO();
    }

    /**
     * Add product to cart with validation
     */
    public void addToCart(HttpSession session, int productId, int quantity) {
        // Get cart from session
        Map<Integer, Integer> cart = getCart(session);

        // Validate product exists
        Product product = productDAO.findById(productId);
        if (product == null) {
            throw new IllegalArgumentException("Product not found");
        }

        // Validate stock
        if (product.getStock() < quantity) {
            throw new IllegalArgumentException("Insufficient stock. Available: " + product.getStock());
        }

        // Add or update cart
        cart.put(productId, quantity);
        session.setAttribute("cart", cart);
    }

    /**
     * Remove product from cart
     */
    public void removeFromCart(HttpSession session, int productId) {
        Map<Integer, Integer> cart = getCart(session);
        cart.remove(productId);
        session.setAttribute("cart", cart);
    }

    /**
     * Update cart quantity
     */
    public void updateCartQuantity(HttpSession session, int productId, int quantity) {
        Map<Integer, Integer> cart = getCart(session);

        // Validate stock
        Product product = productDAO.findById(productId);
        if (product != null && product.getStock() >= quantity) {
            cart.put(productId, quantity);
            session.setAttribute("cart", cart);
        } else {
            throw new IllegalArgumentException("Insufficient stock");
        }
    }

    /**
     * Get cart from session
     */
    public Map<Integer, Integer> getCart(HttpSession session) {
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    /**
     * Calculate cart total
     */
    public double calculateCartTotal(Map<Integer, Integer> cart) {
        double total = 0.0;

        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            Product product = productDAO.findById(entry.getKey());
            if (product != null) {
                total += product.getPrice() * entry.getValue();
            }
        }

        return total;
    }

    /**
     * Clear cart
     */
    public void clearCart(HttpSession session) {
        session.removeAttribute("cart");
    }

    /**
     * Validate cart before checkout
     */
    public boolean validateCart(Map<Integer, Integer> cart) {
        if (cart == null || cart.isEmpty()) {
            return false;
        }

        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            Product product = productDAO.findById(entry.getKey());
            if (product == null || product.getStock() < entry.getValue()) {
                return false;
            }
        }

        return true;
    }
}