package hrc.entity;

public class VenueZone {
    private Long id;
    private Long venueId;
    private String name;
    private Integer capacity;
    
    public VenueZone() {}
    
    public VenueZone(Long id, Long venueId, String name, Integer capacity) {
        this.id = id;
        this.venueId = venueId;
        this.name = name;
        this.capacity = capacity;
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
    
    public Integer getCapacity() {
        return capacity;
    }
    
    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }
}
