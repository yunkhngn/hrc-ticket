package hrc.dao;

import hrc.entity.EventArtist;
import hrc.util.DBConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EventArtistDAO {
    private static final Logger LOGGER = Logger.getLogger(EventArtistDAO.class.getName());
    
    public List<EventArtist> findByEventId(Long eventId) {
        List<EventArtist> eventArtists = new ArrayList<>();
        String sql = "SELECT ea.event_id, ea.artist_id, ea.is_headliner, a.name as artist_name, a.country as artist_country " +
                    "FROM EventArtists ea " +
                    "JOIN Artists a ON ea.artist_id = a.id " +
                    "WHERE ea.event_id = ? " +
                    "ORDER BY ea.is_headliner DESC, a.name";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, eventId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                EventArtist eventArtist = new EventArtist();
                eventArtist.setEventId(rs.getLong("event_id"));
                eventArtist.setArtistId(rs.getLong("artist_id"));
                eventArtist.setHeadliner(rs.getBoolean("is_headliner"));
                eventArtist.setArtistName(rs.getString("artist_name"));
                eventArtist.setArtistCountry(rs.getString("artist_country"));
                eventArtists.add(eventArtist);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding event artists by event ID: " + eventId, e);
        }
        
        return eventArtists;
    }
    
    public EventArtist findByEventAndArtist(Long eventId, Long artistId) {
        String sql = "SELECT event_id, artist_id, is_headliner FROM EventArtists WHERE event_id = ? AND artist_id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, eventId);
            ps.setLong(2, artistId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                EventArtist eventArtist = new EventArtist();
                eventArtist.setEventId(rs.getLong("event_id"));
                eventArtist.setArtistId(rs.getLong("artist_id"));
                eventArtist.setHeadliner(rs.getBoolean("is_headliner"));
                return eventArtist;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding event artist by event and artist ID: " + eventId + ", " + artistId, e);
        }
        
        return null;
    }
    
    public boolean create(EventArtist eventArtist) {
        String sql = "INSERT INTO EventArtists (event_id, artist_id, is_headliner) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, eventArtist.getEventId());
            ps.setLong(2, eventArtist.getArtistId());
            ps.setBoolean(3, eventArtist.isHeadliner());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating event artist", e);
        }
        
        return false;
    }
    
    public boolean update(EventArtist eventArtist) {
        String sql = "UPDATE EventArtists SET is_headliner = ? WHERE event_id = ? AND artist_id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setBoolean(1, eventArtist.isHeadliner());
            ps.setLong(2, eventArtist.getEventId());
            ps.setLong(3, eventArtist.getArtistId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating event artist", e);
        }
        
        return false;
    }
    
    public boolean delete(Long eventId, Long artistId) {
        String sql = "DELETE FROM EventArtists WHERE event_id = ? AND artist_id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, eventId);
            ps.setLong(2, artistId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting event artist: " + eventId + ", " + artistId, e);
        }
        
        return false;
    }
    
    public boolean deleteByEventId(Long eventId) {
        String sql = "DELETE FROM EventArtists WHERE event_id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, eventId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting event artists by event ID: " + eventId, e);
        }
        
        return false;
    }
}
