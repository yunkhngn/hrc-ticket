<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Orders Management - Hanoi Rock City</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Hanoi Rock City - Orders Management
        <c:if test="${sessionScope.userRole eq 'STAFF'}">
            <span style="font-size: 0.6em; color: #6c757d;">(Staff Access)</span>
        </c:if>
    </h1>
    
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
    
    <c:if test="${not empty orders}">
        <div class="orders-list">
            <c:forEach var="order" items="${orders}">
                <div class="order-item" style="border: 1px solid #ddd; margin: 10px 0; padding: 15px; border-radius: 5px; background-color: #fff;">
                    <h3>Order #${order.id}</h3>
                    <p><strong>Customer ID:</strong> ${order.customerId}</p>
                    <p><strong>Date:</strong> ${order.createdAt}</p>
                    <p><strong>Status:</strong> ${order.status}</p>
                    <p><strong>Payment Status:</strong> ${order.paymentStatus}</p>
                    <p><strong>Total Amount:</strong> <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="VND"/></p>
                    <c:if test="${not empty order.bankRef}">
                        <p><strong>Bank Reference:</strong> ${order.bankRef}</p>
                    </c:if>
                    
                    <div class="order-actions" style="margin-top: 10px;">
                        <a href="${pageContext.request.contextPath}/order?id=${order.id}" style="display: inline-block; padding: 5px 10px; background: #007bff; color: white; text-decoration: none; margin: 2px;">View Details</a>
                        
                        <c:if test="${order.paymentStatus eq 'PENDING'}">
                            <form action="${pageContext.request.contextPath}/admin/orders" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="confirm">
                                <input type="hidden" name="orderId" value="${order.id}">
                                <button type="submit" style="padding: 5px 10px; background: #28a745; color: white; border: none; cursor: pointer; margin: 2px;">✅ Confirm Payment</button>
                            </form>
                        </c:if>
                        
                        <c:if test="${order.status ne 'CANCELLED'}">
                            <form action="${pageContext.request.contextPath}/admin/orders" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="cancel">
                                <input type="hidden" name="orderId" value="${order.id}">
                                <button type="submit" onclick="return confirm('Are you sure you want to cancel this order?')" style="padding: 5px 10px; background: #dc3545; color: white; border: none; cursor: pointer; margin: 2px;">❌ Cancel Order</button>
                            </form>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
    
    <c:if test="${empty orders}">
        <p>No orders found.</p>
    </c:if>
    
    <div class="navigation">
        <c:if test="${sessionScope.userRole eq 'ADMIN'}">
            <!-- Full admin navigation -->
            <a href="${pageContext.request.contextPath}/admin" style="display: inline-block; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; margin: 5px;">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/events" style="display: inline-block; padding: 10px 20px; background: #28a745; color: white; text-decoration: none; margin: 5px;">Manage Events</a>
            <a href="${pageContext.request.contextPath}/admin/venues" style="display: inline-block; padding: 10px 20px; background: #20c997; color: white; text-decoration: none; margin: 5px;">Manage Venues</a>
            <a href="${pageContext.request.contextPath}/admin/artists" style="display: inline-block; padding: 10px 20px; background: #fd7e14; color: white; text-decoration: none; margin: 5px;">Manage Artists</a>
            <a href="${pageContext.request.contextPath}/admin/accounts" style="display: inline-block; padding: 10px 20px; background: #007bff; color: white; text-decoration: none; margin: 5px;">Manage Staff & Admin</a>
            <a href="${pageContext.request.contextPath}/admin/customers" style="display: inline-block; padding: 10px 20px; background: #17a2b8; color: white; text-decoration: none; margin: 5px;">Manage Customers</a>
            <a href="${pageContext.request.contextPath}/admin/promo-codes" style="display: inline-block; padding: 10px 20px; background: #6f42c1; color: white; text-decoration: none; margin: 5px;">Manage Promo Codes</a>
        </c:if>
        
        <c:if test="${sessionScope.userRole eq 'STAFF'}">
            <!-- Staff navigation - only orders management -->
            <a href="${pageContext.request.contextPath}/events" style="display: inline-block; padding: 10px 20px; background: #28a745; color: white; text-decoration: none; margin: 5px;">View Events</a>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/logout" style="display: inline-block; padding: 10px 20px; background: #dc3545; color: white; text-decoration: none; margin: 5px;">Logout</a>
    </div>
</body>
</html>
