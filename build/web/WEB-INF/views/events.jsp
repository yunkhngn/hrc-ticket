<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Events - HRC</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Rock Concerts</h1>
    
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
    
    <c:if test="${not empty events}">
        <div class="events-list">
            <c:forEach var="event" items="${events}">
                <div class="event-item" style="border: 1px solid #ddd; margin: 15px 0; padding: 20px; border-radius: 8px; background-color: #f8f9fa;">
                    <h3 style="margin: 0 0 10px 0; color: #495057;">${event.name}</h3>
                    <p style="margin: 5px 0; color: #6c757d;">${event.description}</p>
                    <p style="margin: 5px 0;"><strong>Date:</strong> ${event.startAt}</p>
                    <p style="margin: 5px 0;"><strong>Status:</strong> 
                        <span style="color: ${event.status eq 'ONSALE' ? 'green' : event.status eq 'DRAFT' ? 'orange' : event.status eq 'CANCELLED' ? 'red' : 'blue'}; font-weight: bold;">
                            ${event.status}
                        </span>
                    </p>
                    <p style="margin: 5px 0;"><strong>Min Age:</strong> ${event.minAge != null ? event.minAge : 'No restriction'} years</p>
                    
                    <!-- Artists Preview -->
                    <c:set var="eventArtists" value="${eventArtistsMap[event.id]}" />
                    <c:if test="${not empty eventArtists}">
                        <div style="margin: 10px 0; padding: 10px; background-color: #e9ecef; border-radius: 5px;">
                            <p style="margin: 0 0 5px 0; font-weight: bold; color: #495057;">Featured Artists:</p>
                            <c:forEach var="artist" items="${eventArtists}" varStatus="status">
                                <span style="display: inline-block; margin: 2px 5px 2px 0; padding: 3px 8px; background-color: ${artist.headliner ? '#ffc107' : '#6c757d'}; color: ${artist.headliner ? '#000' : '#fff'}; border-radius: 3px; font-size: 0.9em;">
                                    ${artist.artistName}
                                    <c:if test="${artist.headliner}">⭐</c:if>
                                </span>
                            </c:forEach>
                        </div>
                    </c:if>
                    
                    <a href="${pageContext.request.contextPath}/event?id=${event.id}" style="display: inline-block; margin-top: 10px; padding: 8px 16px; background-color: #007bff; color: white; text-decoration: none; border-radius: 4px;">View Details</a>
                </div>
            </c:forEach>
        </div>
    </c:if>
    
    <c:if test="${empty events}">
        <p>No events available.</p>
    </c:if>
    
    <div class="navigation">
        <a href="${pageContext.request.contextPath}/cart">View Cart</a>
        <c:if test="${sessionScope.userRole eq 'ADMIN'}">
            <a href="${pageContext.request.contextPath}/admin/events">Admin Events</a>
        </c:if>
        <c:if test="${not empty sessionScope.userRole}">
            <a href="${pageContext.request.contextPath}/orders">My Orders</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </c:if>
        <c:if test="${empty sessionScope.userRole}">
            <a href="${pageContext.request.contextPath}/login">Login</a>
            <a href="${pageContext.request.contextPath}/register">Register</a>
        </c:if>
    </div>
</body>
</html>
