package hrc.controller;

import hrc.dao.VenueZoneDAO;
import hrc.dao.VenueDAO;
import hrc.entity.VenueZone;
import hrc.entity.Venue;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminVenueZoneController", urlPatterns = {"/admin/venue-zones"})
public class AdminVenueZoneController extends HttpServlet {
    private final VenueZoneDAO venueZoneDAO;
    private final VenueDAO venueDAO;
    
    public AdminVenueZoneController() {
        this.venueZoneDAO = new VenueZoneDAO();
        this.venueDAO = new VenueDAO();
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
        
        String venueIdParam = request.getParameter("venueId");
        
        if (venueIdParam == null || venueIdParam.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Venue ID is required");
            return;
        }
        
        try {
            Long venueId = Long.parseLong(venueIdParam);
            
            // Get the specific venue
            Venue venue = venueDAO.findById(venueId);
            if (venue == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Venue not found");
                return;
            }
            request.setAttribute("venue", venue);
            
            // List venue zones for this specific venue
            List<VenueZone> venueZones = venueZoneDAO.findByVenueId(venueId);
            request.setAttribute("venueZones", venueZones);
            
            // Pass through any success/error messages
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            if (success != null) {
                request.setAttribute("success", success);
            }
            if (error != null) {
                request.setAttribute("error", error);
            }
            
            request.getRequestDispatcher("/WEB-INF/views/admin/venue-zones.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid venue ID");
        }
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
        
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            createVenueZone(request, response);
        } else if ("update".equals(action)) {
            updateVenueZone(request, response);
        } else if ("delete".equals(action)) {
            deleteVenueZone(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    private void createVenueZone(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String venueIdParam = request.getParameter("venueId");
        String name = request.getParameter("name");
        String capacityParam = request.getParameter("capacity");
        
        if (venueIdParam == null || venueIdParam.trim().isEmpty() ||
            name == null || name.trim().isEmpty() ||
            capacityParam == null || capacityParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/venue-zones?venueId=" + venueIdParam + "&error=Required+fields+missing");
            return;
        }
        
        try {
            VenueZone venueZone = new VenueZone();
            venueZone.setVenueId(Long.parseLong(venueIdParam));
            venueZone.setName(name.trim());
            venueZone.setCapacity(Integer.parseInt(capacityParam.trim()));
            
            if (venueZoneDAO.create(venueZone)) {
                response.sendRedirect(request.getContextPath() + "/admin/venue-zones?venueId=" + venueIdParam + "&success=Venue+zone+created+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/venue-zones?venueId=" + venueIdParam + "&error=Failed+to+create+venue+zone");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/venue-zones?venueId=" + venueIdParam + "&error=Invalid+venue+ID+or+capacity");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/venue-zones?venueId=" + venueIdParam + "&error=Unexpected+error");
        }
    }
    
    private void updateVenueZone(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String venueZoneIdParam = request.getParameter("venueZoneId");
        String venueIdParam = request.getParameter("venueId");
        String name = request.getParameter("name");
        String capacityParam = request.getParameter("capacity");
        
        if (venueZoneIdParam == null || venueZoneIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/venue-zones?venueId=" + venueIdParam + "&error=Venue+zone+ID+required");
            return;
        }
        
        try {
            Long venueZoneId = Long.parseLong(venueZoneIdParam);
            VenueZone venueZone = venueZoneDAO.findById(venueZoneId);
            
            if (venueZone == null) {
                response.sendRedirect(request.getContextPath() + "/admin/venue-zones?venueId=" + venueIdParam + "&error=Venue+zone+not+found");
                return;
            }
            
            if (name != null && !name.trim().isEmpty()) {
                venueZone.setName(name.trim());
            }
            if (capacityParam != null && !capacityParam.trim().isEmpty()) {
                venueZone.setCapacity(Integer.parseInt(capacityParam.trim()));
            }
            
            if (venueZoneDAO.update(venueZone)) {
                response.sendRedirect(request.getContextPath() + "/admin/venue-zones?venueId=" + venueIdParam + "&success=Venue+zone+updated+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/venue-zones?venueId=" + venueIdParam + "&error=Failed+to+update+venue+zone");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/venue-zones?venueId=" + venueIdParam + "&error=Invalid+venue+zone+ID+or+venue+ID");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/venue-zones?venueId=" + venueIdParam + "&error=Unexpected+error");
        }
    }
    
    private void deleteVenueZone(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String venueZoneIdParam = request.getParameter("venueZoneId");
        String venueIdParam = request.getParameter("venueId");
        
        if (venueZoneIdParam == null || venueZoneIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/venue-zones?venueId=" + venueIdParam + "&error=Venue+zone+ID+required");
            return;
        }
        
        try {
            Long venueZoneId = Long.parseLong(venueZoneIdParam);
            
            if (venueZoneDAO.delete(venueZoneId)) {
                response.sendRedirect(request.getContextPath() + "/admin/venue-zones?venueId=" + venueIdParam + "&success=Venue+zone+deleted+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/venue-zones?venueId=" + venueIdParam + "&error=Failed+to+delete+venue+zone");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/venue-zones?venueId=" + venueIdParam + "&error=Invalid+venue+zone+ID");
        }
    }
}
