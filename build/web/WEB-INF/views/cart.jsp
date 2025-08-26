<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cart - Hanoi Rock City</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="header">
        <div class="container">
            <h1 class="rock-accent">Hanoi Rock City</h1>
        </div>
    </div>
    
    <div class="container">
        <div class="main-content">
            <h2 class="text-center">Your Cart</h2>
            
            <c:if test="${not empty cartItems}">
                <div class="card">
                    <div class="grid grid-2">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="event-card">
                                <h3 class="event-title">${item.eventName}</h3>
                                <p class="event-description">Zone: ${item.zoneName}</p>
                                
                                <div class="event-meta">
                                    <div class="event-meta-item">
                                        <span class="event-meta-label">Quantity:</span>
                                        <span class="event-meta-value">${item.quantity}</span>
                                    </div>
                                    <div class="event-meta-item">
                                        <span class="event-meta-label">Price:</span>
                                        <span class="event-meta-value"><fmt:formatNumber value="${item.price}" type="currency" currencySymbol="VND"/></span>
                                    </div>
                                    <div class="event-meta-item">
                                        <span class="event-meta-label">Fee:</span>
                                        <span class="event-meta-value"><fmt:formatNumber value="${item.fee}" type="currency" currencySymbol="VND"/></span>
                                    </div>
                                    <div class="event-meta-item">
                                        <span class="event-meta-label">Total:</span>
                                        <span class="event-meta-value"><fmt:formatNumber value="${item.total}" type="currency" currencySymbol="VND"/></span>
                                    </div>
                                </div>
                                
                                <div class="order-actions">
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="eventZoneId" value="${item.eventZoneId}">
                                        <input type="number" name="quantity" value="${item.quantity}" min="1" max="10" class="form-input" style="width: 80px; display: inline-block;">
                                        <button type="submit" class="btn btn-secondary">🔄 Update</button>
                                    </form>
                                    
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="eventZoneId" value="${item.eventZoneId}">
                                        <button type="submit" class="btn btn-danger">🗑️ Remove</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <div class="card text-center" style="margin-top: 2rem;">
                        <h3>Cart Summary</h3>
                        <p class="event-meta-value" style="font-size: 1.5rem; font-weight: bold;">
                            Total: <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="VND"/>
                        </p>
                        
                        <div class="order-actions">
                            <a href="${pageContext.request.contextPath}/events" class="btn btn-secondary">Continue Shopping</a>
                            <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success">Proceed to Checkout</a>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${empty cartItems}">
                <div class="card text-center">
                    <h3>Your Cart is Empty</h3>
                    <p>Looks like you haven't added any tickets to your cart yet.</p>
                    <div class="order-actions">
                        <a href="${pageContext.request.contextPath}/events" class="btn btn-primary">Browse Events</a>
                    </div>
                </div>
            </c:if>
            
            <div class="navigation">
                <a href="${pageContext.request.contextPath}/events" class="nav-link">Browse Events</a>
                <a href="${pageContext.request.contextPath}/orders" class="nav-link">My Orders</a>
                <a href="${pageContext.request.contextPath}/logout" class="nav-link logout">Logout</a>
            </div>
        </div>
    </div>
</body>
</html>
