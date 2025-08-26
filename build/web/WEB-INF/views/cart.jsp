<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart - HRC</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Shopping Cart</h1>
    
    <c:if test="${not empty cartItems}">
        <div class="cart-items">
            <c:forEach var="item" items="${cartItems}">
                <div class="cart-item">
                    <h3>${item.eventName}</h3>
                    <p><strong>Zone:</strong> ${item.zoneName}</p>
                    <p><strong>Quantity:</strong> ${item.quantity}</p>
                    <p><strong>Price:</strong> <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="VND"/></p>
                    <p><strong>Total:</strong> <fmt:formatNumber value="${item.total}" type="currency" currencySymbol="VND"/></p>
                    
                                         <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                         <input type="hidden" name="action" value="remove">
                         <input type="hidden" name="eventZoneId" value="${item.eventZoneId}">
                         <button type="submit">Remove</button>
                     </form>
                     
                     <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                         <input type="hidden" name="action" value="update">
                         <input type="hidden" name="eventZoneId" value="${item.eventZoneId}">
                         <label for="quantity-${item.eventZoneId}">Quantity:</label>
                         <input type="number" id="quantity-${item.eventZoneId}" name="quantity" value="${item.quantity}" min="1" max="10">
                         <button type="submit">Update</button>
                     </form>
                </div>
            </c:forEach>
            
            <div class="cart-total">
                <h3>Total: <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="VND"/></h3>
            </div>
            
            <div class="cart-actions">
                <a href="${pageContext.request.contextPath}/events">Continue Shopping</a>
                <a href="${pageContext.request.contextPath}/checkout">Proceed to Checkout</a>
            </div>
        </div>
    </c:if>
    
    <c:if test="${empty cartItems}">
        <p>Your cart is empty.</p>
        <a href="${pageContext.request.contextPath}/events">Browse Events</a>
    </c:if>
    
    <div class="navigation">
        <a href="${pageContext.request.contextPath}/events">Back to Events</a>
    </div>
</body>
</html>
