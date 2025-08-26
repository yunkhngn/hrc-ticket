package hrc.dao;

import hrc.entity.Order;
import hrc.util.DBConnect;
import java.sql.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderDAO {
    private static final Logger LOGGER = Logger.getLogger(OrderDAO.class.getName());
    
    public List<Order> list() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT id, customer_id, status, currency, total_amount, payment_method, payment_status, paid_amount, bank_ref, confirmed_by, confirmed_at, created_at FROM Orders ORDER BY created_at DESC";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getLong("id"));
                order.setCustomerId(rs.getLong("customer_id"));
                order.setStatus(rs.getString("status"));
                order.setCurrency(rs.getString("currency"));
                order.setTotalAmount(rs.getBigDecimal("total_amount"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setPaidAmount(rs.getBigDecimal("paid_amount"));
                order.setBankRef(rs.getString("bank_ref"));
                
                Long confirmedBy = rs.getLong("confirmed_by");
                if (!rs.wasNull()) {
                    order.setConfirmedBy(confirmedBy);
                }
                
                Timestamp confirmedAt = rs.getTimestamp("confirmed_at");
                if (confirmedAt != null) {
                    order.setConfirmedAt(confirmedAt.toLocalDateTime());
                }
                
                order.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                
                orders.add(order);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error listing orders", e);
        }
        
        return orders;
    }
    
    public List<Order> findByCustomerId(Long customerId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT id, customer_id, status, currency, total_amount, payment_method, payment_status, paid_amount, bank_ref, confirmed_by, confirmed_at, created_at FROM Orders WHERE customer_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, customerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getLong("id"));
                    order.setCustomerId(rs.getLong("customer_id"));
                    order.setStatus(rs.getString("status"));
                    order.setCurrency(rs.getString("currency"));
                    order.setTotalAmount(rs.getBigDecimal("total_amount"));
                    order.setPaymentMethod(rs.getString("payment_method"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setPaidAmount(rs.getBigDecimal("paid_amount"));
                    order.setBankRef(rs.getString("bank_ref"));
                    
                    Long confirmedBy = rs.getLong("confirmed_by");
                    if (!rs.wasNull()) {
                        order.setConfirmedBy(confirmedBy);
                    }
                    
                    Timestamp confirmedAt = rs.getTimestamp("confirmed_at");
                    if (confirmedAt != null) {
                        order.setConfirmedAt(confirmedAt.toLocalDateTime());
                    }
                    
                    order.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding orders by customer id: " + customerId, e);
        }
        
        return orders;
    }
    
    public Order findById(Long id) {
        String sql = "SELECT id, customer_id, status, currency, total_amount, payment_method, payment_status, paid_amount, bank_ref, confirmed_by, confirmed_at, created_at FROM Orders WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getLong("id"));
                    order.setCustomerId(rs.getLong("customer_id"));
                    order.setStatus(rs.getString("status"));
                    order.setCurrency(rs.getString("currency"));
                    order.setTotalAmount(rs.getBigDecimal("total_amount"));
                    order.setPaymentMethod(rs.getString("payment_method"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setPaidAmount(rs.getBigDecimal("paid_amount"));
                    order.setBankRef(rs.getString("bank_ref"));
                    
                    Long confirmedBy = rs.getLong("confirmed_by");
                    if (!rs.wasNull()) {
                        order.setConfirmedBy(confirmedBy);
                    }
                    
                    Timestamp confirmedAt = rs.getTimestamp("confirmed_at");
                    if (confirmedAt != null) {
                        order.setConfirmedAt(confirmedAt.toLocalDateTime());
                    }
                    
                    order.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    
                    return order;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding order by id: " + id, e);
        }
        
        return null;
    }
    
    public boolean create(Order order) {
        String sql = "INSERT INTO Orders (customer_id, status, currency, total_amount, payment_method, payment_status, paid_amount, bank_ref, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            System.out.println("Setting order parameters:");
            System.out.println("Customer ID: " + order.getCustomerId());
            System.out.println("Status: " + order.getStatus());
            System.out.println("Currency: " + order.getCurrency());
            System.out.println("Total Amount: " + order.getTotalAmount());
            System.out.println("Payment Method: " + order.getPaymentMethod());
            System.out.println("Payment Status: " + order.getPaymentStatus());
            System.out.println("Paid Amount: " + order.getPaidAmount());
            System.out.println("Bank Ref: " + order.getBankRef());
            System.out.println("Created At: " + order.getCreatedAt());
            
            ps.setLong(1, order.getCustomerId());
            ps.setString(2, order.getStatus());
            ps.setString(3, order.getCurrency());
            ps.setBigDecimal(4, order.getTotalAmount());
            ps.setString(5, order.getPaymentMethod());
            ps.setString(6, order.getPaymentStatus());
            ps.setBigDecimal(7, order.getPaidAmount());
            ps.setString(8, order.getBankRef());
            ps.setTimestamp(9, Timestamp.valueOf(order.getCreatedAt()));
            
            System.out.println("Executing SQL: " + sql);
            int affectedRows = ps.executeUpdate();
            System.out.println("Affected rows: " + affectedRows);
            
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        Long generatedId = rs.getLong(1);
                        order.setId(generatedId);
                        System.out.println("Generated order ID: " + generatedId);
                        return true;
                    } else {
                        System.out.println("No generated keys returned");
                    }
                }
            } else {
                System.out.println("No rows affected by insert");
            }
        } catch (SQLException e) {
            System.out.println("SQL Exception occurred: " + e.getMessage());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            LOGGER.log(Level.SEVERE, "Error creating order", e);
        } catch (Exception e) {
            System.out.println("General Exception occurred: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    public boolean update(Order order) {
        String sql = "UPDATE Orders SET customer_id = ?, status = ?, currency = ?, total_amount = ?, payment_method = ?, payment_status = ?, paid_amount = ?, bank_ref = ?, confirmed_by = ?, confirmed_at = ? WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, order.getCustomerId());
            ps.setString(2, order.getStatus());
            ps.setString(3, order.getCurrency());
            ps.setBigDecimal(4, order.getTotalAmount());
            ps.setString(5, order.getPaymentMethod());
            ps.setString(6, order.getPaymentStatus());
            ps.setBigDecimal(7, order.getPaidAmount());
            ps.setString(8, order.getBankRef());
            
            if (order.getConfirmedBy() != null) {
                ps.setLong(9, order.getConfirmedBy());
            } else {
                ps.setNull(9, Types.BIGINT);
            }
            
            if (order.getConfirmedAt() != null) {
                ps.setTimestamp(10, Timestamp.valueOf(order.getConfirmedAt()));
            } else {
                ps.setNull(10, Types.TIMESTAMP);
            }
            
            ps.setLong(11, order.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating order: " + order.getId(), e);
        }
        
        return false;
    }
}
