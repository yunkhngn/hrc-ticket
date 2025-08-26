<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout - Hanoi Rock City</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Hanoi Rock City - Checkout</h1>
    
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
                <h3>Subtotal: <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="VND"/></h3>
                
                <!-- Promo Code Section -->
                <div class="promo-code-section" style="margin: 20px 0; padding: 15px; border: 1px solid #ddd; background-color: #f8f9fa;">
                    <h4>Apply Promo Code</h4>
                    
                    <c:if test="${not empty promoCodeError}">
                        <p style="color: red;">${promoCodeError}</p>
                    </c:if>
                    
                    <c:if test="${not empty promoCodeSuccess}">
                        <p style="color: green;">${promoCodeSuccess}</p>
                    </c:if>
                    
                    <form action="${pageContext.request.contextPath}/checkout" method="post" style="display: flex; gap: 10px; align-items: center;">
                        <input type="hidden" name="action" value="applyPromoCode">
                        <input type="text" name="promoCode" placeholder="Enter promo code" 
                               value="${appliedPromoCode}" style="padding: 8px; flex: 1;">
                        <button type="submit" style="padding: 8px 15px; background: #007bff; color: white; border: none; cursor: pointer;">Apply</button>
                    </form>
                    
                    <c:if test="${not empty appliedPromoCode}">
                        <div style="margin-top: 10px;">
                            <p><strong>Applied Promo Code:</strong> ${appliedPromoCode}</p>
                            <p><strong>Discount:</strong> <fmt:formatNumber value="${discountAmount}" type="currency" currencySymbol="VND"/></p>
                            <form action="${pageContext.request.contextPath}/checkout" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="removePromoCode">
                                <button type="submit" style="padding: 5px 10px; background: #dc3545; color: white; border: none; cursor: pointer; font-size: 12px;">Remove</button>
                            </form>
                        </div>
                    </c:if>
                </div>
                
                <h3>Final Total: <fmt:formatNumber value="${finalTotal}" type="currency" currencySymbol="VND"/></h3>
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
                    <li><strong>Amount:</strong> <fmt:formatNumber value="${finalTotal}" type="currency" currencySymbol="VND"/></li>
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
