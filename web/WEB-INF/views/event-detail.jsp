<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>${event.name} - HRC</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>${event.name}</h1>
    
    <div class="event-details">
        <p><strong>Description:</strong> ${event.description}</p>
        <p><strong>Date:</strong> ${event.startAt}</p>
        <c:if test="${not empty event.endAt}">
            <p><strong>End Time:</strong> ${event.endAt}</p>
        </c:if>
        <p><strong>Status:</strong> 
            <span style="color: ${event.status eq 'ONSALE' ? 'green' : event.status eq 'DRAFT' ? 'orange' : event.status eq 'CANCELLED' ? 'red' : 'blue'}; font-weight: bold;">
                ${event.status}
            </span>
        </p>
        <p><strong>Minimum Age:</strong> ${event.minAge != null ? event.minAge : 'No restriction'} years</p>
    </div>
    
    <!-- Artists Section -->
    <c:if test="${not empty artists}">
        <h2>Performing Artists</h2>
        <div class="artists-list" style="margin: 20px 0;">
            <c:forEach var="artist" items="${artists}">
                <div class="artist-item" style="border: 1px solid #ddd; margin: 10px 0; padding: 15px; border-radius: 5px; background-color: ${artist.headliner ? '#fff3cd' : '#f8f9fa'};">
                    <h3 style="margin: 0 0 10px 0; color: ${artist.headliner ? '#856404' : '#495057'};">
                        ${artist.artistName}
                        <c:if test="${artist.headliner}">
                            <span style="background: #ffc107; color: #000; padding: 2px 8px; border-radius: 3px; font-size: 0.8em; margin-left: 10px;">HEADLINER</span>
                        </c:if>
                    </h3>
                    <p style="margin: 5px 0;"><strong>Country:</strong> ${artist.artistCountry}</p>
                </div>
            </c:forEach>
        </div>
    </c:if>
    
    <c:if test="${empty artists}">
        <p style="color: #6c757d; font-style: italic;">No artists announced yet for this event.</p>
    </c:if>
    
    <c:if test="${not empty zones}">
        <h2>Available Zones</h2>
        <div class="zones-list">
            <c:forEach var="zone" items="${zones}">
                <div class="zone-item">
                    <h3>${zone.venueZoneName != null ? zone.venueZoneName : 'Zone ' + zone.id}</h3>
                    <p><strong>Price:</strong> <fmt:formatNumber value="${zone.price}" type="currency" currencySymbol="VND"/></p>
                    <p><strong>Fee:</strong> <fmt:formatNumber value="${zone.fee}" type="currency" currencySymbol="VND"/></p>
                    <p><strong>Allocation:</strong> ${zone.allocation} tickets</p>
                    
                    <c:if test="${event.status eq 'ONSALE'}">
                        <form action="${pageContext.request.contextPath}/cart" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="eventZoneId" value="${zone.id}">
                            <label for="quantity-${zone.id}">Quantity:</label>
                            <input type="number" id="quantity-${zone.id}" name="quantity" value="1" min="1" max="10">
                            <button type="submit">Add to Cart</button>
                        </form>
                    </c:if>
                    <c:if test="${event.status ne 'ONSALE'}">
                        <p style="color: #dc3545; font-weight: bold;">
                            <c:choose>
                                <c:when test="${event.status eq 'DRAFT'}">Event is in draft mode</c:when>
                                <c:when test="${event.status eq 'SOLDOUT'}">Event is sold out</c:when>
                                <c:when test="${event.status eq 'CLOSED'}">Event is closed</c:when>
                                <c:when test="${event.status eq 'CANCELLED'}">Event is cancelled</c:when>
                                <c:otherwise>Event is not available for purchase</c:otherwise>
                            </c:choose>
                        </p>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </c:if>
    
    <c:if test="${empty zones}">
        <p>No zones available for this event.</p>
    </c:if>
    
    <div class="navigation" style="margin-top: 30px; padding: 20px 0; border-top: 1px solid #ddd;">
        <a href="${pageContext.request.contextPath}/events" style="display: inline-block; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; margin: 5px; border-radius: 4px;">← Back to Events</a>
        <c:if test="${sessionScope.userRole eq 'CUSTOMER'}">
            <a href="${pageContext.request.contextPath}/cart" style="display: inline-block; padding: 10px 20px; background: #28a745; color: white; text-decoration: none; margin: 5px; border-radius: 4px;">🛒 View Cart</a>
        </c:if>
        <c:if test="${sessionScope.userRole eq 'CUSTOMER'}">
            <a href="${pageContext.request.contextPath}/orders" style="display: inline-block; padding: 10px 20px; background: #17a2b8; color: white; text-decoration: none; margin: 5px; border-radius: 4px;">📋 My Orders</a>
        </c:if>
        <c:if test="${sessionScope.userRole eq 'STAFF'}">
            <a href="${pageContext.request.contextPath}/admin/orders" style="display: inline-block; padding: 10px 20px; background: #17a2b8; color: white; text-decoration: none; margin: 5px; border-radius: 4px;">📋 Manage Orders</a>
        </c:if>
        <c:if test="${sessionScope.userRole eq 'ADMIN'}">
            <a href="${pageContext.request.contextPath}/admin/orders" style="display: inline-block; padding: 10px 20px; background: #17a2b8; color: white; text-decoration: none; margin: 5px; border-radius: 4px;">📋 Manage Orders</a>
        </c:if>
    </div>
</body>
</html>
