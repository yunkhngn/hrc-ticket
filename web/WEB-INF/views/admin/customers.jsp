<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Customer Management</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Customer Account Management</h1>
    
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
        <button onclick="showCreateForm()" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Create New Customer</button>
    </div>
    
    <c:if test="${not empty customers}">
        <div class="customers-list">
            <h2>All Customer Accounts</h2>
            <table border="1" style="width: 100%; border-collapse: collapse;">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Email</th>
                        <th>Full Name</th>
                        <th>Phone</th>
                        <th>Created</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="customer" items="${customers}">
                        <tr>
                            <td>${customer.id}</td>
                            <td>${customer.email}</td>
                            <td>${customer.fullName}</td>
                            <td>${customer.phone}</td>
                            <td>${customer.createdAt}</td>
                            <td>
                                <button onclick="editCustomer(${customer.id}, '${customer.email}', '${customer.fullName}', '${customer.phone}')" style="margin: 2px; padding: 5px 10px; background: #007bff; color: white; border: none; cursor: pointer;">Edit</button>
                                
                                <form action="${pageContext.request.contextPath}/admin/customers" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="resetPassword">
                                    <input type="hidden" name="customerId" value="${customer.id}">
                                    <button type="submit" onclick="return confirm('Reset password to: customer123?')" style="margin: 2px; padding: 5px 10px; background: #ffc107; color: white; border: none; cursor: pointer;">Reset Password</button>
                                </form>
                                
                                <form action="${pageContext.request.contextPath}/admin/customers" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="customerId" value="${customer.id}">
                                    <button type="submit" onclick="return confirm('Are you sure you want to delete this customer?')" style="margin: 2px; padding: 5px 10px; background: #dc3545; color: white; border: none; cursor: pointer;">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
    
    <c:if test="${empty customers}">
        <p>No customers found.</p>
    </c:if>
    
    <!-- Create Customer Form (Hidden by default) -->
    <div id="createForm" style="display: none; margin-top: 20px; padding: 20px; border: 1px solid #ccc;">
        <h3>Create New Customer</h3>
        <form action="${pageContext.request.contextPath}/admin/customers" method="post">
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
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Create Customer</button>
                <button type="button" onclick="hideCreateForm()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; cursor: pointer;">Cancel</button>
            </div>
        </form>
    </div>
    
    <!-- Edit Customer Form (Hidden by default) -->
    <div id="editForm" style="display: none; margin-top: 20px; padding: 20px; border: 1px solid #ccc;">
        <h3>Edit Customer</h3>
        <form action="${pageContext.request.contextPath}/admin/customers" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="editCustomerId" name="customerId">
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
                <label for="editPassword">New Password (leave blank to keep current):</label>
                <input type="password" id="editPassword" name="password">
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #007bff; color: white; border: none; cursor: pointer;">Update Customer</button>
                <button type="button" onclick="hideEditForm()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; cursor: pointer;">Cancel</button>
            </div>
        </form>
    </div>
    
    <div class="navigation">
        <a href="${pageContext.request.contextPath}/admin">Back to Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/accounts">Manage Staff & Admin</a>
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
        
        function editCustomer(customerId, email, fullName, phone) {
            document.getElementById('editCustomerId').value = customerId;
            document.getElementById('editEmail').value = email;
            document.getElementById('editFullName').value = fullName;
            document.getElementById('editPhone').value = phone;
            
            document.getElementById('editForm').style.display = 'block';
            document.getElementById('createForm').style.display = 'none';
        }
        
        function hideEditForm() {
            document.getElementById('editForm').style.display = 'none';
        }
    </script>
</body>
</html>
