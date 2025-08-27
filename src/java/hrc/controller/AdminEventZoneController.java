package hrc.controller;

import hrc.dao.EventZoneDAO;
import hrc.dao.VenueZoneDAO;
import hrc.dao.EventDAO;
import hrc.dao.VenueDAO;
import hrc.entity.EventZone;
import hrc.entity.VenueZone;
import hrc.entity.Event;
import hrc.entity.Venue;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "AdminEventZoneController", urlPatterns = {"/admin/event-zones"})
public class AdminEventZoneController extends HttpServlet {
    private final EventZoneDAO eventZoneDAO;
    private final VenueZoneDAO venueZoneDAO;
    private final EventDAO eventDAO;
    
    public AdminEventZoneController() {
        this.eventZoneDAO = new EventZoneDAO();
        this.venueZoneDAO = new VenueZoneDAO();
        this.eventDAO = new EventDAO();
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
        
        String eventIdParam = request.getParameter("eventId");
        if (eventIdParam == null || eventIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/events?error=Event+ID+required");
            return;
        }
        
        try {
            Long eventId = Long.parseLong(eventIdParam);
            
            // Get event details
            Event event = eventDAO.findById(eventId);
            if (event == null) {
                response.sendRedirect(request.getContextPath() + "/admin/events?error=Event+not+found");
                return;
            }
            
            // Get venue name for the event
            VenueDAO venueDAO = new VenueDAO();
            Venue venue = venueDAO.findById(event.getVenueId());
            if (venue != null) {
                event.setVenueName(venue.getName());
            } else {
                event.setVenueName("Unknown Venue");
            }
            
            // Get event zones for this event
            List<EventZone> eventZones = eventZoneDAO.findByEventId(eventId);
            
            // Set venue zone names for each event zone
            for (EventZone eventZone : eventZones) {
                VenueZone venueZone = venueZoneDAO.findById(eventZone.getVenueZoneId());
                if (venueZone != null) {
                    eventZone.setVenueZoneName(venueZone.getName());
                    eventZone.setVenueZoneCapacity(venueZone.getCapacity());
                } else {
                    eventZone.setVenueZoneName("Unknown Zone");
                    eventZone.setVenueZoneCapacity(0);
                }
            }
            
            // Get available venue zones for this event's venue
            List<VenueZone> availableVenueZones = venueZoneDAO.findByVenueId(event.getVenueId());
            
            request.setAttribute("event", event);
            request.setAttribute("eventZones", eventZones);
            request.setAttribute("availableVenueZones", availableVenueZones);
            
            // Pass through any success/error messages
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            if (success != null) {
                request.setAttribute("success", success);
            }
            if (error != null) {
                request.setAttribute("error", error);
            }
            
            request.getRequestDispatcher("/WEB-INF/views/admin/event-zones.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/events?error=Invalid+event+ID");
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
        String eventIdParam = request.getParameter("eventId");
        
        if (eventIdParam == null || eventIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/events?error=Event+ID+required");
            return;
        }
        
        try {
            Long eventId = Long.parseLong(eventIdParam);
            
            if ("create".equals(action)) {
                createEventZone(request, response, eventId);
            } else if ("update".equals(action)) {
                updateEventZone(request, response, eventId);
            } else if ("delete".equals(action)) {
                deleteEventZone(request, response, eventId);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&error=Invalid+action");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/events?error=Invalid+event+ID");
        }
    }
    
    private void createEventZone(HttpServletRequest request, HttpServletResponse response, Long eventId) throws IOException {
        String venueZoneIdParam = request.getParameter("venueZoneId");
        String currency = request.getParameter("currency");
        String priceParam = request.getParameter("price");
        String feeParam = request.getParameter("fee");
        String allocationParam = request.getParameter("allocation");
        
        if (venueZoneIdParam == null || venueZoneIdParam.trim().isEmpty() ||
            currency == null || currency.trim().isEmpty() ||
            priceParam == null || priceParam.trim().isEmpty() ||
            allocationParam == null || allocationParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&error=Required+fields+missing");
            return;
        }
        
        try {
            // Get event to validate venue
            Event event = eventDAO.findById(eventId);
            if (event == null) {
                response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&error=Event+not+found");
                return;
            }
            
            // Validate that venue zone belongs to the event's venue
            VenueZone venueZone = venueZoneDAO.findById(Long.parseLong(venueZoneIdParam));
            if (venueZone == null || !venueZone.getVenueId().equals(event.getVenueId())) {
                response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&error=Invalid+venue+zone+for+this+event");
                return;
            }
            
            EventZone eventZone = new EventZone();
            eventZone.setEventId(eventId);
            eventZone.setVenueZoneId(Long.parseLong(venueZoneIdParam));
            eventZone.setCurrency(currency.trim());
            eventZone.setPrice(new BigDecimal(priceParam.trim()));
            eventZone.setFee(feeParam != null && !feeParam.trim().isEmpty() ? 
                           new BigDecimal(feeParam.trim()) : BigDecimal.ZERO);
            eventZone.setAllocation(Integer.parseInt(allocationParam.trim()));
            
            if (eventZoneDAO.create(eventZone)) {
                response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&success=Event+zone+created+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&error=Failed+to+create+event+zone");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&error=Invalid+number+format");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&error=Unexpected+error");
        }
    }
    
    private void updateEventZone(HttpServletRequest request, HttpServletResponse response, Long eventId) throws IOException {
        String eventZoneIdParam = request.getParameter("eventZoneId");
        String venueZoneIdParam = request.getParameter("venueZoneId");
        String currency = request.getParameter("currency");
        String priceParam = request.getParameter("price");
        String feeParam = request.getParameter("fee");
        String allocationParam = request.getParameter("allocation");
        
        if (eventZoneIdParam == null || eventZoneIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&error=Event+zone+ID+required");
            return;
        }
        
        try {
            Long eventZoneId = Long.parseLong(eventZoneIdParam);
            EventZone eventZone = eventZoneDAO.findById(eventZoneId);
            
            if (eventZone == null) {
                response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&error=Event+zone+not+found");
                return;
            }
            
            if (venueZoneIdParam != null && !venueZoneIdParam.trim().isEmpty()) {
                eventZone.setVenueZoneId(Long.parseLong(venueZoneIdParam));
            }
            if (currency != null && !currency.trim().isEmpty()) {
                eventZone.setCurrency(currency.trim());
            }
            if (priceParam != null && !priceParam.trim().isEmpty()) {
                eventZone.setPrice(new BigDecimal(priceParam.trim()));
            }
            if (feeParam != null && !feeParam.trim().isEmpty()) {
                eventZone.setFee(new BigDecimal(feeParam.trim()));
            }
            if (allocationParam != null && !allocationParam.trim().isEmpty()) {
                eventZone.setAllocation(Integer.parseInt(allocationParam.trim()));
            }
            
            if (eventZoneDAO.update(eventZone)) {
                response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&success=Event+zone+updated+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&error=Failed+to+update+event+zone");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&error=Invalid+number+format");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&error=Unexpected+error");
        }
    }
    
    private void deleteEventZone(HttpServletRequest request, HttpServletResponse response, Long eventId) throws IOException {
        String eventZoneIdParam = request.getParameter("eventZoneId");
        
        if (eventZoneIdParam == null || eventZoneIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&error=Event+zone+ID+required");
            return;
        }
        
        try {
            Long eventZoneId = Long.parseLong(eventZoneIdParam);
            
            if (eventZoneDAO.delete(eventZoneId)) {
                response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&success=Event+zone+deleted+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&error=Failed+to+delete+event+zone");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/event-zones?eventId=" + eventId + "&error=Invalid+event+zone+ID");
        }
    }
}
