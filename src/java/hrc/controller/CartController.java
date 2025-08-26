package hrc.controller;

import hrc.dao.EventZoneDAO;
import hrc.dao.EventDAO;
import hrc.entity.CartItem;
import hrc.entity.Event;
import hrc.entity.EventZone;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {
    
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
        
        // Only customers can access cart
        if (!"CUSTOMER".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only customers can access cart");
            return;
        }
        
        // Get cart items from session
        @SuppressWarnings("unchecked")
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        
        if (cartItems == null) {
            cartItems = new ArrayList<>();
        }
        
        // Calculate total
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            total = total.add(item.getTotal());
        }
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", total);
        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
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
        
        // Only customers can access cart
        if (!"CUSTOMER".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only customers can access cart");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            // Add item to cart
            String eventZoneIdStr = request.getParameter("eventZoneId");
            String quantityStr = request.getParameter("quantity");
            
            if (eventZoneIdStr != null && quantityStr != null) {
                try {
                    Long eventZoneId = Long.parseLong(eventZoneIdStr);
                    Integer quantity = Integer.parseInt(quantityStr);
                    
                    if (quantity > 0 && quantity <= 10) {
                        // Get event zone details
                        EventZoneDAO eventZoneDAO = new EventZoneDAO();
                        EventZone eventZone = eventZoneDAO.findById(eventZoneId);
                        
                        if (eventZone != null) {
                            // Get event details
                            EventDAO eventDAO = new EventDAO();
                            Event event = eventDAO.findById(eventZone.getEventId());
                            
                            if (event != null) {
                                // Create cart item
                                CartItem cartItem = new CartItem(
                                    eventZoneId,
                                    event.getName(),
                                    "Zone " + eventZone.getId(), // You might want to get actual zone name
                                    quantity,
                                    eventZone.getPrice(),
                                    eventZone.getFee()
                                );
                                
                                // Get existing cart items
                                @SuppressWarnings("unchecked")
                                List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
                                
                                if (cartItems == null) {
                                    cartItems = new ArrayList<>();
                                }
                                
                                // Check if item already exists in cart
                                boolean itemExists = false;
                                for (CartItem item : cartItems) {
                                    if (item.getEventZoneId().equals(eventZoneId)) {
                                        // Update quantity
                                        item.setQuantity(item.getQuantity() + quantity);
                                        itemExists = true;
                                        break;
                                    }
                                }
                                
                                if (!itemExists) {
                                    cartItems.add(cartItem);
                                }
                                
                                // Save cart to session
                                session.setAttribute("cartItems", cartItems);
                                
                                response.sendRedirect(request.getContextPath() + "/events?success=Item+added+to+cart+successfully!");
                                return;
                            }
                        }
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/events?error=Invalid+quantity+or+event+zone+ID");
                    return;
                }
            }
            
            response.sendRedirect(request.getContextPath() + "/events");
            
        } else if ("remove".equals(action)) {
            // Remove item from cart
            String eventZoneIdStr = request.getParameter("eventZoneId");
            
            if (eventZoneIdStr != null) {
                try {
                    Long eventZoneId = Long.parseLong(eventZoneIdStr);
                    
                    @SuppressWarnings("unchecked")
                    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
                    
                    if (cartItems != null) {
                        cartItems.removeIf(item -> item.getEventZoneId().equals(eventZoneId));
                        session.setAttribute("cartItems", cartItems);
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid event zone ID");
                }
            }
            
            response.sendRedirect(request.getContextPath() + "/cart");
            
        } else if ("update".equals(action)) {
            // Update cart quantities
            String eventZoneIdStr = request.getParameter("eventZoneId");
            String quantityStr = request.getParameter("quantity");
            
            if (eventZoneIdStr != null && quantityStr != null) {
                try {
                    Long eventZoneId = Long.parseLong(eventZoneIdStr);
                    Integer quantity = Integer.parseInt(quantityStr);
                    
                    if (quantity > 0 && quantity <= 10) {
                        @SuppressWarnings("unchecked")
                        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
                        
                        if (cartItems != null) {
                            for (CartItem item : cartItems) {
                                if (item.getEventZoneId().equals(eventZoneId)) {
                                    item.setQuantity(quantity);
                                    break;
                                }
                            }
                            session.setAttribute("cartItems", cartItems);
                        }
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid quantity or event zone ID");
                }
            }
            
            response.sendRedirect(request.getContextPath() + "/cart");
            
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
}
