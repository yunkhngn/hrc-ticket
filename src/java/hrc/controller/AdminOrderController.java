package hrc.controller;

import hrc.service.OrderService;
import hrc.entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminOrderController", urlPatterns = {"/admin/orders"})
public class AdminOrderController extends HttpServlet {
    private final OrderService orderService;
    
    public AdminOrderController() {
        this.orderService = new OrderService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        
        if (!"ADMIN".equals(userRole) && !"STAFF".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin or Staff access required");
            return;
        }
        
        try {
            // List all orders for admin
            List<Order> orders = orderService.getAllOrders();
            request.setAttribute("orders", orders);
            
            // Debug: log the number of orders
            System.out.println("AdminOrderController: Found " + (orders != null ? orders.size() : 0) + " orders");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading orders: " + e.getMessage());
            request.setAttribute("orders", new java.util.ArrayList<>());
        }
        
        // Pass through any success/error messages
        String success = request.getParameter("success");
        String error = request.getParameter("error");
        if (success != null) {
            request.setAttribute("success", success);
        }
        if (error != null) {
            request.setAttribute("error", error);
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        
        if (!"ADMIN".equals(userRole) && !"STAFF".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin or Staff access required");
            return;
        }
        
        // Handle admin order operations
        String action = request.getParameter("action");
        String orderIdParam = request.getParameter("orderId");
        
        if (orderIdParam != null && !orderIdParam.trim().isEmpty()) {
            try {
                Long orderId = Long.parseLong(orderIdParam);
                Order order = orderService.getOrderById(orderId);
                
                if (order != null) {
                    if ("confirm".equals(action)) {
                        // Confirm payment
                        if ("PENDING".equals(order.getPaymentStatus())) {
                            order.setPaymentStatus("CONFIRMED");
                            order.setPaidAmount(order.getTotalAmount());
                            order.setConfirmedBy((Long) session.getAttribute("userId"));
                            order.setConfirmedAt(java.time.LocalDateTime.now());
                            
                            if (orderService.updateOrder(order)) {
                                response.sendRedirect(request.getContextPath() + "/admin/orders?success=Payment+confirmed+successfully");
                            } else {
                                response.sendRedirect(request.getContextPath() + "/admin/orders?error=Failed+to+confirm+payment");
                            }
                        } else {
                            response.sendRedirect(request.getContextPath() + "/admin/orders?error=Order+cannot+be+confirmed");
                        }
                    } else if ("cancel".equals(action)) {
                        // Cancel order
                        if ("PENDING".equals(order.getStatus()) && "PENDING".equals(order.getPaymentStatus())) {
                            order.setStatus("CANCELLED");
                            order.setPaymentStatus("FAILED");
                            
                            if (orderService.updateOrder(order)) {
                                response.sendRedirect(request.getContextPath() + "/admin/orders?success=Order+cancelled+successfully");
                            } else {
                                response.sendRedirect(request.getContextPath() + "/admin/orders?error=Failed+to+cancel+order");
                            }
                        } else {
                            response.sendRedirect(request.getContextPath() + "/admin/orders?error=Order+cannot+be+cancelled");
                        }
                    } else {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
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
