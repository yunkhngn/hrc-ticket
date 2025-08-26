package hrc.entity;

public class EventArtist {
    private Long eventId;
    private Long artistId;
    private boolean isHeadliner;
    private String artistName;
    private String artistCountry;
    
    public EventArtist() {}
    
    public EventArtist(Long eventId, Long artistId, boolean isHeadliner) {
        this.eventId = eventId;
        this.artistId = artistId;
        this.isHeadliner = isHeadliner;
    }
    
    public Long getEventId() {
        return eventId;
    }
    
    public void setEventId(Long eventId) {
        this.eventId = eventId;
    }
    
    public Long getArtistId() {
        return artistId;
    }
    
    public void setArtistId(Long artistId) {
        this.artistId = artistId;
    }
    
    public boolean isHeadliner() {
        return isHeadliner;
    }
    
    public void setHeadliner(boolean isHeadliner) {
        this.isHeadliner = isHeadliner;
    }
    
    public String getArtistName() {
        return artistName;
    }
    
    public void setArtistName(String artistName) {
        this.artistName = artistName;
    }
    
    public String getArtistCountry() {
        return artistCountry;
    }
    
    public void setArtistCountry(String artistCountry) {
        this.artistCountry = artistCountry;
    }
}
