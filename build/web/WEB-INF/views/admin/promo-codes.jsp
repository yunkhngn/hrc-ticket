<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Promo Codes Management - Hanoi Rock City</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Hanoi Rock City - Promo Codes Management</h1>
    
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
    
    <div class="admin-actions">
        <button onclick="showCreateForm()" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Create New Promo Code</button>
    </div>
    
    <c:if test="${not empty promoCodes}">
        <div class="promo-codes-list">
            <c:forEach var="promoCode" items="${promoCodes}">
                <div class="promo-code-item" style="border: 1px solid #ddd; margin: 10px 0; padding: 15px; border-radius: 5px; background-color: #fff;">
                    <h3>${promoCode.code}</h3>
                    <p><strong>Discount Type:</strong> ${promoCode.discountType}</p>
                    <p><strong>Discount Value:</strong> 
                        <c:choose>
                            <c:when test="${promoCode.discountType eq 'PERCENTAGE'}">
                                ${promoCode.discountValue}%
                            </c:when>
                            <c:otherwise>
                                $${promoCode.discountValue}
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Max Uses:</strong> ${promoCode.maxUses != null ? promoCode.maxUses : 'Unlimited'}</p>
                    <p><strong>Per Customer Limit:</strong> ${promoCode.perCustomerLimit != null ? promoCode.perCustomerLimit : 'Unlimited'}</p>
                    <p><strong>Min Order Amount:</strong> ${promoCode.minOrderAmount != null ? '$' : ''}${promoCode.minOrderAmount != null ? promoCode.minOrderAmount : 'No minimum'}</p>
                    <p><strong>Valid From:</strong> 
                        <c:choose>
                            <c:when test="${promoCode.startAt != null}">
                                <fmt:formatDateTime value="${promoCode.startAt}" pattern="yyyy-MM-dd HH:mm"/>
                            </c:when>
                            <c:otherwise>No start date</c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Valid Until:</strong> 
                        <c:choose>
                            <c:when test="${promoCode.endAt != null}">
                                <fmt:formatDateTime value="${promoCode.endAt}" pattern="yyyy-MM-dd HH:mm"/>
                            </c:when>
                            <c:otherwise>No end date</c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Created:</strong> 
                        <c:choose>
                            <c:when test="${promoCode.createdAt != null}">
                                <fmt:formatDateTime value="${promoCode.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                            </c:when>
                            <c:otherwise>Unknown</c:otherwise>
                        </c:choose>
                    </p>
                    
                    <div class="promo-code-actions">
                        <button onclick="editPromoCode(${promoCode.id}, '${promoCode.code}', '${promoCode.discountType}', ${promoCode.discountValue}, ${promoCode.maxUses}, ${promoCode.perCustomerLimit}, '${promoCode.startAt}', '${promoCode.endAt}', ${promoCode.minOrderAmount})" style="margin: 2px; padding: 5px 10px; background: #007bff; color: white; border: none; cursor: pointer;">Edit</button>
                        <form action="${pageContext.request.contextPath}/admin/promo-codes" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="promoCodeId" value="${promoCode.id}">
                            <button type="submit" onclick="return confirm('Are you sure you want to delete this promo code?')" style="margin: 2px; padding: 5px 10px; background: #dc3545; color: white; border: none; cursor: pointer;">Delete</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
    
    <c:if test="${empty promoCodes}">
        <p>No promo codes available.</p>
    </c:if>
    
    <!-- Create Promo Code Form (Hidden by default) -->
    <div id="createForm" style="display: none; margin-top: 20px; padding: 20px; border: 1px solid #ccc; background-color: #f8f9fa;">
        <h3>Create New Promo Code</h3>
        <form action="${pageContext.request.contextPath}/admin/promo-codes" method="post">
            <input type="hidden" name="action" value="create">
            <div>
                <label for="code">Promo Code:</label>
                <input type="text" id="code" name="code" required style="width: 100%; padding: 8px; margin: 5px 0; text-transform: uppercase;">
            </div>
            <div>
                <label for="discountType">Discount Type:</label>
                <select id="discountType" name="discountType" required style="padding: 8px; margin: 5px 0; width: 100%;">
                    <option value="">Select discount type</option>
                    <option value="PERCENTAGE">Percentage (%)</option>
                    <option value="FIXED_AMOUNT">Fixed Amount ($)</option>
                </select>
            </div>
            <div>
                <label for="discountValue">Discount Value:</label>
                <input type="number" id="discountValue" name="discountValue" min="0" step="0.01" required style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <label for="maxUses">Maximum Uses (Optional):</label>
                <input type="number" id="maxUses" name="maxUses" min="1" style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <label for="perCustomerLimit">Per Customer Limit (Optional):</label>
                <input type="number" id="perCustomerLimit" name="perCustomerLimit" min="1" style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <label for="startAt">Valid From (Optional):</label>
                <input type="datetime-local" id="startAt" name="startAt" style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <label for="endAt">Valid Until (Optional):</label>
                <input type="datetime-local" id="endAt" name="endAt" style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <label for="minOrderAmount">Minimum Order Amount (Optional):</label>
                <input type="number" id="minOrderAmount" name="minOrderAmount" min="0" step="0.01" style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer;">Create Promo Code</button>
                <button type="button" onclick="hideCreateForm()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; cursor: pointer;">Cancel</button>
            </div>
        </form>
    </div>
    
    <!-- Edit Promo Code Form (Hidden by default) -->
    <div id="editForm" style="display: none; margin-top: 20px; padding: 20px; border: 1px solid #ccc; background-color: #f8f9fa;">
        <h3>Edit Promo Code</h3>
        <form action="${pageContext.request.contextPath}/admin/promo-codes" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="editPromoCodeId" name="promoCodeId">
            <div>
                <label for="editCode">Promo Code:</label>
                <input type="text" id="editCode" name="code" required style="width: 100%; padding: 8px; margin: 5px 0; text-transform: uppercase;">
            </div>
            <div>
                <label for="editDiscountType">Discount Type:</label>
                <select id="editDiscountType" name="discountType" required style="padding: 8px; margin: 5px 0; width: 100%;">
                    <option value="">Select discount type</option>
                    <option value="PERCENTAGE">Percentage (%)</option>
                    <option value="FIXED_AMOUNT">Fixed Amount ($)</option>
                </select>
            </div>
            <div>
                <label for="editDiscountValue">Discount Value:</label>
                <input type="number" id="editDiscountValue" name="discountValue" min="0" step="0.01" required style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <label for="editMaxUses">Maximum Uses (Optional):</label>
                <input type="number" id="editMaxUses" name="maxUses" min="1" style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <label for="editPerCustomerLimit">Per Customer Limit (Optional):</label>
                <input type="number" id="editPerCustomerLimit" name="perCustomerLimit" min="1" style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <label for="editStartAt">Valid From (Optional):</label>
                <input type="datetime-local" id="editStartAt" name="startAt" style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <label for="editEndAt">Valid Until (Optional):</label>
                <input type="datetime-local" id="editEndAt" name="endAt" style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <label for="editMinOrderAmount">Minimum Order Amount (Optional):</label>
                <input type="number" id="editMinOrderAmount" name="minOrderAmount" min="0" step="0.01" style="padding: 8px; margin: 5px 0; width: 100%;">
            </div>
            <div>
                <button type="submit" style="padding: 10px 20px; background: #007bff; color: white; border: none; cursor: pointer;">Update Promo Code</button>
                <button type="button" onclick="hideEditForm()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; cursor: pointer;">Cancel</button>
            </div>
        </form>
    </div>
    
    <div class="navigation">
        <a href="${pageContext.request.contextPath}/admin" style="display: inline-block; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; margin: 5px;">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/events" style="display: inline-block; padding: 10px 20px; background: #28a745; color: white; text-decoration: none; margin: 5px;">Manage Events</a>
        <a href="${pageContext.request.contextPath}/admin/venues" style="display: inline-block; padding: 10px 20px; background: #20c997; color: white; text-decoration: none; margin: 5px;">Manage Venues</a>
        <a href="${pageContext.request.contextPath}/admin/artists" style="display: inline-block; padding: 10px 20px; background: #fd7e14; color: white; text-decoration: none; margin: 5px;">Manage Artists</a>
        <a href="${pageContext.request.contextPath}/admin/accounts" style="display: inline-block; padding: 10px 20px; background: #007bff; color: white; text-decoration: none; margin: 5px;">Manage Staff & Admin</a>
        <a href="${pageContext.request.contextPath}/admin/customers" style="display: inline-block; padding: 10px 20px; background: #17a2b8; color: white; text-decoration: none; margin: 5px;">Manage Customers</a>
        <a href="${pageContext.request.contextPath}/admin/orders" style="display: inline-block; padding: 10px 20px; background: #ffc107; color: black; text-decoration: none; margin: 5px;">Manage Orders</a>
        <a href="${pageContext.request.contextPath}/logout" style="display: inline-block; padding: 10px 20px; background: #dc3545; color: white; text-decoration: none; margin: 5px;">Logout</a>
    </div>
    
    <script>
        function showCreateForm() {
            document.getElementById('createForm').style.display = 'block';
            document.getElementById('editForm').style.display = 'none';
        }
        
        function hideCreateForm() {
            document.getElementById('createForm').style.display = 'none';
        }
        
        function editPromoCode(promoCodeId, code, discountType, discountValue, maxUses, perCustomerLimit, startAt, endAt, minOrderAmount) {
            document.getElementById('editPromoCodeId').value = promoCodeId;
            document.getElementById('editCode').value = code;
            document.getElementById('editDiscountType').value = discountType;
            document.getElementById('editDiscountValue').value = discountValue;
            document.getElementById('editMaxUses').value = (maxUses && maxUses !== 'null') ? maxUses : '';
            document.getElementById('editPerCustomerLimit').value = (perCustomerLimit && perCustomerLimit !== 'null') ? perCustomerLimit : '';
            document.getElementById('editMinOrderAmount').value = (minOrderAmount && minOrderAmount !== 'null') ? minOrderAmount : '';
            
            // Format datetime for datetime-local input
            if (startAt && startAt !== 'null') {
                const formattedStartAt = startAt.replace(' ', 'T').substring(0, 16);
                document.getElementById('editStartAt').value = formattedStartAt;
            } else {
                document.getElementById('editStartAt').value = '';
            }
            
            if (endAt && endAt !== 'null') {
                const formattedEndAt = endAt.replace(' ', 'T').substring(0, 16);
                document.getElementById('editEndAt').value = formattedEndAt;
            } else {
                document.getElementById('editEndAt').value = '';
            }
            
            document.getElementById('editForm').style.display = 'block';
            document.getElementById('createForm').style.display = 'none';
        }
        
        function hideEditForm() {
            document.getElementById('editForm').style.display = 'none';
        }
    </script>
</body>
</html>
