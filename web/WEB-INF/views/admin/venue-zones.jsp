<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Venue Zones Management - Hanoi Rock City</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Hanoi Rock City - Venue Zones Management - ${venue.name}</h1>
    <p><strong>Venue:</strong> ${venue.name} - ${venue.city}</p>
    
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
    
    <div class="admin-actions">
        <button onclick="showCreateForm()" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Create New Venue Zone</button>
    </div>
    
    <c:if test="${not empty venueZones}">
        <div class="venue-zones-list">
            <c:forEach var="venueZone" items="${venueZones}">
                <div class="venue-zone-item" style="border: 1px solid #ddd; margin: 10px 0; padding: 15px; border-radius: 5px; background-color: #fff;">
                    <h3>${venueZone.name}</h3>
                    <p><strong>Zone ID:</strong> ${venueZone.id}</p>
                    <p><strong>Capacity:</strong> ${venueZone.capacity} seats</p>
                    
                    <div class="venue-zone-actions">
                        <button onclick="editVenueZone(${venueZone.id}, '${venueZone.name}', ${venueZone.capacity})" style="margin: 2px; padding: 5px 10px; background: #007bff; color: white; border: none; cursor: pointer;">Edit</button>
                        <form action="${pageContext.request.contextPath}/admin/venue-zones" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="venueZoneId" value="${venueZone.id}">
                            <input type="hidden" name="venueId" value="${venue.id}">
                            <button type="submit" onclick="return confirm('Are you sure you want to delete this venue zone?')" style="margin: 2px; padding: 5px 10px; background: #dc3545; color: white; border: none; cursor: pointer;">Delete</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
    
    <c:if test="${empty venueZones}">
        <p>No venue zones available.</p>
    </c:if>
    
    <!-- Create Venue Zone Form (Hidden by default) -->
    <div id="createForm" style="display: none; margin-top: 20px; padding: 20px; border: 1px solid #ccc; background-color: #f8f9fa;">
        <h3>Create New Venue Zone</h3>
        <form action="${pageContext.request.contextPath}/admin/venue-zones" method="post">
            <input type="hidden" name="action" value="create">
            <input type="hidden" name="venueId" value="${venue.id}">
            <div>
                <label for="name">Zone Name:</label>
                <input type="text" id="name" name="name" required style="width: 100%; padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="capacity">Capacity:</label>
                <input type="number" id="capacity" name="capacity" min="1" required style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Create Venue Zone</button>
                <button type="button" onclick="hideCreateForm()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; cursor: pointer;">Cancel</button>
            </div>
        </form>
    </div>
    
    <!-- Edit Venue Zone Form (Hidden by default) -->
    <div id="editForm" style="display: none; margin-top: 20px; padding: 20px; border: 1px solid #ccc; background-color: #f8f9fa;">
        <h3>Edit Venue Zone</h3>
        <form action="${pageContext.request.contextPath}/admin/venue-zones" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="editVenueZoneId" name="venueZoneId">
            <input type="hidden" name="venueId" value="${venue.id}">
            <div>
                <label for="editName">Zone Name:</label>
                <input type="text" id="editName" name="name" required style="width: 100%; padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="editCapacity">Capacity:</label>
                <input type="number" id="editCapacity" name="capacity" min="1" required style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #007bff; color: white; border: none; cursor: pointer;">Update Venue Zone</button>
                <button type="button" onclick="hideEditForm()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; cursor: pointer;">Cancel</button>
            </div>
        </form>
    </div>
    
    <div class="navigation">
        <a href="${pageContext.request.contextPath}/admin" style="display: inline-block; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; margin: 5px;">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/venues" style="display: inline-block; padding: 10px 20px; background: #20c997; color: white; text-decoration: none; margin: 5px;">Manage Venues</a>
        <a href="${pageContext.request.contextPath}/admin/events" style="display: inline-block; padding: 10px 20px; background: #28a745; color: white; text-decoration: none; margin: 5px;">Manage Events</a>
        <a href="${pageContext.request.contextPath}/admin/artists" style="display: inline-block; padding: 10px 20px; background: #fd7e14; color: white; text-decoration: none; margin: 5px;">Manage Artists</a>
        <a href="${pageContext.request.contextPath}/logout" style="display: inline-block; padding: 10px 20px; background: #dc3545; color: white; text-decoration: none; margin: 5px;">Logout</a>
    </div>
    
    <script>
        function showCreateForm() {
            document.getElementById('createForm').style.display = 'block';
            document.getElementById('editForm').style.display = 'none';
        }
        
        function hideCreateForm() {
            document.getElementById('createForm').style.display = 'none';
        }
        
        function editVenueZone(venueZoneId, name, capacity) {
            document.getElementById('editVenueZoneId').value = venueZoneId;
            document.getElementById('editName').value = name;
            document.getElementById('editCapacity').value = capacity;
            
            document.getElementById('editForm').style.display = 'block';
            document.getElementById('createForm').style.display = 'none';
        }
        
        function hideEditForm() {
            document.getElementById('editForm').style.display = 'none';
        }
    </script>
</body>
</html>
