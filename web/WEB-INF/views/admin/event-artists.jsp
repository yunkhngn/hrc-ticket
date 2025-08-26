<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Event Artists Management</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Event Artists Management</h1>
    <p><strong>Event ID:</strong> ${eventId}</p>
    
    <c:if test="${not empty success}">
        <div class="success">
            <p style="color: green;">${success}</p>
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="error">
            <p style="color: red;">${error}</p>
        </div>
    </c:if>
    
    <!-- Add Artist to Event Form -->
    <div style="margin-top: 20px; padding: 20px; border: 1px solid #ccc;">
        <h3>Add Artist to Event</h3>
        <form action="${pageContext.request.contextPath}/admin/event-artists" method="post">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="eventId" value="${eventId}">
            <div>
                <label for="artistId">Select Artist:</label>
                <select id="artistId" name="artistId" required style="padding: 8px; margin: 5px 0; width: 300px;">
                    <option value="">Choose an artist...</option>
                    <c:forEach var="artist" items="${allArtists}">
                        <option value="${artist.id}">${artist.name} (${artist.country})</option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <label>
                    <input type="checkbox" name="isHeadliner" style="margin-right: 5px;">
                    Mark as Headliner
                </label>
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Add Artist</button>
            </div>
        </form>
    </div>
    
    <!-- Current Event Artists -->
    <div style="margin-top: 20px;">
        <h3>Current Event Artists</h3>
        <c:if test="${not empty eventArtists}">
            <div class="event-artists-list">
                <c:forEach var="eventArtist" items="${eventArtists}">
                    <div class="event-artist-item" style="border: 1px solid #ddd; margin: 10px 0; padding: 15px; border-radius: 5px;">
                        <h4>${eventArtist.artistName}</h4>
                        <p><strong>Country:</strong> ${eventArtist.artistCountry}</p>
                        <p><strong>Headliner:</strong> 
                            <span style="color: ${eventArtist.headliner ? 'gold' : 'gray'}; font-weight: bold;">
                                ${eventArtist.headliner ? 'YES' : 'NO'}
                            </span>
                        </p>
                        
                        <div class="event-artist-actions">
                            <form action="${pageContext.request.contextPath}/admin/event-artists" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="toggle-headliner">
                                <input type="hidden" name="eventId" value="${eventId}">
                                <input type="hidden" name="artistId" value="${eventArtist.artistId}">
                                <button type="submit" style="margin: 2px; padding: 5px 10px; background: #ffc107; color: black; border: none; cursor: pointer;">
                                    ${eventArtist.headliner ? 'Remove Headliner' : 'Make Headliner'}
                                </button>
                            </form>
                            
                            <form action="${pageContext.request.contextPath}/admin/event-artists" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="eventId" value="${eventId}">
                                <input type="hidden" name="artistId" value="${eventArtist.artistId}">
                                <button type="submit" onclick="return confirm('Are you sure you want to remove this artist from the event?')" style="margin: 2px; padding: 5px 10px; background: #dc3545; color: white; border: none; cursor: pointer;">Remove</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${empty eventArtists}">
            <p>No artists assigned to this event yet.</p>
        </c:if>
    </div>
    
    <div class="navigation" style="margin-top: 30px;">
        <a href="${pageContext.request.contextPath}/admin/events" style="display: inline-block; padding: 10px 20px; background: #28a745; color: white; text-decoration: none; margin: 5px;">Back to Events</a>
        <a href="${pageContext.request.contextPath}/admin/artists" style="display: inline-block; padding: 10px 20px; background: #fd7e14; color: white; text-decoration: none; margin: 5px;">Manage Artists</a>
        <a href="${pageContext.request.contextPath}/admin" style="display: inline-block; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; margin: 5px;">Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout" style="display: inline-block; padding: 10px 20px; background: #dc3545; color: white; text-decoration: none; margin: 5px;">Logout</a>
    </div>
</body>
</html>
