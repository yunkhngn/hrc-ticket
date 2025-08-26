package hrc.dao;

import hrc.entity.Customer;
import hrc.util.DBConnect;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CustomerDAO {
    private static final Logger LOGGER = Logger.getLogger(CustomerDAO.class.getName());
    
    public List<Customer> list() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT id, email, full_name, phone, password_hash, created_at FROM Customers ORDER BY created_at DESC";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setId(rs.getLong("id"));
                customer.setEmail(rs.getString("email"));
                customer.setFullName(rs.getString("full_name"));
                customer.setPhone(rs.getString("phone"));
                customer.setPasswordHash(rs.getString("password_hash"));
                customer.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                
                customers.add(customer);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error listing customers", e);
        }
        
        return customers;
    }
    
    public Customer findById(Long id) {
        String sql = "SELECT id, email, full_name, phone, password_hash, created_at FROM Customers WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setId(rs.getLong("id"));
                    customer.setEmail(rs.getString("email"));
                    customer.setFullName(rs.getString("full_name"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setPasswordHash(rs.getString("password_hash"));
                    customer.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    
                    return customer;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding customer by id: " + id, e);
        }
        
        return null;
    }
    
    public Customer findByEmail(String email) {
        String sql = "SELECT id, email, full_name, phone, password_hash, created_at FROM Customers WHERE email = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setId(rs.getLong("id"));
                    customer.setEmail(rs.getString("email"));
                    customer.setFullName(rs.getString("full_name"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setPasswordHash(rs.getString("password_hash"));
                    customer.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    
                    return customer;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding customer by email: " + email, e);
        }
        
        return null;
    }
    
    public boolean create(Customer customer) {
        String sql = "INSERT INTO Customers (email, full_name, phone, password_hash, created_at) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, customer.getEmail());
            ps.setString(2, customer.getFullName());
            ps.setString(3, customer.getPhone());
            ps.setString(4, customer.getPasswordHash());
            ps.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        customer.setId(rs.getLong(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating customer", e);
        }
        
        return false;
    }
    
    public boolean update(Customer customer) {
        String sql = "UPDATE Customers SET email = ?, full_name = ?, phone = ?, password_hash = ? WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, customer.getEmail());
            ps.setString(2, customer.getFullName());
            ps.setString(3, customer.getPhone());
            ps.setString(4, customer.getPasswordHash());
            ps.setLong(5, customer.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating customer: " + customer.getId(), e);
        }
        
        return false;
    }
    
    public boolean delete(Long id) {
        String sql = "DELETE FROM Customers WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting customer: " + id, e);
        }
        
        return false;
    }
}
