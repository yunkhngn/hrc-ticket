<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Details - HRC</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Order Details</h1>
    
    <c:if test="${not empty order}">
        <div class="order-info">
            <h2>Order #${order.id}</h2>
            <p><strong>Status:</strong> ${order.status}</p>
            <p><strong>Payment Status:</strong> ${order.paymentStatus}</p>
            <p><strong>Payment Method:</strong> ${order.paymentMethod}</p>
            <p><strong>Currency:</strong> ${order.currency}</p>
            <p><strong>Total Amount:</strong> <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="VND"/></p>
            <p><strong>Paid Amount:</strong> <fmt:formatNumber value="${order.paidAmount}" type="currency" currencySymbol="VND"/></p>
            <p><strong>Bank Reference:</strong> ${order.bankRef}</p>
            <p><strong>Created:</strong> ${order.createdAt}</p>
            
            <c:if test="${not empty order.confirmedAt}">
                <p><strong>Confirmed:</strong> ${order.confirmedAt}</p>
            </c:if>
        </div>
        
        <c:if test="${not empty orderItems}">
            <div class="order-items">
                <h3>Order Items</h3>
                <c:forEach var="item" items="${orderItems}">
                    <div class="order-item">
                        <p><strong>Event Zone ID:</strong> ${item.eventZoneId}</p>
                        <p><strong>Quantity:</strong> ${item.qty}</p>
                        <p><strong>Unit Price:</strong> <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="VND"/></p>
                        <p><strong>Fee:</strong> <fmt:formatNumber value="${item.feeAmount}" type="currency" currencySymbol="VND"/></p>
                        <p><strong>Final Price:</strong> <fmt:formatNumber value="${item.finalPrice}" type="currency" currencySymbol="VND"/></p>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        
        <div class="order-actions">
            <c:if test="${order.paymentStatus eq 'PENDING'}">
                <p style="color: orange;"><strong>Payment Pending</strong></p>
                <p>Your order has been created successfully. Please complete the bank transfer and wait for confirmation.</p>
                
                <c:if test="${order.status eq 'PENDING'}">
                    <form action="${pageContext.request.contextPath}/orders" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="cancel">
                        <input type="hidden" name="orderId" value="${order.id}">
                        <button type="submit" onclick="return confirm('Are you sure you want to cancel this order?')" style="color: red;">Cancel Order</button>
                    </form>
                </c:if>
            </c:if>
            
            <c:if test="${order.paymentStatus eq 'CONFIRMED'}">
                <p style="color: green;"><strong>Payment Confirmed</strong></p>
                <p>Your payment has been confirmed. Your tickets are ready!</p>
            </c:if>
            
            <c:if test="${order.status eq 'CANCELLED'}">
                <p style="color: red;"><strong>Order Cancelled</strong></p>
                <p>This order has been cancelled.</p>
            </c:if>
        </div>
    </c:if>
    
    <c:if test="${empty order}">
        <p>Order not found.</p>
    </c:if>
    
    <div class="navigation">
        <a href="${pageContext.request.contextPath}/orders">My Orders</a>
        <a href="${pageContext.request.contextPath}/events">Browse Events</a>
        <c:if test="${sessionScope.userRole eq 'ADMIN'}">
            <a href="${pageContext.request.contextPath}/admin/orders">Admin Orders</a>
        </c:if>
    </div>
</body>
</html>
