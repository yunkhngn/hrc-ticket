package hrc.dao;

import hrc.entity.Event;
import hrc.util.DBConnect;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EventDAO {
    private static final Logger LOGGER = Logger.getLogger(EventDAO.class.getName());
    
    public List<Event> list() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT id, venue_id, name, description, start_at, end_at, status, min_age, created_at FROM Events ORDER BY start_at DESC";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getLong("id"));
                event.setVenueId(rs.getLong("venue_id"));
                event.setName(rs.getString("name"));
                event.setDescription(rs.getString("description"));
                event.setStartAt(rs.getTimestamp("start_at").toLocalDateTime());
                
                Timestamp endAt = rs.getTimestamp("end_at");
                if (endAt != null) {
                    event.setEndAt(endAt.toLocalDateTime());
                }
                
                event.setStatus(rs.getString("status"));
                event.setMinAge(rs.getInt("min_age"));
                event.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                
                events.add(event);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error listing events", e);
        }
        
        return events;
    }
    
    public List<Event> listPublicEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT id, venue_id, name, description, start_at, end_at, status, min_age, created_at FROM Events WHERE status != 'DRAFT' ORDER BY start_at DESC";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getLong("id"));
                event.setVenueId(rs.getLong("venue_id"));
                event.setName(rs.getString("name"));
                event.setDescription(rs.getString("description"));
                event.setStartAt(rs.getTimestamp("start_at").toLocalDateTime());
                
                Timestamp endAt = rs.getTimestamp("end_at");
                if (endAt != null) {
                    event.setEndAt(endAt.toLocalDateTime());
                }
                
                event.setStatus(rs.getString("status"));
                event.setMinAge(rs.getInt("min_age"));
                event.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                
                events.add(event);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error listing public events", e);
        }
        
        return events;
    }
    
    public Event findById(Long id) {
        String sql = "SELECT id, venue_id, name, description, start_at, end_at, status, min_age, created_at FROM Events WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Event event = new Event();
                    event.setId(rs.getLong("id"));
                    event.setVenueId(rs.getLong("venue_id"));
                    event.setName(rs.getString("name"));
                    event.setDescription(rs.getString("description"));
                    event.setStartAt(rs.getTimestamp("start_at").toLocalDateTime());
                    
                    Timestamp endAt = rs.getTimestamp("end_at");
                    if (endAt != null) {
                        event.setEndAt(endAt.toLocalDateTime());
                    }
                    
                    event.setStatus(rs.getString("status"));
                    event.setMinAge(rs.getInt("min_age"));
                    event.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    
                    return event;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding event by id: " + id, e);
        }
        
        return null;
    }
    
    public boolean create(Event event) {
        String sql = "INSERT INTO Events (venue_id, name, description, start_at, end_at, status, min_age, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setLong(1, event.getVenueId());
            ps.setString(2, event.getName());
            ps.setString(3, event.getDescription());
            ps.setTimestamp(4, Timestamp.valueOf(event.getStartAt()));
            
            if (event.getEndAt() != null) {
                ps.setTimestamp(5, Timestamp.valueOf(event.getEndAt()));
            } else {
                ps.setNull(5, Types.TIMESTAMP);
            }
            
            ps.setString(6, event.getStatus());
            ps.setInt(7, event.getMinAge());
            ps.setTimestamp(8, Timestamp.valueOf(LocalDateTime.now()));
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        event.setId(rs.getLong(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating event", e);
        }
        
        return false;
    }
    
    public boolean update(Event event) {
        String sql = "UPDATE Events SET venue_id = ?, name = ?, description = ?, start_at = ?, end_at = ?, status = ?, min_age = ? WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, event.getVenueId());
            ps.setString(2, event.getName());
            ps.setString(3, event.getDescription());
            ps.setTimestamp(4, Timestamp.valueOf(event.getStartAt()));
            
            if (event.getEndAt() != null) {
                ps.setTimestamp(5, Timestamp.valueOf(event.getEndAt()));
            } else {
                ps.setNull(5, Types.TIMESTAMP);
            }
            
            ps.setString(6, event.getStatus());
            ps.setInt(7, event.getMinAge());
            ps.setLong(8, event.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating event: " + event.getId(), e);
        }
        
        return false;
    }
    
    public boolean delete(Long id) {
        String sql = "DELETE FROM Events WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting event: " + id, e);
        }
        
        return false;
    }
}
