<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - HRC</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Admin Dashboard</h1>
    
    <div class="admin-stats">
        <h2>Statistics</h2>
        <div class="stats-grid">
            <div class="stat-item">
                <h3>Total Events</h3>
                <p>${totalEvents}</p>
            </div>
            <div class="stat-item">
                <h3>Total Orders</h3>
                <p>${totalOrders}</p>
            </div>
            <div class="stat-item">
                <h3>Pending Orders</h3>
                <p style="color: orange;">${pendingOrders}</p>
            </div>
        </div>
    </div>
    
    <div class="admin-actions">
        <h2>Quick Actions</h2>
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/admin/accounts" style="display: inline-block; padding: 10px 20px; background: #007bff; color: white; text-decoration: none; margin: 5px;">Manage Staff & Admin</a>
            <a href="${pageContext.request.contextPath}/admin/customers" style="display: inline-block; padding: 10px 20px; background: #17a2b8; color: white; text-decoration: none; margin: 5px;">Manage Customers</a>
                    <a href="${pageContext.request.contextPath}/admin/venues" style="display: inline-block; padding: 10px 20px; background: #20c997; color: white; text-decoration: none; margin: 5px;">Manage Venues</a>
        <a href="${pageContext.request.contextPath}/admin/artists" style="display: inline-block; padding: 10px 20px; background: #fd7e14; color: white; text-decoration: none; margin: 5px;">Manage Artists</a>
        <a href="${pageContext.request.contextPath}/admin/promo-codes" style="display: inline-block; padding: 10px 20px; background: #6f42c1; color: white; text-decoration: none; margin: 5px;">Manage Promo Codes</a>
            <a href="${pageContext.request.contextPath}/admin/events" style="display: inline-block; padding: 10px 20px; background: #28a745; color: white; text-decoration: none; margin: 5px;">Manage Events</a>
            <a href="${pageContext.request.contextPath}/admin/orders" style="display: inline-block; padding: 10px 20px; background: #ffc107; color: black; text-decoration: none; margin: 5px;">Manage Orders</a>
            <a href="${pageContext.request.contextPath}/logout" style="display: inline-block; padding: 10px 20px; background: #dc3545; color: white; text-decoration: none; margin: 5px;">Logout</a>
        </div>
    </div>
    
    <div class="recent-orders">
        <h2>Recent Orders</h2>
        <c:if test="${not empty recentOrders}">
            <div class="orders-list">
                <c:forEach var="order" items="${recentOrders}">
                    <div class="order-item">
                        <h4>Order #${order.id}</h4>
                        <p><strong>Customer ID:</strong> ${order.customerId}</p>
                        <p><strong>Status:</strong> ${order.status}</p>
                        <p><strong>Payment Status:</strong> ${order.paymentStatus}</p>
                        <p><strong>Total:</strong> <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="VND"/></p>
                        <p><strong>Date:</strong> ${order.createdAt}</p>
                        <a href="${pageContext.request.contextPath}/order?id=${order.id}">View Details</a>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${empty recentOrders}">
            <p>No orders found.</p>
        </c:if>
    </div>
    
    <div class="recent-events">
        <h2>Recent Events</h2>
        <c:if test="${not empty recentEvents}">
            <div class="events-list">
                <c:forEach var="event" items="${recentEvents}">
                    <div class="event-item">
                        <h4>${event.name}</h4>
                        <p><strong>Status:</strong> ${event.status}</p>
                        <p><strong>Date:</strong> ${event.startAt}</p>
                        <p><strong>Venue ID:</strong> ${event.venueId}</p>
                        <a href="${pageContext.request.contextPath}/event?id=${event.id}">View Details</a>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${empty recentEvents}">
            <p>No events found.</p>
        </c:if>
    </div>
    

</body>
</html>
