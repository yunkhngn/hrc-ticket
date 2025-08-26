package hrc.dao;

import hrc.entity.OrderItem;
import hrc.util.DBConnect;
import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderItemDAO {
    private static final Logger LOGGER = Logger.getLogger(OrderItemDAO.class.getName());
    
    public List<OrderItem> findByOrderId(Long orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String sql = "SELECT id, order_id, event_zone_id, qty, unit_price, fee_amount, final_price FROM OrderItems WHERE order_id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, orderId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem orderItem = new OrderItem();
                    orderItem.setId(rs.getLong("id"));
                    orderItem.setOrderId(rs.getLong("order_id"));
                    orderItem.setEventZoneId(rs.getLong("event_zone_id"));
                    orderItem.setQty(rs.getInt("qty"));
                    orderItem.setUnitPrice(rs.getBigDecimal("unit_price"));
                    orderItem.setFeeAmount(rs.getBigDecimal("fee_amount"));
                    orderItem.setFinalPrice(rs.getBigDecimal("final_price"));
                    
                    orderItems.add(orderItem);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding order items by order id: " + orderId, e);
        }
        
        return orderItems;
    }
    
    public boolean create(OrderItem orderItem) {
        String sql = "INSERT INTO OrderItems (order_id, event_zone_id, qty, unit_price, fee_amount) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setLong(1, orderItem.getOrderId());
            ps.setLong(2, orderItem.getEventZoneId());
            ps.setInt(3, orderItem.getQty());
            ps.setBigDecimal(4, orderItem.getUnitPrice());
            ps.setBigDecimal(5, orderItem.getFeeAmount());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderItem.setId(rs.getLong(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating order item", e);
        }
        
        return false;
    }
}
