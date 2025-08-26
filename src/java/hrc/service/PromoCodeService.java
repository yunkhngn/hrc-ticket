package hrc.service;

import hrc.dao.PromoCodeDAO;
import hrc.entity.PromoCode;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

public class PromoCodeService {
    private final PromoCodeDAO promoCodeDAO;
    
    public PromoCodeService() {
        this.promoCodeDAO = new PromoCodeDAO();
    }
    
    /**
     * Validates a promo code and returns validation result
     */
    public Map<String, Object> validatePromoCode(String code, BigDecimal orderAmount, Long customerId) {
        Map<String, Object> result = new HashMap<>();
        
        if (code == null || code.trim().isEmpty()) {
            result.put("valid", false);
            result.put("message", "Promo code is required");
            return result;
        }
        
        PromoCode promoCode = promoCodeDAO.findByCode(code.trim().toUpperCase());
        
        if (promoCode == null) {
            result.put("valid", false);
            result.put("message", "Invalid promo code");
            return result;
        }
        
        // Check if promo code is active (within date range)
        LocalDateTime now = LocalDateTime.now();
        
        if (promoCode.getStartAt() != null && now.isBefore(promoCode.getStartAt())) {
            result.put("valid", false);
            result.put("message", "Promo code is not yet active");
            return result;
        }
        
        if (promoCode.getEndAt() != null && now.isAfter(promoCode.getEndAt())) {
            result.put("valid", false);
            result.put("message", "Promo code has expired");
            return result;
        }
        
        // Check minimum order amount
        if (promoCode.getMinOrderAmount() != null && orderAmount.compareTo(promoCode.getMinOrderAmount()) < 0) {
            result.put("valid", false);
            result.put("message", "Minimum order amount required: " + promoCode.getMinOrderAmount());
            return result;
        }
        
        // TODO: Check max uses and per customer limit (would need additional tables/DAOs)
        // For now, we'll skip these validations
        
        result.put("valid", true);
        result.put("promoCode", promoCode);
        result.put("message", "Promo code applied successfully");
        
        return result;
    }
    
    /**
     * Calculates discount amount based on promo code and order amount
     */
    public BigDecimal calculateDiscount(PromoCode promoCode, BigDecimal orderAmount) {
        if (promoCode == null || orderAmount == null) {
            return BigDecimal.ZERO;
        }
        
        if ("PERCENTAGE".equals(promoCode.getDiscountType())) {
            // Calculate percentage discount
            return orderAmount.multiply(promoCode.getDiscountValue())
                             .divide(BigDecimal.valueOf(100), 2, BigDecimal.ROUND_HALF_UP);
        } else if ("FIXED_AMOUNT".equals(promoCode.getDiscountType())) {
            // Return fixed amount discount (but don't exceed order amount)
            return promoCode.getDiscountValue().min(orderAmount);
        }
        
        return BigDecimal.ZERO;
    }
    
    /**
     * Calculates final amount after applying promo code discount
     */
    public BigDecimal calculateFinalAmount(PromoCode promoCode, BigDecimal orderAmount) {
        BigDecimal discount = calculateDiscount(promoCode, orderAmount);
        return orderAmount.subtract(discount).max(BigDecimal.ZERO);
    }
}
