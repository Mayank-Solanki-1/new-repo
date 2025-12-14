package com.ecomm.service;

import javax.servlet.http.HttpSession;

public class CheckoutService {

    /**
     * Save shipping information to session
     */
    public void saveShippingInfo(HttpSession session, String fullname,
                                 String phone, String address,
                                 String city, String state, String pincode) {
        session.setAttribute("checkout.fullname", fullname);
        session.setAttribute("checkout.phone", phone);
        session.setAttribute("checkout.address", address);
        session.setAttribute("checkout.city", city);
        session.setAttribute("checkout.state", state);
        session.setAttribute("checkout.pincode", pincode);
    }

    /**
     * Get shipping info from session
     */
    public ShippingInfo getShippingInfo(HttpSession session) {
        return new ShippingInfo(
                (String) session.getAttribute("checkout.fullname"),
                (String) session.getAttribute("checkout.phone"),
                (String) session.getAttribute("checkout.address"),
                (String) session.getAttribute("checkout.city"),
                (String) session.getAttribute("checkout.state"),
                (String) session.getAttribute("checkout.pincode")
        );
    }

    /**
     * Clear checkout data
     */
    public void clearCheckoutData(HttpSession session) {
        session.removeAttribute("checkout.fullname");
        session.removeAttribute("checkout.phone");
        session.removeAttribute("checkout.address");
        session.removeAttribute("checkout.city");
        session.removeAttribute("checkout.state");
        session.removeAttribute("checkout.pincode");
        session.removeAttribute("checkout.amount");
    }

    /**
     * Validate shipping information
     */
    public boolean validateShippingInfo(ShippingInfo info) {
        return info != null &&
                info.getFullname() != null && !info.getFullname().trim().isEmpty() &&
                info.getPhone() != null && !info.getPhone().trim().isEmpty() &&
                info.getAddress() != null && !info.getAddress().trim().isEmpty() &&
                info.getCity() != null && !info.getCity().trim().isEmpty() &&
                info.getState() != null && !info.getState().trim().isEmpty() &&
                info.getPincode() != null && !info.getPincode().trim().isEmpty();
    }

    /**
     * Inner class for shipping info
     */
    public static class ShippingInfo {
        private String fullname;
        private String phone;
        private String address;
        private String city;
        private String state;
        private String pincode;

        public ShippingInfo(String fullname, String phone, String address,
                            String city, String state, String pincode) {
            this.fullname = fullname;
            this.phone = phone;
            this.address = address;
            this.city = city;
            this.state = state;
            this.pincode = pincode;
        }

        // Getters
        public String getFullname() { return fullname; }
        public String getPhone() { return phone; }
        public String getAddress() { return address; }
        public String getCity() { return city; }
        public String getState() { return state; }
        public String getPincode() { return pincode; }
    }
}
