package hrc.controller;

import hrc.dao.EventArtistDAO;
import hrc.dao.ArtistDAO;
import hrc.entity.EventArtist;
import hrc.entity.Artist;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminEventArtistController", urlPatterns = {"/admin/event-artists"})
public class AdminEventArtistController extends HttpServlet {
    private final EventArtistDAO eventArtistDAO;
    private final ArtistDAO artistDAO;
    
    public AdminEventArtistController() {
        this.eventArtistDAO = new EventArtistDAO();
        this.artistDAO = new ArtistDAO();
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
        
        String eventIdParam = request.getParameter("eventId");
        
        if (eventIdParam == null || eventIdParam.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Event ID required");
            return;
        }
        
        try {
            Long eventId = Long.parseLong(eventIdParam);
            
            // Get current event artists
            List<EventArtist> eventArtists = eventArtistDAO.findByEventId(eventId);
            request.setAttribute("eventArtists", eventArtists);
            request.setAttribute("eventId", eventId);
            
            // Get all available artists for dropdown
            List<Artist> allArtists = artistDAO.list();
            request.setAttribute("allArtists", allArtists);
            
            // Pass through any success/error messages
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            if (success != null) {
                request.setAttribute("success", success);
            }
            if (error != null) {
                request.setAttribute("error", error);
            }
            
            request.getRequestDispatcher("/WEB-INF/views/admin/event-artists.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event ID");
        }
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
        
        if ("add".equals(action)) {
            addEventArtist(request, response);
        } else if ("remove".equals(action)) {
            removeEventArtist(request, response);
        } else if ("toggle-headliner".equals(action)) {
            toggleHeadliner(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    private void addEventArtist(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String eventIdParam = request.getParameter("eventId");
        String artistIdParam = request.getParameter("artistId");
        String isHeadlinerParam = request.getParameter("isHeadliner");
        
        if (eventIdParam == null || artistIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/admin/event-artists?eventId=" + eventIdParam + "&error=Event+and+artist+required");
            return;
        }
        
        try {
            Long eventId = Long.parseLong(eventIdParam);
            Long artistId = Long.parseLong(artistIdParam);
            boolean isHeadliner = "on".equals(isHeadlinerParam);
            
            EventArtist eventArtist = new EventArtist();
            eventArtist.setEventId(eventId);
            eventArtist.setArtistId(artistId);
            eventArtist.setHeadliner(isHeadliner);
            
            if (eventArtistDAO.create(eventArtist)) {
                response.sendRedirect(request.getContextPath() + "/admin/event-artists?eventId=" + eventId + "&success=Artist+added+to+event+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/event-artists?eventId=" + eventId + "&error=Failed+to+add+artist+to+event");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/event-artists?eventId=" + eventIdParam + "&error=Invalid+event+or+artist+ID");
        }
    }
    
    private void removeEventArtist(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String eventIdParam = request.getParameter("eventId");
        String artistIdParam = request.getParameter("artistId");
        
        if (eventIdParam == null || artistIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/admin/event-artists?eventId=" + eventIdParam + "&error=Event+and+artist+required");
            return;
        }
        
        try {
            Long eventId = Long.parseLong(eventIdParam);
            Long artistId = Long.parseLong(artistIdParam);
            
            if (eventArtistDAO.delete(eventId, artistId)) {
                response.sendRedirect(request.getContextPath() + "/admin/event-artists?eventId=" + eventId + "&success=Artist+removed+from+event+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/event-artists?eventId=" + eventId + "&error=Failed+to+remove+artist+from+event");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/event-artists?eventId=" + eventIdParam + "&error=Invalid+event+or+artist+ID");
        }
    }
    
    private void toggleHeadliner(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String eventIdParam = request.getParameter("eventId");
        String artistIdParam = request.getParameter("artistId");
        
        if (eventIdParam == null || artistIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/admin/event-artists?eventId=" + eventIdParam + "&error=Event+and+artist+required");
            return;
        }
        
        try {
            Long eventId = Long.parseLong(eventIdParam);
            Long artistId = Long.parseLong(artistIdParam);
            
            EventArtist eventArtist = eventArtistDAO.findByEventAndArtist(eventId, artistId);
            if (eventArtist != null) {
                eventArtist.setHeadliner(!eventArtist.isHeadliner());
                
                if (eventArtistDAO.update(eventArtist)) {
                    response.sendRedirect(request.getContextPath() + "/admin/event-artists?eventId=" + eventId + "&success=Headliner+status+updated+successfully");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/event-artists?eventId=" + eventId + "&error=Failed+to+update+headliner+status");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/event-artists?eventId=" + eventId + "&error=Event+artist+relationship+not+found");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/event-artists?eventId=" + eventIdParam + "&error=Invalid+event+or+artist+ID");
        }
    }
}
