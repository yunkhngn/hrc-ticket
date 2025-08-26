<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout - HRC</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Checkout</h1>
    
    <c:if test="${not empty error}">
        <div class="error">
            <p style="color: red;">${error}</p>
        </div>
    </c:if>
    
    <div class="order-summary">
        <h2>Order Summary</h2>
        <c:if test="${not empty cartItems}">
            <div class="cart-items">
                <c:forEach var="item" items="${cartItems}">
                    <div class="cart-item">
                        <h3>${item.eventName}</h3>
                        <p><strong>Zone:</strong> ${item.zoneName}</p>
                        <p><strong>Quantity:</strong> ${item.quantity}</p>
                        <p><strong>Price:</strong> <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="VND"/></p>
                        <p><strong>Fee:</strong> <fmt:formatNumber value="${item.fee}" type="currency" currencySymbol="VND"/></p>
                        <p><strong>Total:</strong> <fmt:formatNumber value="${item.total}" type="currency" currencySymbol="VND"/></p>
                    </div>
                </c:forEach>
            </div>
            
            <div class="order-total">
                <h3>Total Amount: <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="VND"/></h3>
            </div>
        </c:if>
    </div>
    
    <form action="${pageContext.request.contextPath}/checkout" method="post">
        <div class="payment-info">
            <h2>Payment Information</h2>
            <p><strong>Payment Method:</strong> Bank Transfer</p>
            <div>
                <label for="bankRef"><strong>Bank Reference Number:</strong></label>
                <input type="text" id="bankRef" name="bankRef" placeholder="Enter your bank transfer reference number" required>
            </div>
            
            <div class="payment-instructions">
                <h3>Payment Instructions:</h3>
                <p>Please transfer the total amount to our bank account:</p>
                <ul>
                    <li><strong>Bank:</strong> Vietcombank</li>
                    <li><strong>Account Number:</strong> 1234567890</li>
                    <li><strong>Account Name:</strong> Hanoi Rock Concert</li>
                    <li><strong>Amount:</strong> <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="VND"/></li>
                </ul>
                <p>After making the transfer, please enter the reference number provided by your bank above.</p>
            </div>
        </div>
        
        <div class="checkout-actions">
            <button type="submit">Place Order</button>
            <a href="${pageContext.request.contextPath}/cart">Back to Cart</a>
        </div>
    </form>
    
    <div class="navigation">
        <a href="${pageContext.request.contextPath}/events">Back to Events</a>
    </div>
</body>
</html>
