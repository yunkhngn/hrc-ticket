package hrc.controller;

import hrc.dao.EventDAO;
import hrc.dao.EventArtistDAO;
import hrc.dao.VenueDAO;
import hrc.dao.EventZoneDAO;
import hrc.entity.Event;
import hrc.entity.Venue;
import hrc.entity.EventArtist;
import hrc.entity.EventZone;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "EventDetailController", urlPatterns = {"/event-detail"})
public class EventDetailController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String eventIdParam = request.getParameter("id");
        
        if (eventIdParam == null || eventIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/events");
            return;
        }
        
        try {
            Long eventId = Long.parseLong(eventIdParam);
            
            EventDAO eventDAO = new EventDAO();
            Event event = eventDAO.findById(eventId);
            
            if (event == null) {
                request.setAttribute("error", "Event not found");
                response.sendRedirect(request.getContextPath() + "/events");
                return;
            }
            
                               // Get event artists
                   EventArtistDAO eventArtistDAO = new EventArtistDAO();
                   List<EventArtist> eventArtists = eventArtistDAO.findByEventId(eventId);
                   
                   // Get venue information
                   VenueDAO venueDAO = new VenueDAO();
                   Venue venue = venueDAO.findById(event.getVenueId());
                   
                   // Get event zones
                   EventZoneDAO eventZoneDAO = new EventZoneDAO();
                   List<EventZone> eventZones = eventZoneDAO.findByEventId(eventId);
            
                               request.setAttribute("event", event);
                   request.setAttribute("eventArtists", eventArtists);
                   request.setAttribute("venue", venue);
                   request.setAttribute("eventZones", eventZones);
            
            request.getRequestDispatcher("/WEB-INF/views/event-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid event ID");
            response.sendRedirect(request.getContextPath() + "/events");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
