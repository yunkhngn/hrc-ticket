<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Orders Management - Hanoi Rock City</title>
    
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/favicon.ico">
    <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/favicon-16x16.png">
    
    <!-- Theme Colors -->
    <meta name="theme-color" content="#e74c3c">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root {
            --hrc-red: #e74c3c;
            --hrc-dark: #1a1a1a;
            --hrc-gray: #2c2c2c;
            --hrc-light-gray: #f8f9fa;
            --hrc-gradient: linear-gradient(135deg, var(--hrc-red), #c0392b);
        }
        
        body {
            background-color: white;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }
        
        .navbar {
            background: var(--hrc-dark);
            padding: 1rem 0;
        }
        
        .navbar-brand {
            color: white;
            font-weight: 700;
            font-size: 1.5rem;
        }
        
        .navbar-nav .nav-link {
            color: white;
            font-weight: 500;
            margin: 0 0.5rem;
            transition: color 0.3s ease;
        }
        
        .navbar-nav .nav-link:hover {
            color: var(--hrc-red);
        }
        
        .logout-btn {
            background: var(--hrc-red);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        
        .logout-btn:hover {
            background: #c0392b;
            color: white;
        }
        
        .admin-header {
            background: linear-gradient(135deg, var(--hrc-dark), var(--hrc-gray));
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        
        .admin-header h1 {
            margin: 0;
            font-size: 2.5rem;
            font-weight: 700;
        }
        
        .admin-header p {
            margin: 0.5rem 0 0 0;
            opacity: 0.8;
            font-size: 1.1rem;
        }
        
        /* Stats Cards */
        <c:set var="totalOrders" value="${orders.size()}" />
        <c:set var="pendingOrders" value="0" />
        <c:set var="confirmedOrders" value="0" />
        <c:set var="failedOrders" value="0" />
        <c:set var="totalRevenue" value="0" />
        
        <c:forEach var="order" items="${orders}">
            <c:choose>
                <c:when test="${order.paymentStatus eq 'PENDING'}">
                    <c:set var="pendingOrders" value="${pendingOrders + 1}" />
                </c:when>
                <c:when test="${order.paymentStatus eq 'CONFIRMED'}">
                    <c:set var="confirmedOrders" value="${confirmedOrders + 1}" />
                    <c:set var="totalRevenue" value="${totalRevenue + order.paidAmount}" />
                </c:when>
                <c:when test="${order.paymentStatus eq 'FAILED'}">
                    <c:set var="failedOrders" value="${failedOrders + 1}" />
                </c:when>
            </c:choose>
        </c:forEach>
        
        .stats-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            border-left: 4px solid var(--hrc-red);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: var(--hrc-gradient);
        }
        
        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }
        
        .stat-card h3 {
            margin: 0 0 0.5rem 0;
            font-size: 2rem;
            font-weight: 700;
            color: var(--hrc-red);
        }
        
        .stat-card p {
            margin: 0;
            color: #666;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .stat-card.revenue {
            border-left-color: #27ae60;
        }
        
        .stat-card.revenue h3 {
            color: #27ae60;
        }
        
        .stat-card.revenue::before {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
        }
        
        /* Orders Container */
        .orders-container {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        
        .orders-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--hrc-light-gray);
        }
        
        .orders-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--hrc-dark);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .orders-actions {
            display: flex;
            gap: 0.75rem;
        }
        
        .btn {
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }
        
        .btn-primary {
            background: var(--hrc-gradient);
            color: white;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(231, 76, 60, 0.3);
        }
        
        .btn-outline-primary {
            background: transparent;
            color: var(--hrc-red);
            border: 2px solid var(--hrc-red);
        }
        
        .btn-outline-primary:hover {
            background: var(--hrc-red);
            color: white;
            transform: translateY(-1px);
        }
        
        .btn-success {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
        }
        
        .btn-success:hover {
            background: linear-gradient(135deg, #2ecc71, #27ae60);
            color: white;
            transform: translateY(-1px);
        }
        
        /* Order Items */
        .order-item {
            background: white;
            border: 1px solid #eee;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .order-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: var(--hrc-gradient);
        }
        
        .order-item:hover {
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            transform: translateY(-2px);
            border-color: var(--hrc-red);
        }
        
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
        }
        
        .order-info {
            flex: 1;
        }
        
        .order-id {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--hrc-dark);
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 0.5rem;
        }
        
        .order-number {
            font-size: 0.9rem;
            color: var(--hrc-red);
            font-weight: 600;
            background: rgba(231, 76, 60, 0.1);
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
        }
        
        .order-date {
            color: #666;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .order-status {
            text-align: right;
        }
        
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .status-pending {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
        }
        
        .status-confirmed {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
        }
        
        .status-failed {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }
        
        .status-cancelled {
            background: linear-gradient(135deg, #95a5a6, #7f8c8d);
            color: white;
        }
        
        /* Order Details Grid */
        .order-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 1.5rem;
            padding: 1rem;
            background: var(--hrc-light-gray);
            border-radius: 8px;
        }
        
        .detail-item {
            display: flex;
            flex-direction: column;
        }
        
        .detail-label {
            font-size: 0.75rem;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 600;
        }
        
        .detail-value {
            font-weight: 700;
            color: var(--hrc-dark);
            font-size: 1.1rem;
        }
        
        /* Order Actions */
        .order-actions {
            display: flex;
            gap: 0.75rem;
            justify-content: flex-end;
            flex-wrap: wrap;
        }
        
        .action-btn {
            padding: 0.6rem 1.2rem;
            border: none;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .btn-confirm {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
        }
        
        .btn-confirm:hover {
            background: linear-gradient(135deg, #2ecc71, #27ae60);
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(39, 174, 96, 0.3);
        }
        
        .btn-cancel {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }
        
        .btn-cancel:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(231, 76, 60, 0.3);
        }
        
        .btn-view {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }
        
        .btn-view:hover {
            background: linear-gradient(135deg, #2980b9, #1f5f8b);
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
        }
        
        /* Alerts */
        .alert {
            border-radius: 8px;
            border: none;
            margin-bottom: 2rem;
            padding: 1rem 1.5rem;
        }
        
        .alert-success {
            background: rgba(39, 174, 96, 0.1);
            color: #27ae60;
            border-left: 4px solid #27ae60;
        }
        
        .alert-danger {
            background: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
            border-left: 4px solid #e74c3c;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #666;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #ccc;
            margin-bottom: 1rem;
        }
        
        .empty-state h3 {
            color: var(--hrc-dark);
            margin-bottom: 0.5rem;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 1rem;
            }
            
            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .order-header {
                flex-direction: column;
                gap: 1rem;
            }
            
            .order-status {
                text-align: left;
            }
            
            .order-details {
                grid-template-columns: 1fr;
            }
            
            .order-actions {
                justify-content: flex-start;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin">
                <i class="bi bi-gear-fill"></i> HRC Admin
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/events">
                    <i class="bi bi-calendar-event"></i> Events
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
                    <i class="bi bi-list-ul"></i> Orders
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/venues">
                    <i class="bi bi-building"></i> Venues
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/artists">
                    <i class="bi bi-music-note-beamed"></i> Artists
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/customers">
                    <i class="bi bi-people"></i> Customers
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/accounts">
                    <i class="bi bi-person-gear"></i> Accounts
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/promo-codes">
                    <i class="bi bi-tag"></i> Promo Codes
                </a>
                <a class="logout-btn" href="${pageContext.request.contextPath}/logout">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </a>
            </div>
        </div>
    </nav>

    <!-- Header -->
    <div class="admin-header">
        <div class="container">
            <h1><i class="bi bi-list-ul"></i> Orders Management</h1>
            <p>Manage and process customer orders efficiently</p>
        </div>
    </div>

    <div class="container">
        <!-- Stats Section -->
        <div class="stats-section">
            <div class="stat-card">
                <h3>${totalOrders}</h3>
                <p>Total Orders</p>
            </div>
            <div class="stat-card">
                <h3>${pendingOrders}</h3>
                <p>Pending Payments</p>
            </div>
            <div class="stat-card">
                <h3>${confirmedOrders}</h3>
                <p>Confirmed Payments</p>
            </div>
            <div class="stat-card revenue">
                <h3><fmt:formatNumber value="${totalRevenue}" pattern="#,###"/></h3>
                <p>Total Revenue (VND)</p>
            </div>
        </div>

        <!-- Orders Container -->
        <div class="orders-container">
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle"></i> ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty orders}">
                <div class="orders-header">
                    <div class="orders-title">
                        <i class="bi bi-list-ul"></i> All Orders
                        <span class="badge bg-primary ms-2">${orders.size()} orders</span>
                    </div>
                    <div class="orders-actions">
                        <button class="btn btn-outline-primary" onclick="refreshPage()">
                            <i class="bi bi-arrow-clockwise"></i> Refresh
                        </button>
                    </div>
                </div>

                <c:forEach var="order" items="${orders}" varStatus="status">
                    <div class="order-item">
                        <div class="order-header">
                            <div class="order-info">
                                <div class="order-id">
                                    <i class="bi bi-receipt"></i> Order #${order.id}
                                    <span class="order-number">#${String.format("%06d", order.id)}</span>
                                </div>
                                <div class="order-date">
                                    <i class="bi bi-calendar3"></i> 
                                    ${order.createdAt.dayOfMonth}/${order.createdAt.monthValue}/${order.createdAt.year} ${order.createdAt.hour}:${order.createdAt.minute < 10 ? '0' : ''}${order.createdAt.minute}
                                </div>
                            </div>
                                                         <div class="order-status">
                                 <span class="status-badge status-${order.paymentStatus.toLowerCase()}">
                                     <i class="bi bi-${order.paymentStatus eq 'CONFIRMED' ? 'check-circle' : order.paymentStatus eq 'PENDING' ? 'clock' : order.paymentStatus eq 'FAILED' ? 'x-circle' : 'question-circle'}"></i>
                                     Payment: ${order.paymentStatus}
                                 </span>
                             </div>
                        </div>
                        
                        <div class="order-details">
                            <div class="detail-item">
                                <div class="detail-label">
                                    <i class="bi bi-person"></i> Customer ID
                                </div>
                                <div class="detail-value">${order.customerId}</div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">
                                    <i class="bi bi-currency-dollar"></i> Total Amount
                                </div>
                                <div class="detail-value">
                                    <fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/> VND
                                </div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">
                                    <i class="bi bi-cash-coin"></i> Paid Amount
                                </div>
                                <div class="detail-value">
                                    <fmt:formatNumber value="${order.paidAmount}" pattern="#,###"/> VND
                                </div>
                            </div>
                                                         <div class="detail-item">
                                 <div class="detail-label">
                                     <i class="bi bi-tag"></i> Processing Status
                                 </div>
                                 <div class="detail-value">
                                     <span class="status-badge status-${order.status.toLowerCase()}">
                                         <i class="bi bi-${order.status eq 'PENDING' ? 'clock' : order.status eq 'CONFIRMED' ? 'check-circle' : order.status eq 'CANCELLED' ? 'x-circle' : 'question-circle'}"></i>
                                         ${order.status}
                                     </span>
                                 </div>
                             </div>
                        </div>
                        
                        <div class="order-actions">
                            <a href="${pageContext.request.contextPath}/order-detail?id=${order.id}" class="action-btn btn-view">
                                <i class="bi bi-eye"></i> View Details
                            </a>
                            
                            <c:if test="${order.paymentStatus eq 'PENDING'}">
                                <form action="${pageContext.request.contextPath}/admin/orders" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="confirm">
                                    <input type="hidden" name="orderId" value="${order.id}">
                                    <button type="submit" class="action-btn btn-confirm" 
                                            onclick="return confirm('Confirm payment for Order #${order.id}?')">
                                        <i class="bi bi-check-circle"></i> Confirm Payment
                                    </button>
                                </form>
                                
                                <form action="${pageContext.request.contextPath}/admin/orders" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="cancel">
                                    <input type="hidden" name="orderId" value="${order.id}">
                                    <button type="submit" class="action-btn btn-cancel" 
                                            onclick="return confirm('Cancel Order #${order.id}? This action cannot be undone.')">
                                        <i class="bi bi-x-circle"></i> Cancel Order
                                    </button>
                                </form>
                            </c:if>
                            
                            <c:if test="${order.paymentStatus eq 'CONFIRMED'}">
                                <span class="status-badge status-confirmed">
                                    <i class="bi bi-check-circle"></i> Payment Confirmed
                                </span>
                            </c:if>
                            
                            <c:if test="${order.paymentStatus eq 'FAILED'}">
                                <span class="status-badge status-failed">
                                    <i class="bi bi-x-circle"></i> Payment Failed
                                </span>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            
            <c:if test="${empty orders}">
                <div class="empty-state">
                    <i class="bi bi-inbox"></i>
                    <h3>No Orders Found</h3>
                    <p>There are no orders to display at the moment.</p>
                    <button class="btn btn-primary" onclick="refreshPage()">
                        <i class="bi bi-arrow-clockwise"></i> Refresh
                    </button>
                </div>
            </c:if>
        </div>
    </div>

    <script>
        function refreshPage() {
            window.location.reload();
        }
        
        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>