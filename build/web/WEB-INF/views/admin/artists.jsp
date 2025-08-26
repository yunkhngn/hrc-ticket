<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Artist Management</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Artist Management</h1>
    
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
        <button onclick="showCreateForm()" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Create New Artist</button>
    </div>
    
    <c:if test="${not empty artists}">
        <div class="artists-list">
            <c:forEach var="artist" items="${artists}">
                <div class="artist-item" style="border: 1px solid #ddd; margin: 10px 0; padding: 15px; border-radius: 5px;">
                    <h3>${artist.name}</h3>
                    <p><strong>Country:</strong> ${artist.country}</p>
                    <p><strong>About:</strong> ${artist.about}</p>
                    
                    <div class="artist-actions">
                        <button onclick="editArtist(${artist.id}, '${artist.name}', '${artist.country}', '${artist.about}')" style="margin: 2px; padding: 5px 10px; background: #007bff; color: white; border: none; cursor: pointer;">Edit</button>
                        <form action="${pageContext.request.contextPath}/admin/artists" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="artistId" value="${artist.id}">
                            <button type="submit" onclick="return confirm('Are you sure you want to delete this artist? This will also remove them from all associated events.')" style="margin: 2px; padding: 5px 10px; background: #dc3545; color: white; border: none; cursor: pointer;">Delete</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
    
    <c:if test="${empty artists}">
        <p>No artists available.</p>
    </c:if>
    
    <!-- Create Artist Form (Hidden by default) -->
    <div id="createForm" style="display: none; margin-top: 20px; padding: 20px; border: 1px solid #ccc;">
        <h3>Create New Artist</h3>
        <form action="${pageContext.request.contextPath}/admin/artists" method="post">
            <input type="hidden" name="action" value="create">
            <div>
                <label for="name">Artist Name:</label>
                <input type="text" id="name" name="name" required style="width: 100%; padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="country">Country:</label>
                <input type="text" id="country" name="country" style="width: 100%; padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="about">About:</label>
                <textarea id="about" name="about" rows="4" style="width: 100%; padding: 8px; margin: 5px 0;"></textarea>
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Create Artist</button>
                <button type="button" onclick="hideCreateForm()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; cursor: pointer;">Cancel</button>
            </div>
        </form>
    </div>
    
    <!-- Edit Artist Form (Hidden by default) -->
    <div id="editForm" style="display: none; margin-top: 20px; padding: 20px; border: 1px solid #ccc;">
        <h3>Edit Artist</h3>
        <form action="${pageContext.request.contextPath}/admin/artists" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="editArtistId" name="artistId">
            <div>
                <label for="editName">Artist Name:</label>
                <input type="text" id="editName" name="name" required style="width: 100%; padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="editCountry">Country:</label>
                <input type="text" id="editCountry" name="country" style="width: 100%; padding: 8px; margin: 5px 0;">
            </div>
            <div>
                <label for="editAbout">About:</label>
                <textarea id="editAbout" name="about" rows="4" style="width: 100%; padding: 8px; margin: 5px 0;"></textarea>
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #007bff; color: white; border: none; cursor: pointer;">Update Artist</button>
                <button type="button" onclick="hideEditForm()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; cursor: pointer;">Cancel</button>
            </div>
        </form>
    </div>
    
    <div class="navigation">
        <a href="${pageContext.request.contextPath}/admin" style="display: inline-block; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; margin: 5px;">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/events" style="display: inline-block; padding: 10px 20px; background: #28a745; color: white; text-decoration: none; margin: 5px;">Manage Events</a>
        <a href="${pageContext.request.contextPath}/admin/venues" style="display: inline-block; padding: 10px 20px; background: #20c997; color: white; text-decoration: none; margin: 5px;">Manage Venues</a>
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
        
        function editArtist(artistId, name, country, about) {
            document.getElementById('editArtistId').value = artistId;
            document.getElementById('editName').value = name;
            document.getElementById('editCountry').value = country || '';
            document.getElementById('editAbout').value = about || '';
            
            document.getElementById('editForm').style.display = 'block';
            document.getElementById('createForm').style.display = 'none';
        }
        
        function hideEditForm() {
            document.getElementById('editForm').style.display = 'none';
        }
    </script>
</body>
</html>
