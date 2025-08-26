<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Event Zones Management</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Event Zones Management</h1>
    
    <div class="event-info" style="background: #f8f9fa; padding: 15px; margin: 15px 0; border-radius: 5px;">
        <h2>${event.name}</h2>
        <p><strong>Event ID:</strong> ${event.id}</p>
        <p><strong>Description:</strong> ${event.description}</p>
        <p><strong>Date:</strong> ${event.startAt}</p>
        <p><strong>Status:</strong> 
            <span style="color: ${event.status eq 'ONSALE' ? 'green' : event.status eq 'DRAFT' ? 'orange' : event.status eq 'CANCELLED' ? 'red' : 'blue'}; font-weight: bold;">
                ${event.status}
            </span>
        </p>
    </div>
    
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
        <button onclick="showCreateForm()" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Add New Zone</button>
    </div>
    
    <c:if test="${not empty eventZones}">
        <div class="event-zones-list">
            <h3>Current Event Zones</h3>
            <c:forEach var="eventZone" items="${eventZones}">
                <div class="event-zone-item" style="border: 1px solid #ddd; margin: 10px 0; padding: 15px; border-radius: 5px; background-color: #fff;">
                    <h4>${eventZone.venueZoneName}</h4>
                    <p><strong>Zone ID:</strong> ${eventZone.id}</p>
                    <p><strong>Venue Zone ID:</strong> ${eventZone.venueZoneId}</p>
                    <p><strong>Capacity:</strong> ${eventZone.venueZoneCapacity} seats</p>
                    <p><strong>Price:</strong> ${eventZone.currency} ${eventZone.price}</p>
                    <p><strong>Fee:</strong> ${eventZone.currency} ${eventZone.fee}</p>
                    <p><strong>Allocation:</strong> ${eventZone.allocation} tickets</p>
                    
                    <div class="event-zone-actions">
                        <button onclick="editEventZone(${eventZone.id}, ${eventZone.venueZoneId}, '${eventZone.currency}', ${eventZone.price}, ${eventZone.fee}, ${eventZone.allocation})" style="margin: 2px; padding: 5px 10px; background: #007bff; color: white; border: none; cursor: pointer;">Edit</button>
                        <form action="${pageContext.request.contextPath}/admin/event-zones" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="eventId" value="${event.id}">
                            <input type="hidden" name="eventZoneId" value="${eventZone.id}">
                            <button type="submit" onclick="return confirm('Are you sure you want to delete this event zone?')" style="margin: 2px; padding: 5px 10px; background: #dc3545; color: white; border: none; cursor: pointer;">Delete</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
    
    <c:if test="${empty eventZones}">
        <p style="color: #6c757d; font-style: italic;">No zones configured for this event yet.</p>
    </c:if>
    
    <!-- Create Event Zone Form (Hidden by default) -->
    <div id="createForm" style="display: none; margin-top: 20px; padding: 20px; border: 1px solid #ccc; background-color: #f8f9fa;">
        <h3>Add New Event Zone</h3>
        <form action="${pageContext.request.contextPath}/admin/event-zones" method="post">
            <input type="hidden" name="action" value="create">
            <input type="hidden" name="eventId" value="${event.id}">
            <div>
                <label for="venueZoneId">Venue Zone:</label>
                <select id="venueZoneId" name="venueZoneId" required style="padding: 8px; margin: 5px 0; width: 100%;">
                    <option value="">Select a venue zone</option>
                    <c:forEach var="venueZone" items="${availableVenueZones}">
                        <option value="${venueZone.id}">${venueZone.name} (${venueZone.capacity} seats)</option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <label for="currency">Currency:</label>
                <select id="currency" name="currency" required style="padding: 8px; margin: 5px 0;">
                    <option value="">Select currency</option>
                    <option value="USD">USD</option>
                    <option value="EUR">EUR</option>
                    <option value="GBP">GBP</option>
                    <option value="VND">VND</option>
                </select>
            </div>
            <div>
                <label for="price">Price:</label>
                <input type="number" id="price" name="price" step="0.01" min="0" required style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <label for="fee">Fee (Optional):</label>
                <input type="number" id="fee" name="fee" step="0.01" min="0" style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <label for="allocation">Ticket Allocation:</label>
                <input type="number" id="allocation" name="allocation" min="1" required style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Add Zone</button>
                <button type="button" onclick="hideCreateForm()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; cursor: pointer;">Cancel</button>
            </div>
        </form>
    </div>
    
    <!-- Edit Event Zone Form (Hidden by default) -->
    <div id="editForm" style="display: none; margin-top: 20px; padding: 20px; border: 1px solid #ccc; background-color: #f8f9fa;">
        <h3>Edit Event Zone</h3>
        <form action="${pageContext.request.contextPath}/admin/event-zones" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="eventId" value="${event.id}">
            <input type="hidden" id="editEventZoneId" name="eventZoneId">
            <div>
                <label for="editVenueZoneId">Venue Zone:</label>
                <select id="editVenueZoneId" name="venueZoneId" required style="padding: 8px; margin: 5px 0; width: 100%;">
                    <option value="">Select a venue zone</option>
                    <c:forEach var="venueZone" items="${availableVenueZones}">
                        <option value="${venueZone.id}">${venueZone.name} (${venueZone.capacity} seats)</option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <label for="editCurrency">Currency:</label>
                <select id="editCurrency" name="currency" required style="padding: 8px; margin: 5px 0;">
                    <option value="">Select currency</option>
                    <option value="USD">USD</option>
                    <option value="EUR">EUR</option>
                    <option value="GBP">GBP</option>
                    <option value="VND">VND</option>
                </select>
            </div>
            <div>
                <label for="editPrice">Price:</label>
                <input type="number" id="editPrice" name="price" step="0.01" min="0" required style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <label for="editFee">Fee (Optional):</label>
                <input type="number" id="editFee" name="fee" step="0.01" min="0" style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <label for="editAllocation">Ticket Allocation:</label>
                <input type="number" id="editAllocation" name="allocation" min="1" required style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #007bff; color: white; border: none; cursor: pointer;">Update Zone</button>
                <button type="button" onclick="hideEditForm()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; cursor: pointer;">Cancel</button>
            </div>
        </form>
    </div>
    
    <div class="navigation">
        <a href="${pageContext.request.contextPath}/admin/events" style="display: inline-block; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; margin: 5px;">← Back to Events</a>
        <a href="${pageContext.request.contextPath}/admin" style="display: inline-block; padding: 10px 20px; background: #007bff; color: white; text-decoration: none; margin: 5px;">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/venues" style="display: inline-block; padding: 10px 20px; background: #20c997; color: white; text-decoration: none; margin: 5px;">Manage Venues</a>
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
        
        function editEventZone(eventZoneId, venueZoneId, currency, price, fee, allocation) {
            document.getElementById('editEventZoneId').value = eventZoneId;
            document.getElementById('editVenueZoneId').value = venueZoneId;
            document.getElementById('editCurrency').value = currency;
            document.getElementById('editPrice').value = price;
            document.getElementById('editFee').value = fee || '';
            document.getElementById('editAllocation').value = allocation;
            
            document.getElementById('editForm').style.display = 'block';
            document.getElementById('createForm').style.display = 'none';
        }
        
        function hideEditForm() {
            document.getElementById('editForm').style.display = 'none';
        }
    </script>
</body>
</html>
