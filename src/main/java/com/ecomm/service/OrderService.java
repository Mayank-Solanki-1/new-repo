package com.ecomm.service;

import com.ecomm.dao.OrderDAO;
import com.ecomm.dao.ProductDAO;
import com.ecomm.model.Order;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class OrderService {

    private final OrderDAO orderDAO;
    private final ProductDAO productDAO;

    public OrderService() {
        this.orderDAO = new OrderDAO();
        this.productDAO = new ProductDAO();
    }

    /**
     * Place order with full transaction management
     * Ensures atomicity: order creation + inventory reduction
     */
    public int placeOrder(int buyerId, Map<Integer, Integer> cart,
                          String phone, String address, String city,
                          String state, String pincode) throws SQLException {

        // Calculate total amount
        double totalAmount = calculateTotalAmount(cart);

        // Validate stock availability BEFORE transaction
        validateStockAvailability(cart);

        // Build order items list
        List<OrderDAO.OrderItem> orderItems = buildOrderItems(cart);

        // Execute transaction
        return orderDAO.createOrderWithItemsAndShipping(
                buyerId, totalAmount, orderItems,
                phone, address, city, state, pincode
        );
    }

    /**
     * Calculate total amount from cart
     */
    public double calculateTotalAmount(Map<Integer, Integer> cart) {
        double total = 0.0;

        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            int productId = entry.getKey();
            int quantity = entry.getValue();

            var product = productDAO.findById(productId);
            if (product != null) {
                total += product.getPrice() * quantity;
            }
        }

        return total;
    }

    /**
     * Validate stock before placing order
     */
    private void validateStockAvailability(Map<Integer, Integer> cart) throws SQLException {
        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            int productId = entry.getKey();
            int requestedQty = entry.getValue();

            var product = productDAO.findById(productId);

            if (product == null) {
                throw new SQLException("Product not found: " + productId);
            }

            if (product.getStock() < requestedQty) {
                throw new SQLException("Insufficient stock for product: " +
                        product.getName() + ". Available: " + product.getStock() +
                        ", Requested: " + requestedQty);
            }
        }
    }

    /**
     * Build order items from cart
     */
    private List<OrderDAO.OrderItem> buildOrderItems(Map<Integer, Integer> cart) {
        List<OrderDAO.OrderItem> items = new java.util.ArrayList<>();

        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            int productId = entry.getKey();
            int quantity = entry.getValue();

            var product = productDAO.findById(productId);
            if (product != null) {
                items.add(new OrderDAO.OrderItem(
                        productId,
                        quantity,
                        product.getPrice()
                ));
            }
        }

        return items;
    }

    /**
     * Get order details for buyer
     */
    public List<Order> getBuyerOrders(int buyerId) {
        return orderDAO.findByBuyer(buyerId);
    }

    /**
     * Get order by ID with items
     */
    public Order getOrderWithItems(int orderId) {
        Order order = orderDAO.getOrderById(orderId);
        if (order != null) {
            order.setItems(orderDAO.getOrderItems(orderId));
        }
        return order;
    }
}