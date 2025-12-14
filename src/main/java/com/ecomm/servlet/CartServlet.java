package com.ecomm.servlet;

import com.ecomm.service.CartService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/cart", "/cart/add", "/cart/remove"})
public class CartServlet extends HttpServlet {

    private final CartService cartService = new CartService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/jsp/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();
        HttpSession session = req.getSession();

        try {
            if ("/cart/add".equals(path)) {
                int productId = Integer.parseInt(req.getParameter("productId"));
                String qtyParam = req.getParameter("quantity");
                int qty = (qtyParam == null || qtyParam.isEmpty()) ? 1 : Integer.parseInt(qtyParam);

                cartService.addToCart(session, productId, qty);

            } else if ("/cart/remove".equals(path)) {
                int productId = Integer.parseInt(req.getParameter("productId"));
                cartService.removeFromCart(session, productId);
            }

        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/cart.jsp").forward(req, resp);
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}