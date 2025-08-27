<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Hanoi Rock City</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root {
            --hrc-red: #e74c3c;
            --hrc-dark: #1a1a1a;
            --hrc-gray: #2c2c2c;
        }
        
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
        
        .stats-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            border-left: 4px solid var(--hrc-red);
            transition: transform 0.3s ease;
        }
        
        .stats-card:hover {
            transform: translateY(-2px);
        }
        
        .stats-icon {
            font-size: 2.5rem;
            color: var(--hrc-red);
            margin-bottom: 1rem;
        }
        
        .stats-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--hrc-dark);
            margin-bottom: 0.5rem;
        }
        
        .stats-label {
            color: #666;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .quick-actions {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        
        .action-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            background: linear-gradient(135deg, var(--hrc-red), #c0392b);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            margin: 0.25rem;
        }
        
        .action-btn:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(231, 76, 60, 0.3);
        }
        
        .recent-section {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        
        .recent-section h3 {
            color: var(--hrc-dark);
            font-weight: 700;
            margin-bottom: 1.5rem;
            border-bottom: 2px solid var(--hrc-red);
            padding-bottom: 0.5rem;
        }
        
        .recent-item {
            padding: 1rem;
            border: 1px solid #eee;
            border-radius: 8px;
            margin-bottom: 1rem;
            transition: background-color 0.3s ease;
        }
        
        .recent-item:hover {
            background-color: #f8f9fa;
        }
        
        .recent-item h5 {
            color: var(--hrc-dark);
            margin-bottom: 0.5rem;
        }
        
        .recent-item p {
            color: #666;
            margin: 0;
            font-size: 0.9rem;
        }
        
        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .status-pending {
            background: linear-gradient(135deg, #fdcb6e, #e17055);
            color: white;
        }
        
        .status-onsale {
            background: linear-gradient(135deg, #00d4aa, #00b894);
            color: white;
        }
        
        .status-draft {
            background: linear-gradient(135deg, #636e72, #2d3436);
            color: white;
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
            <h1><i class="bi bi-speedometer2"></i> Admin Dashboard</h1>
            <p>Welcome back! Here's what's happening with Hanoi Rock City</p>
        </div>
    </div>

    <div class="container">
        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="stats-icon">
                        <i class="bi bi-calendar-event"></i>
                    </div>
                    <div class="stats-number">${totalEvents}</div>
                    <div class="stats-label">Total Events</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="stats-icon">
                        <i class="bi bi-list-ul"></i>
                    </div>
                    <div class="stats-number">${totalOrders}</div>
                    <div class="stats-label">Total Orders</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="stats-icon">
                        <i class="bi bi-clock"></i>
                    </div>
                    <div class="stats-number">${pendingOrders}</div>
                    <div class="stats-label">Pending Orders</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="stats-icon">
                        <i class="bi bi-currency-exchange"></i>
                    </div>
                    <div class="stats-number">
                        <fmt:formatNumber value="${totalRevenue}" pattern="#,###"/>
                    </div>
                    <div class="stats-label">Total Revenue (VND)</div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <h3><i class="bi bi-lightning"></i> Quick Actions</h3>
            <div class="d-flex flex-wrap">
                <a href="${pageContext.request.contextPath}/admin/events" class="action-btn">
                    <i class="bi bi-plus-circle"></i> Create Event
                </a>
                <a href="${pageContext.request.contextPath}/admin/orders" class="action-btn">
                    <i class="bi bi-list-check"></i> View Orders
                </a>
                <a href="${pageContext.request.contextPath}/admin/venues" class="action-btn">
                    <i class="bi bi-building-add"></i> Add Venue
                </a>
                <a href="${pageContext.request.contextPath}/admin/artists" class="action-btn">
                    <i class="bi bi-person-plus"></i> Add Artist
                </a>
                <a href="${pageContext.request.contextPath}/admin/promo-codes" class="action-btn">
                    <i class="bi bi-tag"></i> Create Promo Code
                </a>
                <a href="${pageContext.request.contextPath}/admin/customers" class="action-btn">
                    <i class="bi bi-people"></i> View Customers
                </a>
            </div>
        </div>

        <div class="row">
            <!-- Recent Orders -->
            <div class="col-md-6">
                <div class="recent-section">
                    <h3><i class="bi bi-clock-history"></i> Recent Orders</h3>
                    <c:if test="${not empty recentOrders}">
                        <c:forEach var="order" items="${recentOrders}">
                            <div class="recent-item">
                                <h5>Order #${order.id}</h5>
                                <p>
                                    <strong>Customer:</strong> ${order.customerId} | 
                                    <strong>Status:</strong> 
                                    <span class="status-badge status-pending">${order.paymentStatus}</span>
                                </p>
                                <p><strong>Date:</strong> ${order.createdAt}</p>
                                <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-sm btn-outline-primary">
                                    View Details
                                </a>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty recentOrders}">
                        <p class="text-muted">No recent orders.</p>
                    </c:if>
                </div>
            </div>

            <!-- Recent Events -->
            <div class="col-md-6">
                <div class="recent-section">
                    <h3><i class="bi bi-calendar-check"></i> Recent Events</h3>
                    <c:if test="${not empty recentEvents}">
                        <c:forEach var="event" items="${recentEvents}">
                            <div class="recent-item">
                                <h5>${event.name}</h5>
                                <p>
                                    <strong>Date:</strong> ${event.startAt} | 
                                    <strong>Status:</strong> 
                                    <span class="status-badge status-${event.status.toLowerCase()}">${event.status}</span>
                                </p>
                                <p><strong>Venue:</strong> ${event.venueId}</p>
                                <a href="${pageContext.request.contextPath}/admin/events" class="btn btn-sm btn-outline-primary">
                                    Manage Event
                                </a>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty recentEvents}">
                        <p class="text-muted">No recent events.</p>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
