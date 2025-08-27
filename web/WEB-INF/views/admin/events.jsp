<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Events Management - Hanoi Rock City</title>
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
        
        .event-card {
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
        
        .event-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(135deg, var(--hrc-red), #c0392b);
        }
        
        .event-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 35px rgba(0,0,0,0.12);
        }
        
        .event-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
        }
        
        .event-title {
            color: var(--hrc-dark);
            font-size: 1.75rem;
            font-weight: 700;
            margin: 0;
            line-height: 1.2;
        }
        
        .event-status {
            margin-left: 1rem;
        }
        
        .event-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .info-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem;
            background: #f8f9fa;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }
        
        .info-item:hover {
            background: #e9ecef;
        }
        
        .info-icon {
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
        
        .info-content {
            flex: 1;
        }
        
        .info-label {
            font-weight: 600;
            color: #666;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.25rem;
        }
        
        .info-value {
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
        
        .event-actions {
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
            position: relative;
            overflow: hidden;
        }
        
        .action-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }
        
        .action-btn:hover::before {
            left: 100%;
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
        
        .btn-artists {
            background: linear-gradient(135deg, #fd7e14, #e55a00);
            color: white;
        }
        
        .btn-artists:hover {
            background: linear-gradient(135deg, #e55a00, #cc4a00);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(253, 126, 20, 0.3);
        }
        
        .btn-zones {
            background: linear-gradient(135deg, #20c997, #17a2b8);
            color: white;
        }
        
        .btn-zones:hover {
            background: linear-gradient(135deg, #17a2b8, #138496);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(32, 201, 151, 0.3);
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
            .event-info {
                grid-template-columns: 1fr;
            }
            
            .event-actions {
                flex-direction: column;
            }
            
            .action-btn {
                width: 100%;
                justify-content: center;
            }
            
            .event-header {
                flex-direction: column;
                gap: 1rem;
            }
            
            .event-status {
                margin-left: 0;
                align-self: flex-start;
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
            <h1><i class="bi bi-calendar-event"></i> Events Management</h1>
            <p>Manage all events for Hanoi Rock City</p>
        </div>
    </div>

    <div class="container">
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
            <h2 class="mb-0">All Events</h2>
            <button class="create-btn" data-bs-toggle="modal" data-bs-target="#createEventModal">
                <i class="bi bi-plus-circle"></i> Create New Event
            </button>
        </div>

        <!-- Events List -->
        <c:if test="${not empty events}">
            <c:forEach var="event" items="${events}">
                <div class="event-card">
                    <div class="event-header">
                        <h3 class="event-title">${event.name}</h3>
                        <div class="event-status">
                            <span class="status-badge status-${event.status.toLowerCase()}">
                                <i class="bi bi-${event.status eq 'ONSALE' ? 'check-circle' : event.status eq 'DRAFT' ? 'clock' : event.status eq 'SOLDOUT' ? 'x-circle' : event.status eq 'CLOSED' ? 'lock' : event.status eq 'CANCELLED' ? 'slash-circle' : 'question-circle'}"></i>
                                ${event.status}
                            </span>
                        </div>
                    </div>
                    
                    <div class="event-info">
                        <div class="info-item">
                            <div class="info-icon">
                                <i class="bi bi-chat-text"></i>
                            </div>
                            <div class="info-content">
                                <div class="info-label">Description</div>
                                <div class="info-value">${event.description}</div>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-icon">
                                <i class="bi bi-calendar3"></i>
                            </div>
                            <div class="info-content">
                                <div class="info-label">Date & Time</div>
                                <div class="info-value">${event.startAt}</div>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-icon">
                                <i class="bi bi-person"></i>
                            </div>
                            <div class="info-content">
                                <div class="info-label">Minimum Age</div>
                                <div class="info-value">${event.minAge != null ? event.minAge : 'No restriction'} years</div>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-icon">
                                <i class="bi bi-building"></i>
                            </div>
                            <div class="info-content">
                                <div class="info-label">Venue ID</div>
                                <div class="info-value">${event.venueId}</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="event-actions">
                        <button class="action-btn btn-edit" onclick="editEvent(${event.id}, '${event.name}', '${event.description}', '${event.startAt}', '${event.endAt}', '${event.status}', ${event.minAge}, ${event.venueId})" data-bs-toggle="modal" data-bs-target="#editEventModal">
                            <i class="bi bi-pencil"></i> Edit
                        </button>
                        
                        <a href="${pageContext.request.contextPath}/admin/event-artists?eventId=${event.id}" class="action-btn btn-artists">
                            <i class="bi bi-music-note-beamed"></i> Artists
                        </a>
                        
                        <a href="${pageContext.request.contextPath}/admin/event-zones?eventId=${event.id}" class="action-btn btn-zones">
                            <i class="bi bi-grid-3x3"></i> Zones
                        </a>
                        
                        <form action="${pageContext.request.contextPath}/admin/events" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="eventId" value="${event.id}">
                            <button type="submit" class="action-btn btn-delete" onclick="return confirm('Are you sure you want to delete this event? This will also delete all associated event zones.')">
                                <i class="bi bi-trash"></i> Delete
                            </button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        
        <c:if test="${empty events}">
            <div class="empty-state">
                <i class="bi bi-calendar-x"></i>
                <h3>No Events Available</h3>
                <p>Get started by creating your first event!</p>
                <button class="create-btn" data-bs-toggle="modal" data-bs-target="#createEventModal">
                    <i class="bi bi-plus-circle"></i> Create New Event
                </button>
            </div>
        </c:if>
    </div>

    <!-- Create Event Modal -->
    <div class="modal fade" id="createEventModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-plus-circle"></i> Create New Event</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/events" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="create">
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="name" class="form-label">Event Name *</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="status" class="form-label">Status</label>
                                <select class="form-select" id="status" name="status">
                                    <option value="DRAFT">Draft</option>
                                    <option value="ONSALE">On Sale</option>
                                    <option value="SOLDOUT">Sold Out</option>
                                    <option value="CLOSED">Closed</option>
                                    <option value="CANCELLED">Cancelled</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="startAt" class="form-label">Start Date & Time *</label>
                                <input type="datetime-local" class="form-control" id="startAt" name="startAt" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="endAt" class="form-label">End Date & Time (Optional)</label>
                                <input type="datetime-local" class="form-control" id="endAt" name="endAt">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="minAge" class="form-label">Minimum Age *</label>
                                <input type="number" class="form-control" id="minAge" name="minAge" min="0" max="100" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="venueId" class="form-label">Venue *</label>
                                <select class="form-select" id="venueId" name="venueId" required>
                                    <option value="">Select a venue</option>
                                    <c:forEach var="venue" items="${venues}">
                                        <option value="${venue.id}">${venue.name} - ${venue.city}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-success">
                            <i class="bi bi-plus-circle"></i> Create Event
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Event Modal -->
    <div class="modal fade" id="editEventModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-pencil"></i> Edit Event</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/events" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" id="editEventId" name="eventId">
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="editName" class="form-label">Event Name *</label>
                                <input type="text" class="form-control" id="editName" name="name" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="editStatus" class="form-label">Status</label>
                                <select class="form-select" id="editStatus" name="status">
                                    <option value="DRAFT">Draft</option>
                                    <option value="ONSALE">On Sale</option>
                                    <option value="SOLDOUT">Sold Out</option>
                                    <option value="CLOSED">Closed</option>
                                    <option value="CANCELLED">Cancelled</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="editDescription" class="form-label">Description</label>
                            <textarea class="form-control" id="editDescription" name="description" rows="3"></textarea>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="editStartAt" class="form-label">Start Date & Time *</label>
                                <input type="datetime-local" class="form-control" id="editStartAt" name="startAt" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="editEndAt" class="form-label">End Date & Time (Optional)</label>
                                <input type="datetime-local" class="form-control" id="editEndAt" name="endAt">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="editMinAge" class="form-label">Minimum Age *</label>
                                <input type="number" class="form-control" id="editMinAge" name="minAge" min="0" max="100" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="editVenueId" class="form-label">Venue *</label>
                                <select class="form-select" id="editVenueId" name="venueId" required>
                                    <option value="">Select a venue</option>
                                    <c:forEach var="venue" items="${venues}">
                                        <option value="${venue.id}">${venue.name} - ${venue.city}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle"></i> Update Event
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editEvent(eventId, name, description, startAt, endAt, status, minAge, venueId) {
            document.getElementById('editEventId').value = eventId;
            document.getElementById('editName').value = name;
            document.getElementById('editDescription').value = description || '';
            
            // Format datetime for datetime-local input
            if (startAt) {
                const formattedStartAt = startAt.replace(' ', 'T').substring(0, 16);
                document.getElementById('editStartAt').value = formattedStartAt;
            }
            
            if (endAt) {
                const formattedEndAt = endAt.replace(' ', 'T').substring(0, 16);
                document.getElementById('editEndAt').value = formattedEndAt;
            } else {
                document.getElementById('editEndAt').value = '';
            }
            
            document.getElementById('editStatus').value = status;
            document.getElementById('editMinAge').value = (minAge && minAge !== 'null') ? minAge : '';
            document.getElementById('editVenueId').value = venueId;
        }
    </script>
</body>
</html>