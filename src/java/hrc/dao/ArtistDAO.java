package hrc.dao;

import hrc.entity.Artist;
import hrc.util.DBConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ArtistDAO {
    private static final Logger LOGGER = Logger.getLogger(ArtistDAO.class.getName());
    
    public List<Artist> list() {
        List<Artist> artists = new ArrayList<>();
        String sql = "SELECT id, name, country, about FROM Artists ORDER BY name";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Artist artist = new Artist();
                artist.setId(rs.getLong("id"));
                artist.setName(rs.getString("name"));
                artist.setCountry(rs.getString("country"));
                artist.setAbout(rs.getString("about"));
                artists.add(artist);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error listing artists", e);
        }
        
        return artists;
    }
    
    public Artist findById(Long id) {
        String sql = "SELECT id, name, country, about FROM Artists WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Artist artist = new Artist();
                artist.setId(rs.getLong("id"));
                artist.setName(rs.getString("name"));
                artist.setCountry(rs.getString("country"));
                artist.setAbout(rs.getString("about"));
                return artist;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding artist by ID: " + id, e);
        }
        
        return null;
    }
    
    public boolean create(Artist artist) {
        String sql = "INSERT INTO Artists (name, country, about) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, artist.getName());
            ps.setString(2, artist.getCountry());
            ps.setString(3, artist.getAbout());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    artist.setId(rs.getLong(1));
                }
                return true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating artist", e);
        }
        
        return false;
    }
    
    public boolean update(Artist artist) {
        String sql = "UPDATE Artists SET name = ?, country = ?, about = ? WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, artist.getName());
            ps.setString(2, artist.getCountry());
            ps.setString(3, artist.getAbout());
            ps.setLong(4, artist.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating artist: " + artist.getId(), e);
        }
        
        return false;
    }
    
    public boolean delete(Long id) {
        String sql = "DELETE FROM Artists WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting artist: " + id, e);
        }
        
        return false;
    }
}
