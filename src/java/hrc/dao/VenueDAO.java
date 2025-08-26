package hrc.dao;

import hrc.entity.Venue;
import hrc.util.DBConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class VenueDAO {
    private static final Logger LOGGER = Logger.getLogger(VenueDAO.class.getName());
    
    public List<Venue> list() {
        List<Venue> venues = new ArrayList<>();
        String sql = "SELECT id, name, address, city, capacity FROM Venues ORDER BY name";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Venue venue = new Venue();
                venue.setId(rs.getLong("id"));
                venue.setName(rs.getString("name"));
                venue.setAddress(rs.getString("address"));
                venue.setCity(rs.getString("city"));
                venue.setCapacity(rs.getInt("capacity"));
                venues.add(venue);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error listing venues", e);
        }
        
        return venues;
    }
    
    public Venue findById(Long id) {
        String sql = "SELECT id, name, address, city, capacity FROM Venues WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Venue venue = new Venue();
                venue.setId(rs.getLong("id"));
                venue.setName(rs.getString("name"));
                venue.setAddress(rs.getString("address"));
                venue.setCity(rs.getString("city"));
                venue.setCapacity(rs.getInt("capacity"));
                return venue;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding venue by ID: " + id, e);
        }
        
        return null;
    }
    
    public boolean create(Venue venue) {
        String sql = "INSERT INTO Venues (name, address, city, capacity) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, venue.getName());
            ps.setString(2, venue.getAddress());
            ps.setString(3, venue.getCity());
            if (venue.getCapacity() != null) {
                ps.setInt(4, venue.getCapacity());
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    venue.setId(rs.getLong(1));
                }
                return true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating venue", e);
        }
        
        return false;
    }
    
    public boolean update(Venue venue) {
        String sql = "UPDATE Venues SET name = ?, address = ?, city = ?, capacity = ? WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, venue.getName());
            ps.setString(2, venue.getAddress());
            ps.setString(3, venue.getCity());
            if (venue.getCapacity() != null) {
                ps.setInt(4, venue.getCapacity());
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            ps.setLong(5, venue.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating venue: " + venue.getId(), e);
        }
        
        return false;
    }
    
    public boolean delete(Long id) {
        String sql = "DELETE FROM Venues WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting venue: " + id, e);
        }
        
        return false;
    }
}
