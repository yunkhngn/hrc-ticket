package hrc.dao;

import hrc.entity.VenueZone;
import hrc.util.DBConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class VenueZoneDAO {
    private static final Logger LOGGER = Logger.getLogger(VenueZoneDAO.class.getName());
    
    public List<VenueZone> list() {
        List<VenueZone> venueZones = new ArrayList<>();
        String sql = "SELECT id, venue_id, name, capacity FROM VenueZones ORDER BY venue_id, name";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                VenueZone venueZone = new VenueZone();
                venueZone.setId(rs.getLong("id"));
                venueZone.setVenueId(rs.getLong("venue_id"));
                venueZone.setName(rs.getString("name"));
                venueZone.setCapacity(rs.getInt("capacity"));
                
                venueZones.add(venueZone);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error listing venue zones", e);
        }
        
        return venueZones;
    }
    
    public List<VenueZone> findByVenueId(Long venueId) {
        List<VenueZone> venueZones = new ArrayList<>();
        String sql = "SELECT id, venue_id, name, capacity FROM VenueZones WHERE venue_id = ? ORDER BY name";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, venueId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    VenueZone venueZone = new VenueZone();
                    venueZone.setId(rs.getLong("id"));
                    venueZone.setVenueId(rs.getLong("venue_id"));
                    venueZone.setName(rs.getString("name"));
                    venueZone.setCapacity(rs.getInt("capacity"));
                    
                    venueZones.add(venueZone);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding venue zones by venue id: " + venueId, e);
        }
        
        return venueZones;
    }
    
    public VenueZone findById(Long id) {
        String sql = "SELECT id, venue_id, name, capacity FROM VenueZones WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    VenueZone venueZone = new VenueZone();
                    venueZone.setId(rs.getLong("id"));
                    venueZone.setVenueId(rs.getLong("venue_id"));
                    venueZone.setName(rs.getString("name"));
                    venueZone.setCapacity(rs.getInt("capacity"));
                    
                    return venueZone;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding venue zone by id: " + id, e);
        }
        
        return null;
    }
    
    public boolean create(VenueZone venueZone) {
        String sql = "INSERT INTO VenueZones (venue_id, name, capacity) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setLong(1, venueZone.getVenueId());
            ps.setString(2, venueZone.getName());
            ps.setInt(3, venueZone.getCapacity());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        venueZone.setId(rs.getLong(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating venue zone", e);
        }
        
        return false;
    }
    
    public boolean update(VenueZone venueZone) {
        String sql = "UPDATE VenueZones SET venue_id = ?, name = ?, capacity = ? WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, venueZone.getVenueId());
            ps.setString(2, venueZone.getName());
            ps.setInt(3, venueZone.getCapacity());
            ps.setLong(4, venueZone.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating venue zone: " + venueZone.getId(), e);
        }
        
        return false;
    }
    
    public boolean delete(Long id) {
        String sql = "DELETE FROM VenueZones WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting venue zone: " + id, e);
        }
        
        return false;
    }
}
