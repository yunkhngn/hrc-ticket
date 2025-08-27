package hrc.controller;

import hrc.service.EventService;
import hrc.dao.VenueDAO;
import hrc.entity.Event;
import hrc.entity.Venue;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "AdminEventController", urlPatterns = {"/admin/events"})
public class AdminEventController extends HttpServlet {
    private final EventService eventService;
    private final VenueDAO venueDAO;
    
    public AdminEventController() {
        this.eventService = new EventService();
        this.venueDAO = new VenueDAO();
    }
    
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
    private static final DateTimeFormatter DATE_TIME_FORMATTER_WITH_SECONDS = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        
        if (!"ADMIN".equals(userRole) && !"STAFF".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin or Staff access required");
            return;
        }
        
        // List all events for admin
        List<Event> events = eventService.getAllEvents();
        
        // Get venue names for each event
        for (Event event : events) {
            Venue venue = venueDAO.findById(event.getVenueId());
            if (venue != null) {
                event.setVenueName(venue.getName());
            } else {
                event.setVenueName("Unknown Venue");
            }
        }
        
        request.setAttribute("events", events);
        
        // List all venues for dropdown and for name lookup
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
        
        request.getRequestDispatcher("/WEB-INF/views/admin/events.jsp").forward(request, response);
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
        
