package com.ecomm.servlet;

import com.ecomm.service.CartService;
import com.ecomm.service.CheckoutService;
import com.ecomm.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/order/Checkout"})
public class CheckoutServlet extends HttpServlet {

    private final CartService cartService = new CartService();
    private final CheckoutService checkoutService = new CheckoutService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/jsp/order/Checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        // Validate user login
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // Validate cart
        Map<Integer, Integer> cart = cartService.getCart(session);
        if (!cartService.validateCart(cart)) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        // Get shipping info from form
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String city = req.getParameter("city");
        String state = req.getParameter("state");
        String pincode = req.getParameter("pincode");

        // Create shipping info object
        CheckoutService.ShippingInfo shippingInfo =
                new CheckoutService.ShippingInfo(fullname, phone, address, city, state, pincode);

        // Validate shipping info
        if (!checkoutService.validateShippingInfo(shippingInfo)) {
            req.setAttribute("error", "Please fill all required address fields.");
            req.getRequestDispatcher("/WEB-INF/jsp/order/Checkout.jsp").forward(req, resp);
            return;
        }

        // Calculate total using service
        double grandTotal = cartService.calculateCartTotal(cart);

        // Save to session for payment
        checkoutService.saveShippingInfo(session, fullname, phone, address, city, state, pincode);
        session.setAttribute("checkout.amount", grandTotal);

        // Redirect to payment
        resp.sendRedirect(req.getContextPath() + "/order/payment");
    }
}