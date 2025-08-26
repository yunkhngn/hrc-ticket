package hrc.controller;

import hrc.dao.OrderDAO;
import hrc.dao.OrderItemDAO;
import hrc.entity.CartItem;
import hrc.entity.Order;
import hrc.entity.OrderItem;
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

@WebServlet(name = "CheckoutController", urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if user is logged in
        String userRole = (String) session.getAttribute("userRole");
        if (userRole == null) {
            response.sendRedirect(request.getContextPath() + "/login");
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
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", total);
        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if user is logged in
        String userRole = (String) session.getAttribute("userRole");
        if (userRole == null) {
            response.sendRedirect(request.getContextPath() + "/login");
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
            
            // Calculate total
            BigDecimal total = BigDecimal.ZERO;
            for (CartItem item : cartItems) {
                total = total.add(item.getTotal());
            }
            order.setTotalAmount(total);
            order.setPaidAmount(BigDecimal.ZERO); // Will be updated when payment is confirmed
            
            OrderDAO orderDAO = new OrderDAO();
            OrderItemDAO orderItemDAO = new OrderItemDAO();
            
            // Save order
            System.out.println("Attempting to create order for customer: " + customerId);
            System.out.println("Order total: " + total);
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
}
