<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Orders Management - Hanoi Rock City</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="header">
        <div class="container">
            <h1 class="rock-accent">
                🎸 Hanoi Rock City - Orders Management
                <c:if test="${sessionScope.userRole eq 'STAFF'}">
                    <span style="font-size: 0.6em; color: var(--text-secondary);">(Staff Access)</span>
                </c:if>
            </h1>
        </div>
    </div>
    
    <div class="container">
        <div class="main-content">
    
    <c:if test="${not empty success}">
        <div class="message success">
            <p>${success}</p>
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="message error">
            <p>${error}</p>
        </div>
    </c:if>
    
    <c:if test="${not empty orders}">
        <div class="orders-list grid grid-2">
            <c:forEach var="order" items="${orders}">
                <div class="order-card fade-in">
                    <div class="order-header">
                        <h3 class="order-id">Order #${order.id}</h3>
                        <span class="status-badge status-${order.status.toLowerCase()}">${order.status}</span>
                    </div>
                    
                    <div class="event-meta">
                        <div class="event-meta-item">
                            <span class="event-meta-label">👤 Customer:</span>
                            <span class="event-meta-value">#${order.customerId}</span>
                        </div>
                        <div class="event-meta-item">
                            <span class="event-meta-label">📅 Date:</span>
                            <span class="event-meta-value">${order.createdAt}</span>
                        </div>
                        <div class="event-meta-item">
                            <span class="event-meta-label">💳 Payment:</span>
                            <span class="status-badge status-${order.paymentStatus.toLowerCase()}">${order.paymentStatus}</span>
                        </div>
                        <div class="event-meta-item">
                            <span class="event-meta-label">💰 Amount:</span>
                            <span class="event-meta-value"><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="VND"/></span>
                        </div>
                        <c:if test="${not empty order.bankRef}">
                            <div class="event-meta-item">
                                <span class="event-meta-label">🏦 Bank Ref:</span>
                                <span class="event-meta-value">${order.bankRef}</span>
                            </div>
                        </c:if>
                    </div>
                    
                    <div class="order-actions">
                        <a href="${pageContext.request.contextPath}/order?id=${order.id}" class="btn btn-secondary">👁️ View Details</a>
                        
                        <c:if test="${order.paymentStatus eq 'PENDING'}">
                            <form action="${pageContext.request.contextPath}/admin/orders" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="confirm">
                                <input type="hidden" name="orderId" value="${order.id}">
                                <button type="submit" class="btn btn-success">✅ Confirm Payment</button>
                            </form>
                        </c:if>
                        
                        <c:if test="${order.status ne 'CANCELLED'}">
                            <form action="${pageContext.request.contextPath}/admin/orders" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="cancel">
                                <input type="hidden" name="orderId" value="${order.id}">
                                <button type="submit" onclick="return confirm('Are you sure you want to cancel this order?')" class="btn btn-danger">❌ Cancel Order</button>
                            </form>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
    
    <c:if test="${empty orders}">
        <div class="card text-center">
            <h3>No Orders Found</h3>
            <p>There are no orders to display at the moment.</p>
        </div>
    </c:if>
    
    <div class="navigation">
        <c:if test="${sessionScope.userRole eq 'ADMIN'}">
            <!-- Full admin navigation -->
            <a href="${pageContext.request.contextPath}/admin" class="nav-link">🏠 Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/events" class="nav-link">🎵 Manage Events</a>
            <a href="${pageContext.request.contextPath}/admin/venues" class="nav-link">🏟️ Manage Venues</a>
            <a href="${pageContext.request.contextPath}/admin/artists" class="nav-link">🎤 Manage Artists</a>
            <a href="${pageContext.request.contextPath}/admin/accounts" class="nav-link">👥 Manage Staff & Admin</a>
            <a href="${pageContext.request.contextPath}/admin/customers" class="nav-link">👤 Manage Customers</a>
            <a href="${pageContext.request.contextPath}/admin/promo-codes" class="nav-link">🎫 Manage Promo Codes</a>
        </c:if>
        
        <c:if test="${sessionScope.userRole eq 'STAFF'}">
            <!-- Staff navigation - only orders management -->
            <a href="${pageContext.request.contextPath}/events" class="nav-link">🎵 View Events</a>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/logout" class="nav-link logout">🚪 Logout</a>
    </div>
        </div>
    </div>
</body>
</html>
