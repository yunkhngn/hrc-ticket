package hrc.dao;

import hrc.entity.EventZone;
import hrc.util.DBConnect;
import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EventZoneDAO {
    private static final Logger LOGGER = Logger.getLogger(EventZoneDAO.class.getName());
    
    public List<EventZone> findByEventId(Long eventId) {
        List<EventZone> eventZones = new ArrayList<>();
        String sql = "SELECT ez.id, ez.event_id, ez.venue_zone_id, ez.currency, ez.price, ez.fee, ez.allocation, " +
                     "vz.name as venue_zone_name, vz.capacity as venue_zone_capacity " +
                     "FROM EventZones ez " +
                     "LEFT JOIN VenueZones vz ON ez.venue_zone_id = vz.id " +
                     "WHERE ez.event_id = ? " +
                     "ORDER BY vz.name";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, eventId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    EventZone eventZone = new EventZone();
                    eventZone.setId(rs.getLong("id"));
                    eventZone.setEventId(rs.getLong("event_id"));
                    eventZone.setVenueZoneId(rs.getLong("venue_zone_id"));
                    eventZone.setCurrency(rs.getString("currency"));
                    eventZone.setPrice(rs.getBigDecimal("price"));
                    eventZone.setFee(rs.getBigDecimal("fee"));
                    eventZone.setAllocation(rs.getInt("allocation"));
                    eventZone.setVenueZoneName(rs.getString("venue_zone_name"));
                    eventZone.setVenueZoneCapacity(rs.getInt("venue_zone_capacity"));
                    
                    eventZones.add(eventZone);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding event zones by event id: " + eventId, e);
        }
        
        return eventZones;
    }
    
    public EventZone findById(Long id) {
        String sql = "SELECT id, event_id, venue_zone_id, currency, price, fee, allocation FROM EventZones WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    EventZone eventZone = new EventZone();
                    eventZone.setId(rs.getLong("id"));
                    eventZone.setEventId(rs.getLong("event_id"));
                    eventZone.setVenueZoneId(rs.getLong("venue_zone_id"));
                    eventZone.setCurrency(rs.getString("currency"));
                    eventZone.setPrice(rs.getBigDecimal("price"));
                    eventZone.setFee(rs.getBigDecimal("fee"));
                    eventZone.setAllocation(rs.getInt("allocation"));
                    
                    return eventZone;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding event zone by id: " + id, e);
        }
        
        return null;
    }
    
    public boolean delete(Long id) {
        String sql = "DELETE FROM EventZones WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting event zone: " + id, e);
        }
        
        return false;
    }
    
    public boolean create(EventZone eventZone) {
        String sql = "INSERT INTO EventZones (event_id, venue_zone_id, currency, price, fee, allocation) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setLong(1, eventZone.getEventId());
            ps.setLong(2, eventZone.getVenueZoneId());
            ps.setString(3, eventZone.getCurrency());
            ps.setBigDecimal(4, eventZone.getPrice());
            ps.setBigDecimal(5, eventZone.getFee());
            ps.setInt(6, eventZone.getAllocation());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        eventZone.setId(rs.getLong(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating event zone", e);
        }
        
        return false;
    }
    
    public boolean update(EventZone eventZone) {
        String sql = "UPDATE EventZones SET event_id = ?, venue_zone_id = ?, currency = ?, price = ?, fee = ?, allocation = ? WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, eventZone.getEventId());
            ps.setLong(2, eventZone.getVenueZoneId());
            ps.setString(3, eventZone.getCurrency());
            ps.setBigDecimal(4, eventZone.getPrice());
            ps.setBigDecimal(5, eventZone.getFee());
            ps.setInt(6, eventZone.getAllocation());
            ps.setLong(7, eventZone.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating event zone: " + eventZone.getId(), e);
        }
        
        return false;
    }
}
