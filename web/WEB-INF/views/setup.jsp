<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>HRC Setup - Create Admin Account</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>HRC Setup</h1>
    
    <c:if test="${not empty success}">
        <div class="success">
            <p style="color: green;">${success}</p>
        </div>
    </c:if>
    
    <div class="setup-section">
        <h2>Create Admin Account</h2>
        <p>This will create an admin account for the Hanoi Rock City (HRC) system.</p>
        
        <form action="${pageContext.request.contextPath}/setup" method="post">
            <input type="hidden" name="action" value="createAdmin">
            <button type="submit" style="padding: 10px 20px; background: #007bff; color: white; border: none; cursor: pointer;">
                Create Admin Account
            </button>
        </form>
        
        <div class="admin-info">
            <h3>Admin Account Details:</h3>
            <ul>
                <li><strong>Email:</strong> admin@hrc.com</li>
                <li><strong>Password:</strong> admin123</li>
                <li><strong>Role:</strong> ADMIN</li>
                <li><strong>Full Name:</strong> HRC Administrator</li>
            </ul>
        </div>
    </div>
    
    <div class="navigation">
        <a href="${pageContext.request.contextPath}/login">Go to Login</a>
        <a href="${pageContext.request.contextPath}/events">Browse Events</a>
    </div>
    
    <div class="warning">
        <p><strong>Important:</strong> This setup page should be removed or secured after creating the admin account.</p>
    </div>
</body>
</html>
