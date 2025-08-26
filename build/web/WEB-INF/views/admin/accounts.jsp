<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Account Management</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Staff & Admin Account Management</h1>
    
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
        <button onclick="showCreateForm()" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Create New User</button>
    </div>
    
    <c:if test="${not empty users}">
        <div class="users-list">
            <h2>All Staff & Admin Accounts</h2>
            <table border="1" style="width: 100%; border-collapse: collapse;">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Email</th>
                        <th>Full Name</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Created</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.email}</td>
                            <td>${user.fullName}</td>
                            <td>${user.phone}</td>
                            <td>
                                <span style="color: ${user.role eq 'ADMIN' ? 'red' : 'blue'}; font-weight: bold;">
                                    ${user.role}
                                </span>
                            </td>
                            <td>
                                <span style="color: ${user.active ? 'green' : 'red'};">
                                    ${user.active ? 'Active' : 'Inactive'}
                                </span>
                            </td>
                            <td>${user.createdAt}</td>
                            <td>
                                <button onclick="editUser(${user.id}, '${user.email}', '${user.fullName}', '${user.phone}', '${user.role}')" style="margin: 2px; padding: 5px 10px; background: #007bff; color: white; border: none; cursor: pointer;">Edit</button>
                                
                                <c:if test="${user.id ne sessionScope.userId}">
                                    <form action="${pageContext.request.contextPath}/admin/accounts" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="toggleStatus">
                                        <input type="hidden" name="userId" value="${user.id}">
                                        <button type="submit" style="margin: 2px; padding: 5px 10px; background: ${user.active ? '#ffc107' : '#28a745'}; color: white; border: none; cursor: pointer;">
                                            ${user.active ? 'Deactivate' : 'Activate'}
                                        </button>
                                    </form>
                                    
                                    <form action="${pageContext.request.contextPath}/admin/accounts" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="userId" value="${user.id}">
                                        <button type="submit" onclick="return confirm('Are you sure you want to deactivate this user?')" style="margin: 2px; padding: 5px 10px; background: #dc3545; color: white; border: none; cursor: pointer;">Deactivate</button>
                                    </form>
                                    
                                    <c:if test="${!user.active}">
                                        <form action="${pageContext.request.contextPath}/admin/accounts" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="permanentDelete">
                                            <input type="hidden" name="userId" value="${user.id}">
                                            <button type="submit" onclick="return confirm('WARNING: This will PERMANENTLY DELETE the user account. This action cannot be undone. Are you absolutely sure?')" style="margin: 2px; padding: 5px 10px; background: #8B0000; color: white; border: none; cursor: pointer;">Permanent Delete</button>
                                        </form>
                                    </c:if>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
    
    <c:if test="${empty users}">
        <p>No users found.</p>
    </c:if>
    
    <!-- Create User Form (Hidden by default) -->
    <div id="createForm" style="display: none; margin-top: 20px; padding: 20px; border: 1px solid #ccc;">
        <h3>Create New User</h3>
        <form action="${pageContext.request.contextPath}/admin/accounts" method="post">
            <input type="hidden" name="action" value="create">
            <div>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div>
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" required>
            </div>
            <div>
                <label for="phone">Phone:</label>
                <input type="tel" id="phone" name="phone">
            </div>
            <div>
                <label for="role">Role:</label>
                <select id="role" name="role">
                    <option value="STAFF">Staff</option>
                    <option value="ADMIN">Admin</option>
                </select>
            </div>
            <div>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Create User</button>
                <button type="button" onclick="hideCreateForm()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; cursor: pointer;">Cancel</button>
            </div>
        </form>
    </div>
    
    <!-- Edit User Form (Hidden by default) -->
    <div id="editForm" style="display: none; margin-top: 20px; padding: 20px; border: 1px solid #ccc;">
        <h3>Edit User</h3>
        <form action="${pageContext.request.contextPath}/admin/accounts" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="editUserId" name="userId">
            <div>
                <label for="editEmail">Email:</label>
                <input type="email" id="editEmail" name="email" required>
            </div>
            <div>
                <label for="editFullName">Full Name:</label>
                <input type="text" id="editFullName" name="fullName" required>
            </div>
            <div>
                <label for="editPhone">Phone:</label>
                <input type="tel" id="editPhone" name="phone">
            </div>
            <div>
                <label for="editRole">Role:</label>
                <select id="editRole" name="role">
                    <option value="STAFF">Staff</option>
                    <option value="ADMIN">Admin</option>
                </select>
            </div>
            <div>
                <label for="editPassword">New Password (leave blank to keep current):</label>
                <input type="password" id="editPassword" name="password">
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #007bff; color: white; border: none; cursor: pointer;">Update User</button>
                <button type="button" onclick="hideEditForm()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; cursor: pointer;">Cancel</button>
            </div>
        </form>
    </div>
    
    <div class="navigation">
        <a href="${pageContext.request.contextPath}/admin">Back to Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/customers">Manage Customers</a>
        <a href="${pageContext.request.contextPath}/admin/events">Manage Events</a>
        <a href="${pageContext.request.contextPath}/admin/orders">Manage Orders</a>
    </div>
    
    <script>
        function showCreateForm() {
            document.getElementById('createForm').style.display = 'block';
            document.getElementById('editForm').style.display = 'none';
        }
        
        function hideCreateForm() {
            document.getElementById('createForm').style.display = 'none';
        }
        
        function editUser(userId, email, fullName, phone, role) {
            document.getElementById('editUserId').value = userId;
            document.getElementById('editEmail').value = email;
            document.getElementById('editFullName').value = fullName;
            document.getElementById('editPhone').value = phone;
            document.getElementById('editRole').value = role;
            
            document.getElementById('editForm').style.display = 'block';
            document.getElementById('createForm').style.display = 'none';
        }
        
        function hideEditForm() {
            document.getElementById('editForm').style.display = 'none';
        }
    </script>
</body>
</html>
