package hrc.dao;

import hrc.entity.PromoCode;
import hrc.util.DBConnect;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PromoCodeDAO {
    private static final Logger LOGGER = Logger.getLogger(PromoCodeDAO.class.getName());
    
    public List<PromoCode> list() {
        List<PromoCode> promoCodes = new ArrayList<>();
        String sql = "SELECT id, code, discount_type, discount_value, max_uses, per_customer_limit, start_at, end_at, min_order_amount FROM PromoCodes ORDER BY created_at DESC";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                PromoCode promoCode = new PromoCode();
                promoCode.setId(rs.getLong("id"));
                promoCode.setCode(rs.getString("code"));
                promoCode.setDiscountType(rs.getString("discount_type"));
                promoCode.setDiscountValue(rs.getBigDecimal("discount_value"));
                promoCode.setMaxUses(rs.getInt("max_uses"));
                promoCode.setPerCustomerLimit(rs.getInt("per_customer_limit"));
                
                Timestamp startAt = rs.getTimestamp("start_at");
                if (startAt != null) {
                    promoCode.setStartAt(startAt.toLocalDateTime());
                }
                
                Timestamp endAt = rs.getTimestamp("end_at");
                if (endAt != null) {
                    promoCode.setEndAt(endAt.toLocalDateTime());
                }
                
                promoCode.setMinOrderAmount(rs.getBigDecimal("min_order_amount"));
                promoCodes.add(promoCode);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error listing promo codes", e);
        }
        return promoCodes;
    }
    
    public PromoCode findById(Long id) {
        String sql = "SELECT id, code, discount_type, discount_value, max_uses, per_customer_limit, start_at, end_at, min_order_amount FROM PromoCodes WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    PromoCode promoCode = new PromoCode();
                    promoCode.setId(rs.getLong("id"));
                    promoCode.setCode(rs.getString("code"));
                    promoCode.setDiscountType(rs.getString("discount_type"));
                    promoCode.setDiscountValue(rs.getBigDecimal("discount_value"));
                    promoCode.setMaxUses(rs.getInt("max_uses"));
                    promoCode.setPerCustomerLimit(rs.getInt("per_customer_limit"));
                    
                    Timestamp startAt = rs.getTimestamp("start_at");
                    if (startAt != null) {
                        promoCode.setStartAt(startAt.toLocalDateTime());
                    }
                    
                    Timestamp endAt = rs.getTimestamp("end_at");
                    if (endAt != null) {
                        promoCode.setEndAt(endAt.toLocalDateTime());
                    }
                    
                    promoCode.setMinOrderAmount(rs.getBigDecimal("min_order_amount"));
                    return promoCode;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding promo code by ID: " + id, e);
        }
        return null;
    }
    
    public PromoCode findByCode(String code) {
        String sql = "SELECT id, code, discount_type, discount_value, max_uses, per_customer_limit, start_at, end_at, min_order_amount FROM PromoCodes WHERE code = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, code);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    PromoCode promoCode = new PromoCode();
                    promoCode.setId(rs.getLong("id"));
                    promoCode.setCode(rs.getString("code"));
                    promoCode.setDiscountType(rs.getString("discount_type"));
                    promoCode.setDiscountValue(rs.getBigDecimal("discount_value"));
                    promoCode.setMaxUses(rs.getInt("max_uses"));
                    promoCode.setPerCustomerLimit(rs.getInt("per_customer_limit"));
                    
                    Timestamp startAt = rs.getTimestamp("start_at");
                    if (startAt != null) {
                        promoCode.setStartAt(startAt.toLocalDateTime());
                    }
                    
                    Timestamp endAt = rs.getTimestamp("end_at");
                    if (endAt != null) {
                        promoCode.setEndAt(endAt.toLocalDateTime());
                    }
                    
                    promoCode.setMinOrderAmount(rs.getBigDecimal("min_order_amount"));
                    return promoCode;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding promo code by code: " + code, e);
        }
        return null;
    }
    
    public boolean create(PromoCode promoCode) {
        String sql = "INSERT INTO PromoCodes (code, discount_type, discount_value, max_uses, per_customer_limit, start_at, end_at, min_order_amount) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, promoCode.getCode());
            ps.setString(2, promoCode.getDiscountType());
            ps.setBigDecimal(3, promoCode.getDiscountValue());
            ps.setInt(4, promoCode.getMaxUses());
            ps.setInt(5, promoCode.getPerCustomerLimit());
            
            if (promoCode.getStartAt() != null) {
                ps.setTimestamp(6, Timestamp.valueOf(promoCode.getStartAt()));
            } else {
                ps.setNull(6, Types.TIMESTAMP);
            }
            
            if (promoCode.getEndAt() != null) {
                ps.setTimestamp(7, Timestamp.valueOf(promoCode.getEndAt()));
            } else {
                ps.setNull(7, Types.TIMESTAMP);
            }
            
            ps.setBigDecimal(8, promoCode.getMinOrderAmount());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating promo code", e);
        }
        return false;
    }
    
    public boolean update(PromoCode promoCode) {
        String sql = "UPDATE PromoCodes SET code = ?, discount_type = ?, discount_value = ?, max_uses = ?, per_customer_limit = ?, start_at = ?, end_at = ?, min_order_amount = ? WHERE id = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, promoCode.getCode());
            ps.setString(2, promoCode.getDiscountType());
            ps.setBigDecimal(3, promoCode.getDiscountValue());
            ps.setInt(4, promoCode.getMaxUses());
            ps.setInt(5, promoCode.getPerCustomerLimit());
            
            if (promoCode.getStartAt() != null) {
                ps.setTimestamp(6, Timestamp.valueOf(promoCode.getStartAt()));
            } else {
                ps.setNull(6, Types.TIMESTAMP);
            }
            
            if (promoCode.getEndAt() != null) {
                ps.setTimestamp(7, Timestamp.valueOf(promoCode.getEndAt()));
            } else {
                ps.setNull(7, Types.TIMESTAMP);
            }
            
            ps.setBigDecimal(8, promoCode.getMinOrderAmount());
            ps.setLong(9, promoCode.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating promo code: " + promoCode.getId(), e);
        }
        return false;
    }
    
    public boolean delete(Long id) {
        String sql = "DELETE FROM PromoCodes WHERE id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting promo code: " + id, e);
        }
        return false;
    }
}
