package hrc.entity;

import java.math.BigDecimal;

public class EventZone {
    private Long id;
    private Long eventId;
    private Long venueZoneId;
    private String currency;
    private BigDecimal price;
    private BigDecimal fee;
    private Integer allocation;
    
    // Additional fields for display purposes
    private String venueZoneName;
    private Integer venueZoneCapacity;
    
    public EventZone() {}
    
    public EventZone(Long id, Long eventId, Long venueZoneId, String currency, 
                     BigDecimal price, BigDecimal fee, Integer allocation) {
        this.id = id;
        this.eventId = eventId;
        this.venueZoneId = venueZoneId;
        this.currency = currency;
        this.price = price;
        this.fee = fee;
        this.allocation = allocation;
    }
    
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Long getEventId() {
        return eventId;
    }
    
    public void setEventId(Long eventId) {
        this.eventId = eventId;
    }
    
    public Long getVenueZoneId() {
        return venueZoneId;
    }
    
    public void setVenueZoneId(Long venueZoneId) {
        this.venueZoneId = venueZoneId;
    }
    
    public String getCurrency() {
        return currency;
    }
    
    public void setCurrency(String currency) {
        this.currency = currency;
    }
    
    public BigDecimal getPrice() {
        return price;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    public BigDecimal getFee() {
        return fee;
    }
    
    public void setFee(BigDecimal fee) {
        this.fee = fee;
    }
    
    public Integer getAllocation() {
        return allocation;
    }
    
    public void setAllocation(Integer allocation) {
        this.allocation = allocation;
    }
    
    public String getVenueZoneName() {
        return venueZoneName;
    }
    
    public void setVenueZoneName(String venueZoneName) {
        this.venueZoneName = venueZoneName;
    }
    
    public Integer getVenueZoneCapacity() {
        return venueZoneCapacity;
    }
    
    public void setVenueZoneCapacity(Integer venueZoneCapacity) {
        this.venueZoneCapacity = venueZoneCapacity;
    }
}
