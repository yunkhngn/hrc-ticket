<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Artists Management - HRC Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --hrc-red: #dc3545;
            --hrc-dark: #1a1a1a;
            --hrc-gray: #2c2c2c;
        }
        
        body {
            background: #f8f9fa;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }
        
        .navbar {
            background: var(--hrc-dark);
            padding: 1rem 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .navbar-brand {
            color: white !important;
            font-weight: 700;
            font-size: 1.5rem;
        }
        
        .nav-link {
            color: rgba(255, 255, 255, 0.9) !important;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .nav-link:hover {
            color: white !important;
            transform: translateY(-2px);
        }
        
        .logout-btn {
            background: var(--hrc-red);
            border: none;
            border-radius: 8px;
            padding: 0.5rem 1rem;
            color: white !important;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .logout-btn:hover {
            background: #c82333;
            color: white !important;
            transform: translateY(-2px);
        }
        
        .admin-header {
            background: var(--hrc-dark);
            padding: 3rem 0;
            margin-bottom: 2rem;
            text-align: center;
        }
        
        .admin-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: white;
        }
        
        .admin-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            color: white;
        }
        
        .container {
            max-width: 1200px;
        }
        
        .alert {
            border-radius: 12px;
            border: none;
            margin-bottom: 2rem;
        }
        
        .add-artist-section {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
            border: 1px solid #f0f0f0;
        }
        
        .add-artist-section h3 {
            color: var(--hrc-dark);
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--hrc-dark);
            margin-bottom: 0.5rem;
        }
        
        .form-control, .form-select {
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            padding: 0.75rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--hrc-red);
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }
        
        .form-check-input:checked {
            background-color: var(--hrc-red);
            border-color: var(--hrc-red);
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
        }
        
        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }
        
        .btn-success:hover {
            background: linear-gradient(135deg, #20c997, #17a2b8);
            transform: translateY(-2px);
            color: white;
        }
        
        .btn-warning {
            background: linear-gradient(135deg, #ffc107, #fd7e14);
            color: black;
        }
        
        .btn-warning:hover {
            background: linear-gradient(135deg, #fd7e14, #e55a00);
            transform: translateY(-2px);
            color: black;
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }
        
        .btn-danger:hover {
            background: linear-gradient(135deg, #c82333, #a71e2a);
            transform: translateY(-2px);
            color: white;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
            color: white;
        }
        
        .artist-card {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            border: 1px solid #f0f0f0;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .artist-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(135deg, var(--hrc-red), #c82333);
        }
        
        .artist-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
        }
        
        .artist-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1rem;
        }
        
        .artist-name {
            color: var(--hrc-dark);
            font-size: 1.25rem;
            font-weight: 700;
            margin: 0;
        }
        
        .artist-info {
            display: flex;
            gap: 2rem;
            margin-bottom: 1.5rem;
        }
        
        .info-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .info-label {
            color: #6c757d;
            font-size: 0.875rem;
            font-weight: 600;
        }
        
        .info-value {
            color: var(--hrc-dark);
            font-weight: 500;
        }
        
        .headliner-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
        }
        
        .headliner-yes {
            background: linear-gradient(135deg, #ffc107, #fd7e14);
            color: black;
        }
        
        .headliner-no {
            background: linear-gradient(135deg, #6c757d, #5a6268);
            color: white;
        }
        
        .artist-actions {
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
            background: white;
            border-radius: 16px;
            color: var(--hrc-dark);
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
        
        .empty-state i {
            font-size: 3rem;
            color: var(--hrc-red);
            margin-bottom: 1rem;
        }
        
        .empty-state h3 {
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
        }
        
        .empty-state p {
            color: #6c757d;
            margin-bottom: 0;
        }
        
        .navigation-buttons {
            margin-top: 2rem;
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        
        @media (max-width: 768px) {
            .artist-header {
                flex-direction: column;
                gap: 1rem;
            }
            
            .artist-info {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .artist-actions {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
            
            .navigation-buttons {
                flex-direction: column;
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
            <h1><i class="bi bi-music-note-beamed"></i> Event Artists Management</h1>
            <p>Manage artists for Event ID: ${eventId}</p>
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

        <!-- Add Artist to Event Form -->
        <div class="add-artist-section">
            <h3><i class="bi bi-plus-circle"></i> Add Artist to Event</h3>
            <form action="${pageContext.request.contextPath}/admin/event-artists" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="eventId" value="${eventId}">
                
                <div class="row">
                    <div class="col-md-8 mb-3">
                        <label for="artistId" class="form-label">Select Artist</label>
                        <select id="artistId" name="artistId" class="form-select" required>
                            <option value="">Choose an artist...</option>
                            <c:forEach var="artist" items="${allArtists}">
                                <option value="${artist.id}">${artist.name} (${artist.country})</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-4 mb-3 d-flex align-items-end">
                        <div class="form-check">
                            <input type="checkbox" name="isHeadliner" class="form-check-input" id="isHeadliner">
                            <label class="form-check-label" for="isHeadliner">
                                Mark as Headliner
                            </label>
                        </div>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-success">
                    <i class="bi bi-plus-circle"></i> Add Artist
                </button>
            </form>
        </div>

        <!-- Current Event Artists -->
        <div class="mb-4">
            <h3 class="mb-3"><i class="bi bi-music-note-list"></i> Current Event Artists</h3>
            
            <c:if test="${not empty eventArtists}">
                <c:forEach var="eventArtist" items="${eventArtists}">
                    <div class="artist-card">
                        <div class="artist-header">
                            <h4 class="artist-name">${eventArtist.artistName}</h4>
                            <span class="headliner-badge ${eventArtist.headliner ? 'headliner-yes' : 'headliner-no'}">
                                <i class="bi bi-${eventArtist.headliner ? 'star-fill' : 'star'}"></i>
                                Headliner: ${eventArtist.headliner ? 'YES' : 'NO'}
                            </span>
                        </div>
                        
                        <div class="artist-info">
                            <div class="info-item">
                                <span class="info-label">Country:</span>
                                <span class="info-value">${eventArtist.artistCountry}</span>
                            </div>
                        </div>
                        
                        <div class="artist-actions">
                            <form action="${pageContext.request.contextPath}/admin/event-artists" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="toggle-headliner">
                                <input type="hidden" name="eventId" value="${eventId}">
                                <input type="hidden" name="artistId" value="${eventArtist.artistId}">
                                <button type="submit" class="btn btn-warning">
                                    <i class="bi bi-${eventArtist.headliner ? 'star' : 'star-fill'}"></i>
                                    ${eventArtist.headliner ? 'Remove Headliner' : 'Make Headliner'}
                                </button>
                            </form>
                            
                            <form action="${pageContext.request.contextPath}/admin/event-artists" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="eventId" value="${eventId}">
                                <input type="hidden" name="artistId" value="${eventArtist.artistId}">
                                <button type="submit" onclick="return confirm('Are you sure you want to remove this artist from the event?')" class="btn btn-danger">
                                    <i class="bi bi-trash"></i> Remove
                                </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            
            <c:if test="${empty eventArtists}">
                <div class="empty-state">
                    <i class="bi bi-music-note-list"></i>
                    <h3>No Artists Assigned</h3>
                    <p>No artists have been assigned to this event yet.</p>
                </div>
            </c:if>
        </div>

        <!-- Navigation Buttons -->
        <div class="navigation-buttons">
            <a href="${pageContext.request.contextPath}/admin/events" class="btn btn-success">
                <i class="bi bi-arrow-left"></i> Back to Events
            </a>
            <a href="${pageContext.request.contextPath}/admin/artists" class="btn btn-warning">
                <i class="bi bi-music-note-beamed"></i> Manage Artists
            </a>
            <a href="${pageContext.request.contextPath}/admin" class="btn btn-secondary">
                <i class="bi bi-house"></i> Dashboard
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
