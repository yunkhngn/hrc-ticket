<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Venue Management - HRC Admin</title>
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
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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
            color: white !important;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .logout-btn:hover {
            background: #c82333;
            transform: translateY(-2px);
        }
        
        .admin-header {
            background: var(--hrc-dark);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        
        .admin-header h1 {
            margin: 0;
            font-weight: 700;
            font-size: 2.5rem;
        }
        
        .admin-header p {
            margin: 0.5rem 0 0 0;
            opacity: 0.9;
        }
        
        .venue-card {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border-left: 4px solid var(--hrc-red);
            transition: all 0.3s ease;
        }
        
        .venue-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        }
        
        .venue-name {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--hrc-dark);
            margin-bottom: 1rem;
        }
        
        .venue-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .info-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .info-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--hrc-red), #c82333);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }
        
        .info-content {
            flex: 1;
        }
        
        .info-label {
            font-size: 0.85rem;
            color: #6c757d;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .info-value {
            font-size: 1rem;
            color: var(--hrc-dark);
            font-weight: 600;
        }
        
        .venue-actions {
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
        }
        
        .btn-edit {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-edit:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
        }
        
        .btn-zones {
            background: linear-gradient(135deg, #20c997, #17a2b8);
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .btn-zones:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(32, 201, 151, 0.3);
            color: white;
        }
        
        .btn-delete {
            background: linear-gradient(135deg, var(--hrc-red), #c82333);
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
        }
        
        .btn-create {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            margin-bottom: 2rem;
        }
        
        .btn-create:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(40, 167, 69, 0.3);
        }
        
        .modal-content {
            border-radius: 16px;
            border: none;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
        }
        
        .modal-header {
            background: var(--hrc-dark);
            color: white;
            border-radius: 16px 16px 0 0;
        }
        
        .form-control {
            border-radius: 8px;
            border: 2px solid #e9ecef;
            padding: 0.75rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--hrc-red);
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }
        
        .form-label {
            font-weight: 600;
            color: var(--hrc-dark);
            margin-bottom: 0.5rem;
        }
        
        .alert {
            border-radius: 12px;
            border: none;
            padding: 1rem 1.5rem;
        }
        
        .alert-success {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724;
        }
        
        .alert-danger {
            background: linear-gradient(135deg, #f8d7da, #f5c6cb);
            color: #721c24;
        }
        
        @media (max-width: 768px) {
            .venue-info {
                grid-template-columns: 1fr;
            }
            
            .venue-actions {
                flex-direction: column;
            }
            
            .venue-actions .btn {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin">
                <i class="bi bi-music-note-beamed"></i> HRC Admin
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin">Dashboard</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/events">Events</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/venues">Venues</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">Orders</a>
                <a class="nav-link logout-btn" href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Admin Header -->
    <div class="admin-header">
        <div class="container">
            <h1><i class="bi bi-building"></i> Venue Management</h1>
            <p>Manage concert venues and their zones</p>
        </div>
    </div>

    <div class="container">
        <!-- Success/Error Messages -->
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

        <!-- Create Button -->
        <button class="btn-create" onclick="showCreateModal()">
            <i class="bi bi-plus-circle"></i> Create New Venue
        </button>

        <!-- Venues List -->
        <c:if test="${not empty venues}">
            <div class="row">
                <c:forEach var="venue" items="${venues}">
                    <div class="col-12">
                        <div class="venue-card">
                            <div class="venue-name">${venue.name}</div>
                            
                            <div class="venue-info">
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="bi bi-geo-alt"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-label">Address</div>
                                        <div class="info-value">${venue.address}</div>
                                    </div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="bi bi-building"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-label">City</div>
                                        <div class="info-value">${venue.city}</div>
                                    </div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="bi bi-people"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-label">Capacity</div>
                                        <div class="info-value">${venue.capacity != null ? venue.capacity : 'Not specified'}</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="venue-actions">
                                <button class="btn-edit" onclick="editVenue(${venue.id}, '${venue.name}', '${venue.address}', '${venue.city}', ${venue.capacity})">
                                    <i class="bi bi-pencil"></i> Edit
                                </button>
                                <a class="btn-zones" href="${pageContext.request.contextPath}/admin/venue-zones?venueId=${venue.id}">
                                    <i class="bi bi-grid-3x3"></i> Manage Zones
                                </a>
                                <form action="${pageContext.request.contextPath}/admin/venues" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="venueId" value="${venue.id}">
                                    <button type="submit" class="btn-delete" onclick="return confirm('Are you sure you want to delete this venue? This will also delete all associated events and zones.')">
                                        <i class="bi bi-trash"></i> Delete
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        
        <c:if test="${empty venues}">
            <div class="text-center py-5">
                <i class="bi bi-building" style="font-size: 4rem; color: #6c757d;"></i>
                <h3 class="mt-3">No venues available</h3>
                <p class="text-muted">Create your first venue to get started</p>
            </div>
        </c:if>
    </div>

    <!-- Create Venue Modal -->
    <div class="modal fade" id="createModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-plus-circle"></i> Create New Venue</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/venues" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="create">
                        
                        <div class="mb-3">
                            <label for="name" class="form-label">Venue Name</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <input type="text" class="form-control" id="address" name="address">
                        </div>
                        
                        <div class="mb-3">
                            <label for="city" class="form-label">City</label>
                            <input type="text" class="form-control" id="city" name="city">
                        </div>
                        
                        <div class="mb-3">
                            <label for="capacity" class="form-label">Capacity (Optional)</label>
                            <input type="number" class="form-control" id="capacity" name="capacity" min="1">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-success">Create Venue</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Venue Modal -->
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-pencil"></i> Edit Venue</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/venues" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" id="editVenueId" name="venueId">
                        
                        <div class="mb-3">
                            <label for="editName" class="form-label">Venue Name</label>
                            <input type="text" class="form-control" id="editName" name="name" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="editAddress" class="form-label">Address</label>
                            <input type="text" class="form-control" id="editAddress" name="address">
                        </div>
                        
                        <div class="mb-3">
                            <label for="editCity" class="form-label">City</label>
                            <input type="text" class="form-control" id="editCity" name="city">
                        </div>
                        
                        <div class="mb-3">
                            <label for="editCapacity" class="form-label">Capacity (Optional)</label>
                            <input type="number" class="form-control" id="editCapacity" name="capacity" min="1">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Update Venue</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function showCreateModal() {
            new bootstrap.Modal(document.getElementById('createModal')).show();
        }
        
        function editVenue(venueId, name, address, city, capacity) {
            document.getElementById('editVenueId').value = venueId;
            document.getElementById('editName').value = name;
            document.getElementById('editAddress').value = address || '';
            document.getElementById('editCity').value = city || '';
            document.getElementById('editCapacity').value = capacity || '';
            
            new bootstrap.Modal(document.getElementById('editModal')).show();
        }
    </script>
</body>
</html>
