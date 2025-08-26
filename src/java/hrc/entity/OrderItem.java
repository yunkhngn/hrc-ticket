package hrc.entity;

import java.math.BigDecimal;

public class OrderItem {
    private Long id;
    private Long orderId;
    private Long eventZoneId;
    private Integer qty;
    private BigDecimal unitPrice;
    private BigDecimal feeAmount;
    private BigDecimal finalPrice;
    
    public OrderItem() {}
    
    public OrderItem(Long id, Long orderId, Long eventZoneId, Integer qty, 
                     BigDecimal unitPrice, BigDecimal feeAmount, BigDecimal finalPrice) {
        this.id = id;
        this.orderId = orderId;
        this.eventZoneId = eventZoneId;
        this.qty = qty;
        this.unitPrice = unitPrice;
        this.feeAmount = feeAmount;
        this.finalPrice = finalPrice;
    }
    
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Long getOrderId() {
        return orderId;
    }
    
    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }
    
    public Long getEventZoneId() {
        return eventZoneId;
    }
    
    public void setEventZoneId(Long eventZoneId) {
        this.eventZoneId = eventZoneId;
    }
    
    public Integer getQty() {
        return qty;
    }
    
    public void setQty(Integer qty) {
        this.qty = qty;
    }
    
    public BigDecimal getUnitPrice() {
        return unitPrice;
    }
    
    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }
    
    public BigDecimal getFeeAmount() {
        return feeAmount;
    }
    
    public void setFeeAmount(BigDecimal feeAmount) {
        this.feeAmount = feeAmount;
    }
    
    public BigDecimal getFinalPrice() {
        return finalPrice;
    }
    
    public void setFinalPrice(BigDecimal finalPrice) {
        this.finalPrice = finalPrice;
    }
}
