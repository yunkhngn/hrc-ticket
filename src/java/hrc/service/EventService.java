package hrc.service;

import hrc.dao.EventDAO;
import hrc.dao.EventZoneDAO;
import hrc.dao.EventArtistDAO;
import hrc.entity.Event;
import hrc.entity.EventZone;
import java.util.List;

public class EventService {
    private final EventDAO eventDAO;
    private final EventZoneDAO eventZoneDAO;
    
    public EventService() {
        this.eventDAO = new EventDAO();
        this.eventZoneDAO = new EventZoneDAO();
    }
    
    public List<Event> getAllEvents() {
        return eventDAO.list();
    }
    
    public List<Event> getPublicEvents() {
        return eventDAO.listPublicEvents();
    }
    
    public Event getEventById(Long id) {
        return eventDAO.findById(id);
    }
    
    public Event getEventWithZones(Long id) {
        Event event = eventDAO.findById(id);
        if (event != null) {
            List<EventZone> zones = eventZoneDAO.findByEventId(id);
            // Note: In a real application, you might want to add zones to event object
            // For now, we'll keep it simple
        }
        return event;
    }
    
    public boolean createEvent(Event event) {
        return eventDAO.create(event);
    }
    
    public boolean updateEvent(Event event) {
        return eventDAO.update(event);
    }
    
    public List<EventZone> getEventZones(Long eventId) {
        return eventZoneDAO.findByEventId(eventId);
    }
    
    public boolean deleteEvent(Long eventId) {
        // First delete related event zones
        List<EventZone> zones = eventZoneDAO.findByEventId(eventId);
        for (EventZone zone : zones) {
            eventZoneDAO.delete(zone.getId());
        }
        
        // Delete associated event artists
        EventArtistDAO eventArtistDAO = new EventArtistDAO();
        eventArtistDAO.deleteByEventId(eventId);
        
        // Then delete the event
        return eventDAO.delete(eventId);
    }
}
