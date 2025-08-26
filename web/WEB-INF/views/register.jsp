<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - HRC</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Register</h1>
    
    <c:if test="${not empty error}">
        <div class="error">
            <p style="color: red;">${error}</p>
        </div>
    </c:if>
    
    <form action="${pageContext.request.contextPath}/register" method="post">
        <div>
            <label for="fullName">Full Name:</label>
            <input type="text" id="fullName" name="fullName" required>
        </div>
        <div>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div>
            <label for="phone">Phone:</label>
            <input type="tel" id="phone" name="phone" required>
        </div>
        <div>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required minlength="6">
        </div>
        <div>
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required minlength="6">
        </div>
        <div>
            <button type="submit">Register</button>
        </div>
    </form>
    
    <div class="navigation">
        <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
        <a href="${pageContext.request.contextPath}/events">Browse Events (Public)</a>
    </div>
</body>
</html>
