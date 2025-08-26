package hrc.controller;

import hrc.dao.OrderDAO;
import hrc.dao.OrderItemDAO;
import hrc.entity.CartItem;
import hrc.entity.Order;
import hrc.entity.OrderItem;
import hrc.entity.PromoCode;
import hrc.service.PromoCodeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CheckoutController", urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {
    
    private final PromoCodeService promoCodeService;
    
    public CheckoutController() {
        this.promoCodeService = new PromoCodeService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if user is logged in and is a customer
        String userRole = (String) session.getAttribute("userRole");
        if (userRole == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Only customers can access checkout
        if (!"CUSTOMER".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only customers can place orders");
            return;
        }
        
        // Get cart items from session
        @SuppressWarnings("unchecked")
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Calculate total
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            total = total.add(item.getTotal());
        }
        
        // Get promo code info from session
        String appliedPromoCode = (String) session.getAttribute("appliedPromoCode");
        PromoCode promoCode = (PromoCode) session.getAttribute("promoCode");
        BigDecimal discountAmount = (BigDecimal) session.getAttribute("discountAmount");
        BigDecimal finalTotal = (BigDecimal) session.getAttribute("finalTotal");
        
        // If no promo code applied, final total equals cart total
        if (finalTotal == null) {
            finalTotal = total;
        }
        if (discountAmount == null) {
            discountAmount = BigDecimal.ZERO;
        }
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", total);
        request.setAttribute("appliedPromoCode", appliedPromoCode);
        request.setAttribute("discountAmount", discountAmount);
        request.setAttribute("finalTotal", finalTotal);
        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if user is logged in and is a customer
        String userRole = (String) session.getAttribute("userRole");
        if (userRole == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Only customers can access checkout
        if (!"CUSTOMER".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only customers can place orders");
            return;
        }
        
        // Get customer ID from session
        Long customerId = (Long) session.getAttribute("customerId");
        if (customerId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get cart items
        @SuppressWarnings("unchecked")
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Calculate cart total
        BigDecimal cartTotal = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            cartTotal = cartTotal.add(item.getTotal());
        }
        
        // Check for promo code actions
        String action = request.getParameter("action");
        
        if ("applyPromoCode".equals(action)) {
            handleApplyPromoCode(request, response, session, cartTotal, customerId);
            return;
        } else if ("removePromoCode".equals(action)) {
            handleRemovePromoCode(request, response, session);
            return;
        }
        
        // Process checkout
        String bankRef = request.getParameter("bankRef");
        
        if (bankRef == null || bankRef.trim().isEmpty()) {
            request.setAttribute("error", "Bank reference number is required");
            request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
            return;
        }
        
        try {
            // Create order
            Order order = new Order();
            order.setCustomerId(customerId);
            order.setStatus("PENDING");
            order.setCurrency("VND");
            order.setPaymentMethod("BANK");
            order.setPaymentStatus("PENDING");
            order.setBankRef(bankRef);
            order.setCreatedAt(LocalDateTime.now());
            
            // Get final total (with promo code discount if applied)
            BigDecimal finalTotal = (BigDecimal) session.getAttribute("finalTotal");
            if (finalTotal == null) {
                finalTotal = cartTotal;
            }
            
            order.setTotalAmount(finalTotal);
            order.setPaidAmount(BigDecimal.ZERO); // Will be updated when payment is confirmed
            
            OrderDAO orderDAO = new OrderDAO();
            OrderItemDAO orderItemDAO = new OrderItemDAO();
            
            // Save order
            System.out.println("Attempting to create order for customer: " + customerId);
            System.out.println("Order total: " + finalTotal);
            System.out.println("Bank ref: " + bankRef);
            
            if (orderDAO.create(order)) {
                // Get the generated order ID
                Long orderId = order.getId();
                System.out.println("Order created successfully with ID: " + orderId);
                
                // Create order items
                for (CartItem cartItem : cartItems) {
                    OrderItem orderItem = new OrderItem();
                    orderItem.setOrderId(orderId);
                    orderItem.setEventZoneId(cartItem.getEventZoneId());
                    orderItem.setQty(cartItem.getQuantity());
                    orderItem.setUnitPrice(cartItem.getPrice());
                    orderItem.setFeeAmount(cartItem.getFee());
                    orderItem.setFinalPrice(cartItem.getTotal());
                    
                    boolean itemCreated = orderItemDAO.create(orderItem);
                    System.out.println("Order item created: " + itemCreated);
                }
                
                // Clear cart
                session.removeAttribute("cartItems");
                
                // Redirect to order confirmation
                response.sendRedirect(request.getContextPath() + "/order?id=" + orderId);
            } else {
                System.out.println("Failed to create order in database");
                request.setAttribute("error", "Failed to create order. Please try again.");
                request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace(); // This will help us see the actual error in the server logs
            request.setAttribute("error", "An error occurred during checkout: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
        }
    }
    
    private void handleApplyPromoCode(HttpServletRequest request, HttpServletResponse response, 
                                    HttpSession session, BigDecimal cartTotal, Long customerId) 
            throws ServletException, IOException {
        
        String promoCode = request.getParameter("promoCode");
        
        if (promoCode == null || promoCode.trim().isEmpty()) {
            request.setAttribute("promoCodeError", "Please enter a promo code");
            forwardToCheckout(request, response, session, cartTotal);
            return;
        }
        
        // Validate promo code
        Map<String, Object> validationResult = promoCodeService.validatePromoCode(promoCode.trim(), cartTotal, customerId);
        
        if (!(Boolean) validationResult.get("valid")) {
            request.setAttribute("promoCodeError", (String) validationResult.get("message"));
            forwardToCheckout(request, response, session, cartTotal);
            return;
        }
        
        // Apply promo code
        PromoCode validPromoCode = (PromoCode) validationResult.get("promoCode");
        BigDecimal discountAmount = promoCodeService.calculateDiscount(validPromoCode, cartTotal);
        BigDecimal finalTotal = promoCodeService.calculateFinalAmount(validPromoCode, cartTotal);
        
        // Store in session
        session.setAttribute("appliedPromoCode", promoCode.trim().toUpperCase());
        session.setAttribute("promoCode", validPromoCode);
        session.setAttribute("discountAmount", discountAmount);
        session.setAttribute("finalTotal", finalTotal);
        
        request.setAttribute("promoCodeSuccess", "Promo code applied successfully! Discount: " + discountAmount + " VND");
        forwardToCheckout(request, response, session, cartTotal);
    }
    
    private void handleRemovePromoCode(HttpServletRequest request, HttpServletResponse response, 
                                     HttpSession session) throws ServletException, IOException {
        
        // Remove promo code from session
        session.removeAttribute("appliedPromoCode");
        session.removeAttribute("promoCode");
        session.removeAttribute("discountAmount");
        session.removeAttribute("finalTotal");
        
        request.setAttribute("promoCodeSuccess", "Promo code removed successfully");
        
        // Calculate cart total for forwarding
        @SuppressWarnings("unchecked")
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        BigDecimal cartTotal = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            cartTotal = cartTotal.add(item.getTotal());
        }
        
        forwardToCheckout(request, response, session, cartTotal);
    }
    
    private void forwardToCheckout(HttpServletRequest request, HttpServletResponse response, 
                                 HttpSession session, BigDecimal cartTotal) throws ServletException, IOException {
        
        // Get promo code info from session
        String appliedPromoCode = (String) session.getAttribute("appliedPromoCode");
        BigDecimal discountAmount = (BigDecimal) session.getAttribute("discountAmount");
        BigDecimal finalTotal = (BigDecimal) session.getAttribute("finalTotal");
        
        // If no promo code applied, final total equals cart total
        if (finalTotal == null) {
            finalTotal = cartTotal;
        }
        if (discountAmount == null) {
            discountAmount = BigDecimal.ZERO;
        }
        
        @SuppressWarnings("unchecked")
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", cartTotal);
        request.setAttribute("appliedPromoCode", appliedPromoCode);
        request.setAttribute("discountAmount", discountAmount);
        request.setAttribute("finalTotal", finalTotal);
        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }
}
