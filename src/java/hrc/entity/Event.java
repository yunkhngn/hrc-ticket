package hrc.entity;

import java.time.LocalDateTime;

public class Event {
    private Long id;
    private Long venueId;
    private String name;
    private String description;
    private LocalDateTime startAt;
    private LocalDateTime endAt;
    private String status;
    private Integer minAge;
    private LocalDateTime createdAt;
    
    public Event() {}
    
    public Event(Long id, Long venueId, String name, String description, LocalDateTime startAt, 
                 LocalDateTime endAt, String status, Integer minAge, LocalDateTime createdAt) {
        this.id = id;
        this.venueId = venueId;
        this.name = name;
        this.description = description;
        this.startAt = startAt;
        this.endAt = endAt;
        this.status = status;
        this.minAge = minAge;
        this.createdAt = createdAt;
    }
    
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Long getVenueId() {
        return venueId;
    }
    
    public void setVenueId(Long venueId) {
        this.venueId = venueId;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
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
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Integer getMinAge() {
        return minAge;
    }
    
    public void setMinAge(Integer minAge) {
        this.minAge = minAge;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
