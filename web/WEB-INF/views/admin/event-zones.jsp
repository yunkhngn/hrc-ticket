<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Zones Management - Hanoi Rock City</title>
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
        
        .event-info-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
            border: 1px solid #f0f0f0;
            position: relative;
            overflow: hidden;
        }
        
        .event-info-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(135deg, var(--hrc-red), #c0392b);
        }
        
        .event-title {
            color: var(--hrc-dark);
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        
        .event-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
        }
        
        .detail-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .detail-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--hrc-red), #c0392b);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.1rem;
        }
        
        .detail-content {
            flex: 1;
        }
        
        .detail-label {
            font-weight: 600;
            color: #666;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.25rem;
        }
        
        .detail-value {
            color: var(--hrc-dark);
            font-weight: 500;
            font-size: 1rem;
        }
        
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .status-onsale {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }
        
        .status-draft {
            background: linear-gradient(135deg, #6c757d, #495057);
            color: white;
        }
        
        .status-soldout {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }
        
        .status-closed {
            background: linear-gradient(135deg, #6f42c1, #5a32a3);
            color: white;
        }
        
        .status-cancelled {
            background: linear-gradient(135deg, #fd7e14, #e55a00);
            color: white;
        }
        
        .create-btn {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .create-btn:hover {
            background: linear-gradient(135deg, #20c997, #17a2b8);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(40, 167, 69, 0.3);
        }
        
        .zone-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
            border: 1px solid #f0f0f0;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .zone-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(135deg, #20c997, #17a2b8);
        }
        
        .zone-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 35px rgba(0,0,0,0.12);
        }
        
        .zone-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
        }
        
        .zone-title {
            color: var(--hrc-dark);
            font-size: 1.5rem;
            font-weight: 700;
            margin: 0;
        }
        
        .zone-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .zone-actions {
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
            padding-top: 1.5rem;
            border-top: 1px solid #f0f0f0;
        }
        
        .action-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.25rem;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.875rem;
            text-decoration: none;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .btn-edit {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
        }
        
        .btn-edit:hover {
            background: linear-gradient(135deg, #0056b3, #004085);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 123, 255, 0.3);
        }
        
        .btn-delete {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }
        
        .btn-delete:hover {
            background: linear-gradient(135deg, #c82333, #a71e2a);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(220, 53, 69, 0.3);
        }
        
        .alert {
            border-radius: 12px;
            border: none;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .alert-success {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724;
        }
        
        .alert-danger {
            background: linear-gradient(135deg, #f8d7da, #f5c6cb);
            color: #721c24;
        }
        
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #666;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 1.5rem;
        }
        
        .empty-state h3 {
            color: var(--hrc-dark);
            margin-bottom: 1rem;
        }
        
        .modal-content {
            border-radius: 16px;
            border: none;
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }
        
        .modal-header {
            background: linear-gradient(135deg, var(--hrc-dark), var(--hrc-gray));
            color: white;
            border-radius: 16px 16px 0 0;
            border-bottom: none;
            padding: 1.5rem 2rem;
        }
        
        .modal-header h5 {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 600;
        }
        
        .modal-body {
            padding: 2rem;
        }
        
        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 0.875rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--hrc-red);
            box-shadow: 0 0 0 0.2rem rgba(231, 76, 60, 0.25);
        }
        
        .form-label {
            font-weight: 600;
            color: var(--hrc-dark);
            margin-bottom: 0.5rem;
        }
        
        .modal-footer {
            padding: 1.5rem 2rem;
            border-top: 1px solid #f0f0f0;
            display: flex;
            gap: 0.75rem;
            justify-content: flex-end;
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            border: none;
        }
        
        .btn-success:hover {
            background: linear-gradient(135deg, #20c997, #17a2b8);
            transform: translateY(-2px);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #007bff, #0056b3);
            border: none;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #0056b3, #004085);
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            background: #6c757d;
            border: none;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }
        
        @media (max-width: 768px) {
            .event-details {
                grid-template-columns: 1fr;
            }
            
            .zone-info {
                grid-template-columns: 1fr;
            }
            
            .zone-actions {
                flex-direction: column;
            }
            
            .action-btn {
                width: 100%;
                justify-content: center;
            }
            
            .zone-header {
                flex-direction: column;
                gap: 1rem;
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
            <h1><i class="bi bi-grid-3x3"></i> Event Zones Management</h1>
            <p>Manage zones for event: ${event.name}</p>
        </div>
    </div>

    <div class="container">
        <!-- Event Info Card -->
        <div class="event-info-card">
            <h2 class="event-title">${event.name}</h2>
            <div class="event-details">
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="bi bi-building"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Venue</div>
                        <div class="detail-value">${event.venueName}</div>
                    </div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="bi bi-chat-text"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Description</div>
                        <div class="detail-value">${event.description}</div>
                    </div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="bi bi-calendar3"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Date & Time</div>
                        <div class="detail-value">${event.startAt}</div>
                    </div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="bi bi-tag"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Status</div>
                        <div class="detail-value">
                            <span class="status-badge status-${event.status.toLowerCase()}">
                                <i class="bi bi-${event.status eq 'ONSALE' ? 'check-circle' : event.status eq 'DRAFT' ? 'clock' : event.status eq 'SOLDOUT' ? 'x-circle' : event.status eq 'CLOSED' ? 'lock' : event.status eq 'CANCELLED' ? 'slash-circle' : 'question-circle'}"></i>
                                ${event.status}
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Alerts -->
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

        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0">Event Zones</h2>
            <button class="create-btn" data-bs-toggle="modal" data-bs-target="#createZoneModal">
                <i class="bi bi-plus-circle"></i> Add New Zone
            </button>
        </div>

        <!-- Zones List -->
        <c:if test="${not empty eventZones}">
            <c:forEach var="eventZone" items="${eventZones}">
                <div class="zone-card">
                    <div class="zone-header">
                        <h3 class="zone-title">${eventZone.venueZoneName}</h3>
                    </div>
                    
                    <div class="zone-info">
                        <div class="detail-item">
                            <div class="detail-icon">
                                <i class="bi bi-grid-3x3"></i>
                            </div>
                            <div class="detail-content">
                                <div class="detail-label">Zone Name</div>
                                <div class="detail-value">${eventZone.venueZoneName}</div>
                            </div>
                        </div>
                        
                        <div class="detail-item">
                            <div class="detail-icon">
                                <i class="bi bi-people"></i>
                            </div>
                            <div class="detail-content">
                                <div class="detail-label">Capacity</div>
                                <div class="detail-value">${eventZone.venueZoneCapacity} seats</div>
                            </div>
                        </div>
                        
                        <div class="detail-item">
                            <div class="detail-icon">
                                <i class="bi bi-currency-dollar"></i>
                            </div>
                            <div class="detail-content">
                                <div class="detail-label">Price</div>
                                <div class="detail-value">${eventZone.currency} ${eventZone.price}</div>
                            </div>
                        </div>
                        
                        <div class="detail-item">
                            <div class="detail-icon">
                                <i class="bi bi-cash-coin"></i>
                            </div>
                            <div class="detail-content">
                                <div class="detail-label">Fee</div>
                                <div class="detail-value">${eventZone.currency} ${eventZone.fee}</div>
                            </div>
                        </div>
                        
                        <div class="detail-item">
                            <div class="detail-icon">
                                <i class="bi bi-ticket-perforated"></i>
                            </div>
                            <div class="detail-content">
                                <div class="detail-label">Allocation</div>
                                <div class="detail-value">${eventZone.allocation} tickets</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="zone-actions">
                        <button class="action-btn btn-edit" onclick="editEventZone(${eventZone.id}, ${eventZone.venueZoneId}, '${eventZone.currency}', ${eventZone.price}, ${eventZone.fee}, ${eventZone.allocation})" data-bs-toggle="modal" data-bs-target="#editZoneModal">
                            <i class="bi bi-pencil"></i> Edit
                        </button>
                        
                        <form action="${pageContext.request.contextPath}/admin/event-zones" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="eventId" value="${event.id}">
                            <input type="hidden" name="eventZoneId" value="${eventZone.id}">
                            <button type="submit" class="action-btn btn-delete" onclick="return confirm('Are you sure you want to delete this event zone?')">
                                <i class="bi bi-trash"></i> Delete
                            </button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        
        <c:if test="${empty eventZones}">
            <div class="empty-state">
                <i class="bi bi-grid-3x3"></i>
                <h3>No Zones Configured</h3>
                <p>This event doesn't have any zones configured yet.</p>
                <button class="create-btn" data-bs-toggle="modal" data-bs-target="#createZoneModal">
                    <i class="bi bi-plus-circle"></i> Add New Zone
                </button>
            </div>
        </c:if>
    </div>

    <!-- Create Zone Modal -->
    <div class="modal fade" id="createZoneModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-plus-circle"></i> Add New Event Zone</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/event-zones" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="create">
                        <input type="hidden" name="eventId" value="${event.id}">
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="venueZoneId" class="form-label">Venue Zone *</label>
                                <select class="form-select" id="venueZoneId" name="venueZoneId" required>
                                    <option value="">Select a venue zone</option>
                                    <c:forEach var="venueZone" items="${availableVenueZones}">
                                        <option value="${venueZone.id}">${venueZone.name} (${venueZone.capacity} seats)</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="currency" class="form-label">Currency *</label>
                                <select class="form-select" id="currency" name="currency" required>
                                    <option value="">Select currency</option>
                                    <option value="USD">USD</option>
                                    <option value="EUR">EUR</option>
                                    <option value="GBP">GBP</option>
                                    <option value="VND">VND</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="price" class="form-label">Price *</label>
                                <input type="number" class="form-control" id="price" name="price" step="0.01" min="0" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="fee" class="form-label">Fee (Optional)</label>
                                <input type="number" class="form-control" id="fee" name="fee" step="0.01" min="0">
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="allocation" class="form-label">Ticket Allocation *</label>
                            <input type="number" class="form-control" id="allocation" name="allocation" min="1" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-success">
                            <i class="bi bi-plus-circle"></i> Add Zone
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Zone Modal -->
    <div class="modal fade" id="editZoneModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-pencil"></i> Edit Event Zone</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/event-zones" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="eventId" value="${event.id}">
                        <input type="hidden" id="editEventZoneId" name="eventZoneId">
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="editVenueZoneId" class="form-label">Venue Zone *</label>
                                <select class="form-select" id="editVenueZoneId" name="venueZoneId" required>
                                    <option value="">Select a venue zone</option>
                                    <c:forEach var="venueZone" items="${availableVenueZones}">
                                        <option value="${venueZone.id}">${venueZone.name} (${venueZone.capacity} seats)</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="editCurrency" class="form-label">Currency *</label>
                                <select class="form-select" id="editCurrency" name="currency" required>
                                    <option value="">Select currency</option>
                                    <option value="USD">USD</option>
                                    <option value="EUR">EUR</option>
                                    <option value="GBP">GBP</option>
                                    <option value="VND">VND</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="editPrice" class="form-label">Price *</label>
                                <input type="number" class="form-control" id="editPrice" name="price" step="0.01" min="0" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="editFee" class="form-label">Fee (Optional)</label>
                                <input type="number" class="form-control" id="editFee" name="fee" step="0.01" min="0">
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="editAllocation" class="form-label">Ticket Allocation *</label>
                            <input type="number" class="form-control" id="editAllocation" name="allocation" min="1" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle"></i> Update Zone
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editEventZone(eventZoneId, venueZoneId, currency, price, fee, allocation) {
            document.getElementById('editEventZoneId').value = eventZoneId;
            document.getElementById('editVenueZoneId').value = venueZoneId;
            document.getElementById('editCurrency').value = currency;
            document.getElementById('editPrice').value = price;
            document.getElementById('editFee').value = fee || '';
            document.getElementById('editAllocation').value = allocation;
        }
    </script>
</body>
</html>