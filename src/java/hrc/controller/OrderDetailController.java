package hrc.controller;

import hrc.service.OrderService;
import hrc.entity.Order;
import hrc.entity.OrderItem;
import hrc.dao.CustomerDAO;
import hrc.dao.UserDAO;
import hrc.dao.EventZoneDAO;
import hrc.entity.Customer;
import hrc.entity.User;
import hrc.entity.EventZone;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderDetailController", urlPatterns = {"/order-detail"})
public class OrderDetailController extends HttpServlet {
    private final OrderService orderService;
    private final CustomerDAO customerDAO;
    private final UserDAO userDAO;
    private final EventZoneDAO eventZoneDAO;
    
    public OrderDetailController() {
        this.orderService = new OrderService();
        this.customerDAO = new CustomerDAO();
        this.userDAO = new UserDAO();
        this.eventZoneDAO = new EventZoneDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        
        // Check if user is logged in
        if (userRole == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String orderIdParam = request.getParameter("id");
        
        if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Order ID is required");
            return;
        }
        
        try {
            Long orderId = Long.parseLong(orderIdParam);
            Order order = orderService.getOrderById(orderId);
            
            if (order == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
                return;
            }
            
            // Check if user has permission to view this order
            Long userId = (Long) session.getAttribute("userId");
            
            // Admin/Staff can view any order, customers can only view their own orders
            if (!"ADMIN".equals(userRole) && !"STAFF".equals(userRole)) {
                if (!order.getCustomerId().equals(userId)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "You can only view your own orders");
                    return;
                }
            }
            
            // Get order items
            List<OrderItem> orderItems = orderService.getOrderItems(orderId);
            
            // Get customer information
            Customer customer = customerDAO.findById(order.getCustomerId());
            String customerName = customer != null ? customer.getFullName() : "Unknown Customer";
            
            // Get confirmed by user information
            String confirmedByName = "Unknown";
            if (order.getConfirmedBy() != null) {
                User confirmedByUser = userDAO.findById(order.getConfirmedBy());
                if (confirmedByUser != null) {
                    confirmedByName = confirmedByUser.getFullName();
                }
            }
            
            // Get event zone information for each order item
            for (OrderItem item : orderItems) {
                EventZone eventZone = eventZoneDAO.findById(item.getEventZoneId());
                if (eventZone != null) {
                    // Add event zone name to the item (we'll need to extend OrderItem or use a different approach)
                    // For now, we'll store it in request attributes
                    request.setAttribute("eventZone_" + item.getId(), eventZone.getName());
                }
            }
            
            request.setAttribute("order", order);
            request.setAttribute("orderItems", orderItems);
            request.setAttribute("customerName", customerName);
            request.setAttribute("confirmedByName", confirmedByName);
            
            // Pass through any success/error messages
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            if (success != null) {
                request.setAttribute("success", success);
            }
            if (error != null) {
                request.setAttribute("error", error);
            }
            
            request.getRequestDispatcher("/WEB-INF/views/order-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid order ID");
        }
    }
}
