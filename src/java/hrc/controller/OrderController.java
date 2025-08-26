package hrc.controller;

import hrc.service.OrderService;
import hrc.entity.Order;
import hrc.entity.OrderItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderController", urlPatterns = {"/orders", "/order"})
public class OrderController extends HttpServlet {
    private final OrderService orderService;
    
    public OrderController() {
        this.orderService = new OrderService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        
        if (userRole == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String pathInfo = request.getServletPath();
        
        if ("/orders".equals(pathInfo)) {
            // Redirect staff and admin users to admin orders management
            if ("ADMIN".equals(userRole) || "STAFF".equals(userRole)) {
                response.sendRedirect(request.getContextPath() + "/admin/orders");
                return;
            }
            
            // For customers, show only their orders
            List<Order> orders;
            Long customerId = (Long) session.getAttribute("userId");
            if (customerId != null) {
                orders = orderService.getOrdersByCustomer(customerId);
            } else {
                orders = List.of(); // Empty list if no customer ID
            }
            
            request.setAttribute("orders", orders);
            
            // Pass through any success/error messages
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            if (success != null) {
                request.setAttribute("success", success);
            }
            if (error != null) {
                request.setAttribute("error", error);
            }
            
            request.getRequestDispatcher("/WEB-INF/views/orders.jsp").forward(request, response);
            
        } else if ("/order".equals(pathInfo)) {
            // Show specific order
            String orderIdParam = request.getParameter("id");
            if (orderIdParam != null && !orderIdParam.trim().isEmpty()) {
                try {
                    Long orderId = Long.parseLong(orderIdParam);
                    Order order = orderService.getOrderById(orderId);
                    
                    if (order != null) {
                        // Check if user has permission to view this order
                        if ("ADMIN".equals(userRole) || "STAFF".equals(userRole) || 
                            (order.getCustomerId().equals(session.getAttribute("userId")))) {
                            
                            List<OrderItem> orderItems = orderService.getOrderItems(orderId);
                            request.setAttribute("order", order);
                            request.setAttribute("orderItems", orderItems);
                            request.getRequestDispatcher("/WEB-INF/views/order-detail.jsp").forward(request, response);
                        } else {
                            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
                        }
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
                    }
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid order ID");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Order ID is required");
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        
        if (userRole == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("cancel".equals(action)) {
            String orderIdParam = request.getParameter("orderId");
            
            if (orderIdParam != null && !orderIdParam.trim().isEmpty()) {
                try {
                    Long orderId = Long.parseLong(orderIdParam);
                    Order order = orderService.getOrderById(orderId);
                    
                    if (order != null) {
                        // Check if user has permission to cancel this order
                        if ("ADMIN".equals(userRole) || "STAFF".equals(userRole) || 
                            (order.getCustomerId().equals(session.getAttribute("userId")))) {
                            
                            // Only allow cancellation of PENDING orders
                            if ("PENDING".equals(order.getStatus()) && "PENDING".equals(order.getPaymentStatus())) {
                                order.setStatus("CANCELLED");
                                order.setPaymentStatus("FAILED");
                                
                                if (orderService.updateOrder(order)) {
                                    response.sendRedirect(request.getContextPath() + "/orders?success=Order+cancelled+successfully");
                                } else {
                                    response.sendRedirect(request.getContextPath() + "/orders?error=Failed+to+cancel+order");
                                }
                            } else {
                                response.sendRedirect(request.getContextPath() + "/orders?error=Order+cannot+be+cancelled");
                            }
                        } else {
                            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
                        }
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
                    }
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid order ID");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Order ID is required");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
}
