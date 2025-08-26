<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Events Management - Hanoi Rock City</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Hanoi Rock City - Events Management</h1>
    
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
        <button onclick="showCreateForm()" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Create New Event</button>
    </div>
    
    <c:if test="${not empty events}">
        <div class="events-list">
                            <c:forEach var="event" items="${events}">
                    <div class="event-item" style="border: 1px solid #ddd; margin: 10px 0; padding: 15px; border-radius: 5px;">
                        <h3>${event.name}</h3>
                        <p><strong>Description:</strong> ${event.description}</p>
                        <p><strong>Date:</strong> ${event.startAt}</p>
                        <p><strong>Status:</strong> 
                            <span style="color: ${event.status eq 'ONSALE' ? 'green' : event.status eq 'DRAFT' ? 'orange' : event.status eq 'CANCELLED' ? 'red' : 'blue'}; font-weight: bold;">
                                ${event.status}
                            </span>
                        </p>
                        <p><strong>Min Age:</strong> ${event.minAge != null ? event.minAge : 'No restriction'} years</p>
                        <p><strong>Venue ID:</strong> ${event.venueId}</p>
                    
                    <div class="event-actions">
                        <button onclick="editEvent(${event.id}, '${event.name}', '${event.description}', '${event.startAt}', '${event.endAt}', '${event.status}', ${event.minAge}, ${event.venueId})" style="margin: 2px; padding: 5px 10px; background: #007bff; color: white; border: none; cursor: pointer;">Edit</button>
                        <a href="${pageContext.request.contextPath}/admin/event-artists?eventId=${event.id}" style="margin: 2px; padding: 5px 10px; background: #fd7e14; color: white; border: none; cursor: pointer; text-decoration: none; display: inline-block;">Manage Artists</a>
                        <a href="${pageContext.request.contextPath}/admin/event-zones?eventId=${event.id}" style="margin: 2px; padding: 5px 10px; background: #20c997; color: white; border: none; cursor: pointer; text-decoration: none; display: inline-block;">Manage Zones</a>
                        <form action="${pageContext.request.contextPath}/admin/events" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="eventId" value="${event.id}">
                            <button type="submit" onclick="return confirm('Are you sure you want to delete this event? This will also delete all associated event zones.')" style="margin: 2px; padding: 5px 10px; background: #dc3545; color: white; border: none; cursor: pointer;">Delete</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
    
    <c:if test="${empty events}">
        <p>No events available.</p>
    </c:if>
    
    <!-- Create Event Form (Hidden by default) -->
    <div id="createForm" style="display: none; margin-top: 20px; padding: 20px; border: 1px solid #ccc;">
        <h3>Create New Event</h3>
        <form action="${pageContext.request.contextPath}/admin/events" method="post">
            <input type="hidden" name="action" value="create">
            <div>
                <label for="name">Event Name:</label>
                <input type="text" id="name" name="name" required style="width: 100%; padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="3" style="width: 100%; padding: 8px; margin: 5px 0;"></textarea>
            </div>
            <div>
                <label for="startAt">Start Date & Time:</label>
                <input type="datetime-local" id="startAt" name="startAt" required style="padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="endAt">End Date & Time (Optional):</label>
                <input type="datetime-local" id="endAt" name="endAt" style="padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="status">Status:</label>
                <select id="status" name="status" style="padding: 8px; margin: 5px 0;">
                    <option value="DRAFT">Draft</option>
                    <option value="ONSALE">On Sale</option>
                    <option value="SOLDOUT">Sold Out</option>
                    <option value="CLOSED">Closed</option>
                    <option value="CANCELLED">Cancelled</option>
                </select>
            </div>
            <div>
                <label for="minAge">Minimum Age:</label>
                <input type="number" id="minAge" name="minAge" min="0" max="100" required style="padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="venueId">Venue:</label>
                <select id="venueId" name="venueId" required style="padding: 8px; margin: 5px 0;">
                    <option value="">Select a venue</option>
                    <c:forEach var="venue" items="${venues}">
                        <option value="${venue.id}">${venue.name} - ${venue.city}</option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Create Event</button>
                <button type="button" onclick="hideCreateForm()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; cursor: pointer;">Cancel</button>
            </div>
        </form>
    </div>
    
    <!-- Edit Event Form (Hidden by default) -->
    <div id="editForm" style="display: none; margin-top: 20px; padding: 20px; border: 1px solid #ccc;">
        <h3>Edit Event</h3>
        <form action="${pageContext.request.contextPath}/admin/events" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="editEventId" name="eventId">
            <div>
                <label for="editName">Event Name:</label>
                <input type="text" id="editName" name="name" required style="width: 100%; padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="editDescription">Description:</label>
                <textarea id="editDescription" name="description" rows="3" style="width: 100%; padding: 8px; margin: 5px 0;"></textarea>
            </div>
            <div>
                <label for="editStartAt">Start Date & Time:</label>
                <input type="datetime-local" id="editStartAt" name="startAt" required style="padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="editEndAt">End Date & Time (Optional):</label>
                <input type="datetime-local" id="editEndAt" name="endAt" style="padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="editStatus">Status:</label>
                <select id="editStatus" name="status" style="padding: 8px; margin: 5px 0;">
                    <option value="DRAFT">Draft</option>
                    <option value="ONSALE">On Sale</option>
                    <option value="SOLDOUT">Sold Out</option>
                    <option value="CLOSED">Closed</option>
                    <option value="CANCELLED">Cancelled</option>
                </select>
            </div>
            <div>
                <label for="editMinAge">Minimum Age:</label>
                <input type="number" id="editMinAge" name="minAge" min="0" max="100" required style="padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="editVenueId">Venue:</label>
                <select id="editVenueId" name="venueId" required style="padding: 8px; margin: 5px 0;">
                    <option value="">Select a venue</option>
                    <c:forEach var="venue" items="${venues}">
                        <option value="${venue.id}">${venue.name} - ${venue.city}</option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #007bff; color: white; border: none; cursor: pointer;">Update Event</button>
                <button type="button" onclick="hideEditForm()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; cursor: pointer;">Cancel</button>
            </div>
        </form>
    </div>
    
    <div class="navigation">
        <a href="${pageContext.request.contextPath}/admin" style="display: inline-block; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; margin: 5px;">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/venues" style="display: inline-block; padding: 10px 20px; background: #20c997; color: white; text-decoration: none; margin: 5px;">Manage Venues</a>
        <a href="${pageContext.request.contextPath}/admin/artists" style="display: inline-block; padding: 10px 20px; background: #fd7e14; color: white; text-decoration: none; margin: 5px;">Manage Artists</a>
        <a href="${pageContext.request.contextPath}/admin/promo-codes" style="display: inline-block; padding: 10px 20px; background: #6f42c1; color: white; text-decoration: none; margin: 5px;">Manage Promo Codes</a>
        <a href="${pageContext.request.contextPath}/admin/accounts" style="display: inline-block; padding: 10px 20px; background: #007bff; color: white; text-decoration: none; margin: 5px;">Manage Staff & Admin</a>
        <a href="${pageContext.request.contextPath}/admin/customers" style="display: inline-block; padding: 10px 20px; background: #17a2b8; color: white; text-decoration: none; margin: 5px;">Manage Customers</a>
        <a href="${pageContext.request.contextPath}/admin/orders" style="display: inline-block; padding: 10px 20px; background: #ffc107; color: black; text-decoration: none; margin: 5px;">Manage Orders</a>
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
        
        function editEvent(eventId, name, description, startAt, endAt, status, minAge, venueId) {
            document.getElementById('editEventId').value = eventId;
            document.getElementById('editName').value = name;
            document.getElementById('editDescription').value = description || '';
            
            // Format datetime for datetime-local input
            if (startAt) {
                // Convert "2025-09-20 19:30:00" to "2025-09-20T19:30"
                const formattedStartAt = startAt.replace(' ', 'T').substring(0, 16);
                document.getElementById('editStartAt').value = formattedStartAt;
            }
            
            if (endAt) {
                // Convert "2025-09-20 19:30:00" to "2025-09-20T19:30"
                const formattedEndAt = endAt.replace(' ', 'T').substring(0, 16);
                document.getElementById('editEndAt').value = formattedEndAt;
            } else {
                document.getElementById('editEndAt').value = '';
            }
            
            document.getElementById('editStatus').value = status;
            document.getElementById('editMinAge').value = (minAge && minAge !== 'null') ? minAge : '';
            document.getElementById('editVenueId').value = venueId;
            
            document.getElementById('editForm').style.display = 'block';
            document.getElementById('createForm').style.display = 'none';
        }
        
        function hideEditForm() {
            document.getElementById('editForm').style.display = 'none';
        }
    </script>
</body>
</html>
