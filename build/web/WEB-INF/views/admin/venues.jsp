<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Venue Management</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Venue Management</h1>
    
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
        <button onclick="showCreateForm()" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Create New Venue</button>
    </div>
    
    <c:if test="${not empty venues}">
        <div class="venues-list">
            <c:forEach var="venue" items="${venues}">
                <div class="venue-item" style="border: 1px solid #ddd; margin: 10px 0; padding: 15px; border-radius: 5px;">
                    <h3>${venue.name}</h3>
                    <p><strong>Address:</strong> ${venue.address}</p>
                    <p><strong>City:</strong> ${venue.city}</p>
                    <p><strong>Capacity:</strong> ${venue.capacity != null ? venue.capacity : 'Not specified'}</p>
                    
                    <div class="venue-actions">
                        <button onclick="editVenue(${venue.id}, '${venue.name}', '${venue.address}', '${venue.city}', ${venue.capacity})" style="margin: 2px; padding: 5px 10px; background: #007bff; color: white; border: none; cursor: pointer;">Edit</button>
                        <a href="${pageContext.request.contextPath}/admin/venue-zones?venueId=${venue.id}" style="margin: 2px; padding: 5px 10px; background: #20c997; color: white; border: none; cursor: pointer; text-decoration: none; display: inline-block;">Manage Zones</a>
                        <form action="${pageContext.request.contextPath}/admin/venues" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="venueId" value="${venue.id}">
                            <button type="submit" onclick="return confirm('Are you sure you want to delete this venue? This will also delete all associated events and zones.')" style="margin: 2px; padding: 5px 10px; background: #dc3545; color: white; border: none; cursor: pointer;">Delete</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
    
    <c:if test="${empty venues}">
        <p>No venues available.</p>
    </c:if>
    
    <!-- Create Venue Form (Hidden by default) -->
    <div id="createForm" style="display: none; margin-top: 20px; padding: 20px; border: 1px solid #ccc;">
        <h3>Create New Venue</h3>
        <form action="${pageContext.request.contextPath}/admin/venues" method="post">
            <input type="hidden" name="action" value="create">
            <div>
                <label for="name">Venue Name:</label>
                <input type="text" id="name" name="name" required style="width: 100%; padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" style="width: 100%; padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="city">City:</label>
                <input type="text" id="city" name="city" style="width: 100%; padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="capacity">Capacity (Optional):</label>
                <input type="number" id="capacity" name="capacity" min="1" style="padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Create Venue</button>
                <button type="button" onclick="hideCreateForm()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; cursor: pointer;">Cancel</button>
            </div>
        </form>
    </div>
    
    <!-- Edit Venue Form (Hidden by default) -->
    <div id="editForm" style="display: none; margin-top: 20px; padding: 20px; border: 1px solid #ccc;">
        <h3>Edit Venue</h3>
        <form action="${pageContext.request.contextPath}/admin/venues" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="editVenueId" name="venueId">
            <div>
                <label for="editName">Venue Name:</label>
                <input type="text" id="editName" name="name" required style="width: 100%; padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="editAddress">Address:</label>
                <input type="text" id="editAddress" name="address" style="width: 100%; padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="editCity">City:</label>
                <input type="text" id="editCity" name="city" style="width: 100%; padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="editCapacity">Capacity (Optional):</label>
                <input type="number" id="editCapacity" name="capacity" min="1" style="padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #007bff; color: white; border: none; cursor: pointer;">Update Venue</button>
                <button type="button" onclick="hideEditForm()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; cursor: pointer;">Cancel</button>
            </div>
        </form>
    </div>
    
    <div class="navigation">
        <a href="${pageContext.request.contextPath}/admin" style="display: inline-block; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; margin: 5px;">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/events" style="display: inline-block; padding: 10px 20px; background: #28a745; color: white; text-decoration: none; margin: 5px;">Manage Events</a>
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
        
        function editVenue(venueId, name, address, city, capacity) {
            document.getElementById('editVenueId').value = venueId;
            document.getElementById('editName').value = name;
            document.getElementById('editAddress').value = address || '';
            document.getElementById('editCity').value = city || '';
            document.getElementById('editCapacity').value = capacity || '';
            
            document.getElementById('editForm').style.display = 'block';
            document.getElementById('createForm').style.display = 'none';
        }
        
        function hideEditForm() {
            document.getElementById('editForm').style.display = 'none';
        }
    </script>
</body>
</html>
