package com.ecomm.servlet;

import com.ecomm.dao.UserDAO;
import com.ecomm.model.User;
import com.ecomm.util.PasswordUtil;
import com.ecomm.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();
    private static final String ADMIN_SECRET_KEY = "SuperSecret123";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get parameters
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirm = req.getParameter("confirm");
        String role = req.getParameter("role");
        String adminKey = req.getParameter("adminKey");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String city = req.getParameter("city");
        String state = req.getParameter("state");
        String pincode = req.getParameter("pincode");

        // Validation errors list
        List<String> errors = new ArrayList<>();

        // Validate name
        if (!ValidationUtil.isValidName(name)) {
            errors.add("Name must be between 2 and 100 characters");
        }

        // Validate email
        if (!ValidationUtil.isValidEmail(email)) {
            errors.add("Please enter a valid email address");
        }

        // Validate password
        if (!ValidationUtil.isValidPassword(password)) {
            errors.add("Password must be at least 8 characters long");
        }

        // Validate password match
        if (!password.equals(confirm)) {
            errors.add("Passwords do not match");
        }

        // Validate phone
        if (!ValidationUtil.isValidPhone(phone)) {
            errors.add("Phone number must be exactly 10 digits");
        }

        // Validate pincode
        if (!ValidationUtil.isValidPincode(pincode)) {
            errors.add("Pincode must be exactly 6 digits");
        }

        // Validate role
        if (role == null || role.trim().isEmpty()) {
            errors.add("Please select a role");
        }

        // Admin key validation
        if ("admin".equals(role)) {
            if (adminKey == null || !ADMIN_SECRET_KEY.equals(adminKey)) {
                errors.add("Invalid Admin Secret Key");
            }
        }

        // If there are validation errors, return to form
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("name", name);
            req.setAttribute("email", email);
            req.setAttribute("phone", phone);
            req.setAttribute("address", address);
            req.setAttribute("city", city);
            req.setAttribute("state", state);
            req.setAttribute("pincode", pincode);
            req.setAttribute("role", role);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        // Sanitize inputs
        name = ValidationUtil.sanitizeInput(name);
        address = ValidationUtil.sanitizeInput(address);
        city = ValidationUtil.sanitizeInput(city);
        state = ValidationUtil.sanitizeInput(state);

        // Create User object
        User u = new User();
        u.setName(name);
        u.setEmail(email);
        u.setPassword(PasswordUtil.hash(password));
        u.setRole(role);
        u.setPhone(phone);
        u.setAddress(address);
        u.setCity(city);
        u.setState(state);
        u.setPincode(pincode);

        boolean ok = userDAO.save(u);

        if (ok) {
            // Auto-login
            HttpSession session = req.getSession();
            session.setAttribute("user", u);

            // Redirect based on role
            switch (u.getRole()) {
                case "seller":
                    resp.sendRedirect(req.getContextPath() + "/seller/dashboard");
                    break;
                case "buyer":
                    resp.sendRedirect(req.getContextPath() + "/buyer/dashboard");
                    break;
                case "admin":
                    resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/index.jsp");
            }
        } else {
            req.setAttribute("error", "Registration failed. Email may already be in use.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }
}