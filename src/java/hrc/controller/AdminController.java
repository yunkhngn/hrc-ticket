package hrc.controller;

import hrc.service.EventService;
import hrc.service.OrderService;
import hrc.entity.Event;
import hrc.entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {
    private final EventService eventService;
    private final OrderService orderService;
    
    public AdminController() {
        this.eventService = new EventService();
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
        
        // Get dashboard statistics
        List<Event> events = eventService.getAllEvents();
        List<Order> orders = orderService.getAllOrders();
        
        // Count pending orders
        long pendingOrders = orders.stream()
                .filter(order -> "PENDING".equals(order.getPaymentStatus()))
                .count();
        
        // Count total events
        long totalEvents = events.size();
        
        // Count total orders
        long totalOrders = orders.size();
        
        request.setAttribute("totalEvents", totalEvents);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("pendingOrders", pendingOrders);
        
        // Get recent orders (up to 5)
        List<Order> recentOrders = orders.size() > 5 ? orders.subList(0, 5) : orders;
        request.setAttribute("recentOrders", recentOrders);
        
        // Get recent events (up to 5)
        List<Event> recentEvents = events.size() > 5 ? events.subList(0, 5) : events;
        request.setAttribute("recentEvents", recentEvents);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
