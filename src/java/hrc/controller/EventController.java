package hrc.controller;

import hrc.service.EventService;
import hrc.dao.EventArtistDAO;
import hrc.entity.Event;
import hrc.entity.EventZone;
import hrc.entity.EventArtist;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "EventController", urlPatterns = {"/events", "/event"})
public class EventController extends HttpServlet {
    private final EventService eventService;
    private final EventArtistDAO eventArtistDAO;
    
    public EventController() {
        this.eventService = new EventService();
        this.eventArtistDAO = new EventArtistDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getServletPath();
        
        if ("/events".equals(pathInfo)) {
            // List public events (excluding drafts)
            List<Event> events = eventService.getPublicEvents();
            
            // Create a map to store artists for each event
            Map<Long, List<EventArtist>> eventArtistsMap = new HashMap<>();
            
            // For each event, get its artists
            for (Event event : events) {
                List<EventArtist> artists = eventArtistDAO.findByEventId(event.getId());
                eventArtistsMap.put(event.getId(), artists);
            }
            
            request.setAttribute("events", events);
            request.setAttribute("eventArtistsMap", eventArtistsMap);
            
            // Pass through any success/error messages from other controllers
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            if (success != null) {
                request.setAttribute("success", success);
            }
            if (error != null) {
                request.setAttribute("error", error);
            }
            
            request.getRequestDispatcher("/WEB-INF/views/events.jsp").forward(request, response);
            
        } else if ("/event".equals(pathInfo)) {
            // Show specific event
            String eventIdParam = request.getParameter("id");
            if (eventIdParam != null && !eventIdParam.trim().isEmpty()) {
                try {
                    Long eventId = Long.parseLong(eventIdParam);
                    Event event = eventService.getEventById(eventId);
                    
                    if (event != null) {
                        List<EventZone> zones = eventService.getEventZones(eventId);
                        List<EventArtist> artists = eventArtistDAO.findByEventId(eventId);
                        request.setAttribute("event", event);
                        request.setAttribute("zones", zones);
                        request.setAttribute("artists", artists);
                        request.getRequestDispatcher("/WEB-INF/views/event-detail.jsp").forward(request, response);
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Event not found");
                    }
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event ID");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Event ID is required");
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle POST requests for creating/updating events
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "POST not implemented");
    }
}
