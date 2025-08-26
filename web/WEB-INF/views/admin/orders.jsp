<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Orders Management</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Orders Management</h1>
    
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
                <div class="order-item">
                    <h3>Order #${order.id}</h3>
                    <p><strong>Customer ID:</strong> ${order.customerId}</p>
                    <p><strong>Date:</strong> ${order.createdAt}</p>
                    <p><strong>Status:</strong> ${order.status}</p>
                    <p><strong>Payment Status:</strong> ${order.paymentStatus}</p>
                    <p><strong>Total Amount:</strong> <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="VND"/></p>
                    <c:if test="${not empty order.bankRef}">
                        <p><strong>Bank Reference:</strong> ${order.bankRef}</p>
                    </c:if>
                    
                    <div class="order-actions">
                        <a href="${pageContext.request.contextPath}/order?id=${order.id}">View Details</a>
                        
                        <c:if test="${order.paymentStatus eq 'PENDING'}">
                            <form action="${pageContext.request.contextPath}/admin/orders" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="confirm">
                                <input type="hidden" name="orderId" value="${order.id}">
                                <button type="submit">Confirm Payment</button>
                            </form>
                        </c:if>
                        
                        <c:if test="${order.status ne 'CANCELLED'}">
                            <form action="${pageContext.request.contextPath}/admin/orders" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="cancel">
                                <input type="hidden" name="orderId" value="${order.id}">
                                <button type="submit" onclick="return confirm('Are you sure you want to cancel this order?')">Cancel Order</button>
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
        <a href="${pageContext.request.contextPath}/admin/events">Manage Events</a>
        
    </div>
</body>
</html>