        // Handle admin event operations
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            createEvent(request, response);
        } else if ("update".equals(action)) {
            updateEvent(request, response);
        } else if ("delete".equals(action)) {
            String eventIdParam = request.getParameter("eventId");
            
            if (eventIdParam != null && !eventIdParam.trim().isEmpty()) {
                try {
                    Long eventId = Long.parseLong(eventIdParam);
                    
                    if (eventService.deleteEvent(eventId)) {
                        response.sendRedirect(request.getContextPath() + "/admin/events?success=Event+deleted+successfully");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin/events?error=Failed+to+delete+event");
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/admin/events?error=Invalid+event+ID");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/events?error=Event+ID+required");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    private void createEvent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String startAt = request.getParameter("startAt");
        String endAt = request.getParameter("endAt");
        String status = request.getParameter("status");
                String minAgeParam = request.getParameter("minAge");
        String venueIdParam = request.getParameter("venueId");
        
        if (name == null || name.trim().isEmpty() ||
            startAt == null || startAt.trim().isEmpty() ||
            minAgeParam == null || minAgeParam.trim().isEmpty() ||
            venueIdParam == null || venueIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/events?error=Required+fields+missing");
            return;
        }
        
        try {
            Event event = new Event();
            event.setName(name);
            event.setDescription(description != null ? description : "");
            event.setStartAt(parseDateTime(startAt));
            event.setEndAt(endAt != null && !endAt.trim().isEmpty() ? 
                          parseDateTime(endAt) : null);
            event.setStatus(status != null ? status : "DRAFT");
            event.setMinAge(parseMinAge(minAgeParam));
            event.setVenueId(Long.parseLong(venueIdParam));
            
            if (eventService.createEvent(event)) {
                response.sendRedirect(request.getContextPath() + "/admin/events?success=Event+created+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/events?error=Failed+to+create+event");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/events?error=Invalid+venue+ID+or+min+age");
        } catch (IllegalArgumentException e) {
            String errorMsg = e.getMessage();
            if (errorMsg.contains("Invalid date format")) {
                response.sendRedirect(request.getContextPath() + "/admin/events?error=Invalid+date+format");
            } else if (errorMsg.contains("Minimum age is required")) {
                response.sendRedirect(request.getContextPath() + "/admin/events?error=Minimum+age+is+required");
            } else if (errorMsg.contains("Invalid age format")) {
                response.sendRedirect(request.getContextPath() + "/admin/events?error=Invalid+age+format");
            } else if (errorMsg.contains("Age must be between")) {
                response.sendRedirect(request.getContextPath() + "/admin/events?error=Age+must+be+between+0+and+100");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/events?error=Invalid+input+format");
            }
        } catch (Exception e) {
            // Log the actual exception for debugging
            System.err.println("Unexpected error in createEvent: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/events?error=Unexpected+error:+please+try+again");
        }
    }
    
    private void updateEvent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String eventIdParam = request.getParameter("eventId");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String startAt = request.getParameter("startAt");
        String endAt = request.getParameter("endAt");
        String status = request.getParameter("status");
        String minAgeParam = request.getParameter("minAge");
        String venueIdParam = request.getParameter("venueId");
        
        if (eventIdParam == null || eventIdParam.trim().isEmpty() ||
            minAgeParam == null || minAgeParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/events?error=Required+fields+missing");
            return;
        }
        
        try {
            Long eventId = Long.parseLong(eventIdParam);
            Event event = eventService.getEventById(eventId);
            
            if (event == null) {
                response.sendRedirect(request.getContextPath() + "/admin/events?error=Event+not+found");
                return;
            }
            
            event.setName(name != null ? name : event.getName());
            event.setDescription(description != null ? description : event.getDescription());
            event.setStartAt(startAt != null && !startAt.trim().isEmpty() ? 
                           parseDateTime(startAt) : event.getStartAt());
            event.setEndAt(endAt != null && !endAt.trim().isEmpty() ? 
                          parseDateTime(endAt) : event.getEndAt());
            event.setStatus(status != null ? status : event.getStatus());
            event.setMinAge(parseMinAge(minAgeParam));
            event.setVenueId(venueIdParam != null && !venueIdParam.trim().isEmpty() ? 
                           Long.parseLong(venueIdParam) : event.getVenueId());
            
            if (eventService.updateEvent(event)) {
                response.sendRedirect(request.getContextPath() + "/admin/events?success=Event+updated+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/events?error=Failed+to+update+event");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/events?error=Invalid+event+ID+or+venue+ID");
        } catch (IllegalArgumentException e) {
            String errorMsg = e.getMessage();
            if (errorMsg.contains("Invalid date format")) {
                response.sendRedirect(request.getContextPath() + "/admin/events?error=Invalid+date+format");
            } else if (errorMsg.contains("Minimum age is required")) {
                response.sendRedirect(request.getContextPath() + "/admin/events?error=Minimum+age+is+required");
            } else if (errorMsg.contains("Invalid age format")) {
                response.sendRedirect(request.getContextPath() + "/admin/events?error=Invalid+age+format");
            } else if (errorMsg.contains("Age must be between")) {
                response.sendRedirect(request.getContextPath() + "/admin/events?error=Age+must+be+between+0+and+100");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/events?error=Invalid+input+format");
            }
        } catch (Exception e) {
            // Log the actual exception for debugging
            System.err.println("Unexpected error in updateEvent: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/events?error=Unexpected+error:+please+try+again");
        }
    }
    
    private LocalDateTime parseDateTime(String dateTimeStr) {
        if (dateTimeStr == null || dateTimeStr.trim().isEmpty()) {
            return null;
        }
        
        try {
            // Try parsing with seconds first (most common browser format)
            return LocalDateTime.parse(dateTimeStr, DATE_TIME_FORMATTER_WITH_SECONDS);
        } catch (Exception e1) {
            try {
                // Try parsing without seconds
                return LocalDateTime.parse(dateTimeStr, DATE_TIME_FORMATTER);
            } catch (Exception e2) {
                throw new IllegalArgumentException("Invalid date format: " + dateTimeStr);
            }
        }
    }
    
    private Integer parseMinAge(String minAgeParam) {
        // Debug logging
        System.out.println("parseMinAge called with: '" + minAgeParam + "'");
        
        if (minAgeParam == null || minAgeParam.trim().isEmpty() || "null".equals(minAgeParam.trim())) {
            throw new IllegalArgumentException("Minimum age is required");
        }
        
        try {
            int age = Integer.parseInt(minAgeParam.trim());
            if (age < 0 || age > 100) {
                throw new IllegalArgumentException("Age must be between 0 and 100");
            }
            System.out.println("Parsed age successfully: " + age);
            return age;
        } catch (NumberFormatException e) {
            System.out.println("NumberFormatException for: '" + minAgeParam + "'");
            throw new IllegalArgumentException("Invalid age format: " + minAgeParam);
        }
    }
}
