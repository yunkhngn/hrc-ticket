package hrc.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class PromoCode {
    private Long id;
    private String code;
    private String discountType;
    private BigDecimal discountValue;
    private Integer maxUses;
    private Integer perCustomerLimit;
    private LocalDateTime startAt;
    private LocalDateTime endAt;
    private BigDecimal minOrderAmount;
    
    public PromoCode() {}
    
    public PromoCode(Long id, String code, String discountType, BigDecimal discountValue, 
                     Integer maxUses, Integer perCustomerLimit, LocalDateTime startAt, 
                     LocalDateTime endAt, BigDecimal minOrderAmount) {
        this.id = id;
        this.code = code;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.maxUses = maxUses;
        this.perCustomerLimit = perCustomerLimit;
        this.startAt = startAt;
        this.endAt = endAt;
        this.minOrderAmount = minOrderAmount;
    }
    
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getCode() {
        return code;
    }
    
    public void setCode(String code) {
        this.code = code;
    }
    
    public String getDiscountType() {
        return discountType;
    }
    
    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }
    
    public BigDecimal getDiscountValue() {
        return discountValue;
    }
    
    public void setDiscountValue(BigDecimal discountValue) {
        this.discountValue = discountValue;
    }
    
    public Integer getMaxUses() {
        return maxUses;
    }
    
    public void setMaxUses(Integer maxUses) {
        this.maxUses = maxUses;
    }
    
    public Integer getPerCustomerLimit() {
        return perCustomerLimit;
    }
    
    public void setPerCustomerLimit(Integer perCustomerLimit) {
        this.perCustomerLimit = perCustomerLimit;
    }
    
    public LocalDateTime getStartAt() {
        return startAt;
    }
    
    public void setStartAt(LocalDateTime startAt) {
        this.startAt = startAt;
    }
    
    public LocalDateTime getEndAt() {
        return endAt;
    }
    
    public void setEndAt(LocalDateTime endAt) {
        this.endAt = endAt;
    }
    
    public BigDecimal getMinOrderAmount() {
        return minOrderAmount;
    }
    
    public void setMinOrderAmount(BigDecimal minOrderAmount) {
        this.minOrderAmount = minOrderAmount;
    }
}
