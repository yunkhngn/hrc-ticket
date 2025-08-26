package hrc.entity;

public class Artist {
    private Long id;
    private String name;
    private String country;
    private String about;
    
    public Artist() {}
    
    public Artist(Long id, String name, String country, String about) {
        this.id = id;
        this.name = name;
        this.country = country;
        this.about = about;
    }
    
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getCountry() {
        return country;
    }
    
    public void setCountry(String country) {
        this.country = country;
    }
    
    public String getAbout() {
        return about;
    }
    
    public void setAbout(String about) {
        this.about = about;
    }
}
