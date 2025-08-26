package hrc.controller;

import hrc.dao.VenueDAO;
import hrc.entity.Venue;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminVenueController", urlPatterns = {"/admin/venues"})
public class AdminVenueController extends HttpServlet {
    private final VenueDAO venueDAO;
    
    public AdminVenueController() {
        this.venueDAO = new VenueDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        
        if (!"ADMIN".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin access required");
            return;
        }
        
        // List all venues for admin
        List<Venue> venues = venueDAO.list();
        request.setAttribute("venues", venues);
        
        // Pass through any success/error messages
        String success = request.getParameter("success");
        String error = request.getParameter("error");
        if (success != null) {
            request.setAttribute("success", success);
        }
        if (error != null) {
            request.setAttribute("error", error);
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin/venues.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        
        if (!"ADMIN".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin access required");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            createVenue(request, response);
        } else if ("update".equals(action)) {
            updateVenue(request, response);
        } else if ("delete".equals(action)) {
            deleteVenue(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    private void createVenue(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String capacityParam = request.getParameter("capacity");
        
        if (name == null || name.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/venues?error=Venue+name+required");
            return;
        }
        
        try {
            Venue venue = new Venue();
            venue.setName(name);
            venue.setAddress(address != null ? address : "");
            venue.setCity(city != null ? city : "");
            venue.setCapacity(capacityParam != null && !capacityParam.trim().isEmpty() ? 
                            Integer.parseInt(capacityParam) : null);
            
            if (venueDAO.create(venue)) {
                response.sendRedirect(request.getContextPath() + "/admin/venues?success=Venue+created+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/venues?error=Failed+to+create+venue");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/venues?error=Invalid+capacity+value");
        }
    }
    
    private void updateVenue(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String venueIdParam = request.getParameter("venueId");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String capacityParam = request.getParameter("capacity");
        
        if (venueIdParam == null || venueIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/venues?error=Venue+ID+required");
            return;
        }
        
        try {
            Long venueId = Long.parseLong(venueIdParam);
            Venue venue = venueDAO.findById(venueId);
            
            if (venue == null) {
                response.sendRedirect(request.getContextPath() + "/admin/venues?error=Venue+not+found");
                return;
            }
            
            venue.setName(name != null ? name : venue.getName());
            venue.setAddress(address != null ? address : venue.getAddress());
            venue.setCity(city != null ? city : venue.getCity());
            venue.setCapacity(capacityParam != null && !capacityParam.trim().isEmpty() ? 
                            Integer.parseInt(capacityParam) : venue.getCapacity());
            
            if (venueDAO.update(venue)) {
                response.sendRedirect(request.getContextPath() + "/admin/venues?success=Venue+updated+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/venues?error=Failed+to+update+venue");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/venues?error=Invalid+venue+ID+or+capacity");
        }
    }
    
    private void deleteVenue(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String venueIdParam = request.getParameter("venueId");
        
        if (venueIdParam == null || venueIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/venues?error=Venue+ID+required");
            return;
        }
        
        try {
            Long venueId = Long.parseLong(venueIdParam);
            
            if (venueDAO.delete(venueId)) {
                response.sendRedirect(request.getContextPath() + "/admin/venues?success=Venue+deleted+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/venues?error=Failed+to+delete+venue");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/venues?error=Invalid+venue+ID");
        }
    }
}
