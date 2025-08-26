package hrc.controller;

import hrc.dao.ArtistDAO;
import hrc.entity.Artist;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminArtistController", urlPatterns = {"/admin/artists"})
public class AdminArtistController extends HttpServlet {
    private final ArtistDAO artistDAO;
    
    public AdminArtistController() {
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
        
        // List all artists for admin
        List<Artist> artists = artistDAO.list();
        request.setAttribute("artists", artists);
        
        // Pass through any success/error messages
        String success = request.getParameter("success");
        String error = request.getParameter("error");
        if (success != null) {
            request.setAttribute("success", success);
        }
        if (error != null) {
            request.setAttribute("error", error);
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin/artists.jsp").forward(request, response);
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
            createArtist(request, response);
        } else if ("update".equals(action)) {
            updateArtist(request, response);
        } else if ("delete".equals(action)) {
            deleteArtist(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    private void createArtist(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String country = request.getParameter("country");
        String about = request.getParameter("about");
        
        if (name == null || name.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/artists?error=Artist+name+required");
            return;
        }
        
        Artist artist = new Artist();
        artist.setName(name);
        artist.setCountry(country != null ? country : "");
        artist.setAbout(about != null ? about : "");
        
        if (artistDAO.create(artist)) {
            response.sendRedirect(request.getContextPath() + "/admin/artists?success=Artist+created+successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/artists?error=Failed+to+create+artist");
        }
    }
    
    private void updateArtist(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String artistIdParam = request.getParameter("artistId");
        String name = request.getParameter("name");
        String country = request.getParameter("country");
        String about = request.getParameter("about");
        
        if (artistIdParam == null || artistIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/artists?error=Artist+ID+required");
            return;
        }
        
        try {
            Long artistId = Long.parseLong(artistIdParam);
            Artist artist = artistDAO.findById(artistId);
            
            if (artist == null) {
                response.sendRedirect(request.getContextPath() + "/admin/artists?error=Artist+not+found");
                return;
            }
            
            artist.setName(name != null ? name : artist.getName());
            artist.setCountry(country != null ? country : artist.getCountry());
            artist.setAbout(about != null ? about : artist.getAbout());
            
            if (artistDAO.update(artist)) {
                response.sendRedirect(request.getContextPath() + "/admin/artists?success=Artist+updated+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/artists?error=Failed+to+update+artist");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/artists?error=Invalid+artist+ID");
        }
    }
    
    private void deleteArtist(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String artistIdParam = request.getParameter("artistId");
        
        if (artistIdParam == null || artistIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/artists?error=Artist+ID+required");
            return;
        }
        
        try {
            Long artistId = Long.parseLong(artistIdParam);
            
            if (artistDAO.delete(artistId)) {
                response.sendRedirect(request.getContextPath() + "/admin/artists?success=Artist+deleted+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/artists?error=Failed+to+delete+artist");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/artists?error=Invalid+artist+ID");
        }
    }
}
