package hrc.controller;

import hrc.dao.EventDAO;
import hrc.dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin")
public class AdminDashboardController extends HttpServlet {
    private EventDAO eventDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if user is logged in and has admin/staff role
        String userRole = (String) session.getAttribute("userRole");
        if (userRole == null || (!userRole.equals("ADMIN") && !userRole.equals("STAFF"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get basic statistics
            int totalEvents = eventDAO.getTotalEvents();
            int totalOrders = orderDAO.getTotalOrders();
            int pendingOrders = orderDAO.getPendingOrdersCount();

            // Set attributes for JSP
            request.setAttribute("totalEvents", totalEvents);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("pendingOrders", pendingOrders);

            // Forward to admin dashboard
            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
