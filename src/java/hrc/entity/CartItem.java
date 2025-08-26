package hrc.entity;

import java.math.BigDecimal;

public class CartItem {
    private Long eventZoneId;
    private String eventName;
    private String zoneName;
    private Integer quantity;
    private BigDecimal price;
    private BigDecimal fee;
    private BigDecimal total;
    
    public CartItem() {}
    
    public CartItem(Long eventZoneId, String eventName, String zoneName, Integer quantity, 
                   BigDecimal price, BigDecimal fee) {
        this.eventZoneId = eventZoneId;
        this.eventName = eventName;
        this.zoneName = zoneName;
        this.quantity = quantity;
        this.price = price;
        this.fee = fee;
        this.total = price.add(fee).multiply(BigDecimal.valueOf(quantity));
    }
    
    public Long getEventZoneId() { return eventZoneId; }
    public void setEventZoneId(Long eventZoneId) { this.eventZoneId = eventZoneId; }
    
    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }
    
    public String getZoneName() { return zoneName; }
    public void setZoneName(String zoneName) { this.zoneName = zoneName; }
    
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { 
        this.quantity = quantity; 
        if (price != null && fee != null) {
            this.total = price.add(fee).multiply(BigDecimal.valueOf(quantity));
        }
    }
    
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    
    public BigDecimal getFee() { return fee; }
    public void setFee(BigDecimal fee) { this.fee = fee; }
    
    public BigDecimal getTotal() { return total; }
    public void setTotal(BigDecimal total) { this.total = total; }
}
