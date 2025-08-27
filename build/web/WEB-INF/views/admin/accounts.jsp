<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Management - HRC Admin</title>
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
        
        .user-card {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border-left: 4px solid var(--hrc-red);
            transition: all 0.3s ease;
        }
        
        .user-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        }
        
        .user-name {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--hrc-dark);
            margin-bottom: 1rem;
        }
        
        .user-info {
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
        
        .role-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
        }
        
        .role-admin {
            background: linear-gradient(135deg, var(--hrc-red), #c82333);
            color: white;
        }
        
        .role-staff {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
        }
        
        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
        }
        
        .status-active {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }
        
        .status-inactive {
            background: linear-gradient(135deg, #6c757d, #495057);
            color: white;
        }
        
        .user-actions {
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
        
        .btn-toggle {
            background: linear-gradient(135deg, #ffc107, #e0a800);
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-toggle:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);
        }
        
        .btn-activate {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-activate:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
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
        
        .btn-permanent-delete {
            background: linear-gradient(135deg, #8B0000, #660000);
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-permanent-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(139, 0, 0, 0.3);
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
            .user-info {
                grid-template-columns: 1fr;
            }
            
            .user-actions {
                flex-direction: column;
            }
            
            .user-actions .btn {
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
            <h1><i class="bi bi-person-gear"></i> Account Management</h1>
            <p>Manage staff and admin accounts</p>
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
            <i class="bi bi-plus-circle"></i> Create New User
        </button>

        <!-- Users List -->
        <c:if test="${not empty users}">
            <div class="row">
                <c:forEach var="user" items="${users}">
                    <div class="col-12">
                        <div class="user-card">
                            <div class="user-name">${user.fullName}</div>
                            
                            <div class="user-info">
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="bi bi-envelope"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-label">Email</div>
                                        <div class="info-value">${user.email}</div>
                                    </div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="bi bi-telephone"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-label">Phone</div>
                                        <div class="info-value">${user.phone}</div>
                                    </div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="bi bi-shield"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-label">Role</div>
                                        <div class="info-value">
                                            <span class="role-badge ${user.role eq 'ADMIN' ? 'role-admin' : 'role-staff'}">
                                                ${user.role}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="bi bi-circle-fill"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-label">Status</div>
                                        <div class="info-value">
                                            <span class="status-badge ${user.active ? 'status-active' : 'status-inactive'}">
                                                ${user.active ? 'Active' : 'Inactive'}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="bi bi-calendar"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-label">Created</div>
                                        <div class="info-value">${user.createdAt}</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="user-actions">
                                <button class="btn-edit" onclick="editUser(${user.id}, '${user.email}', '${user.fullName}', '${user.phone}', '${user.role}')">
                                    <i class="bi bi-pencil"></i> Edit
                                </button>
                                
                                <c:if test="${user.id ne sessionScope.userId}">
                                    <form action="${pageContext.request.contextPath}/admin/accounts" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="toggleStatus">
                                        <input type="hidden" name="userId" value="${user.id}">
                                        <button type="submit" class="${user.active ? 'btn-toggle' : 'btn-activate'}">
                                            <i class="bi bi-${user.active ? 'pause' : 'play'}"></i> ${user.active ? 'Deactivate' : 'Activate'}
                                        </button>
                                    </form>
                                    
                                    <form action="${pageContext.request.contextPath}/admin/accounts" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="userId" value="${user.id}">
                                        <button type="submit" class="btn-delete" onclick="return confirm('Are you sure you want to deactivate this user?')">
                                            <i class="bi bi-trash"></i> Deactivate
                                        </button>
                                    </form>
                                    
                                    <c:if test="${!user.active}">
                                        <form action="${pageContext.request.contextPath}/admin/accounts" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="permanentDelete">
                                            <input type="hidden" name="userId" value="${user.id}">
                                            <button type="submit" class="btn-permanent-delete" onclick="return confirm('WARNING: This will PERMANENTLY DELETE the user account. This action cannot be undone. Are you absolutely sure?')">
                                                <i class="bi bi-exclamation-triangle"></i> Permanent Delete
                                            </button>
                                        </form>
                                    </c:if>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        
        <c:if test="${empty users}">
            <div class="text-center py-5">
                <i class="bi bi-person-gear" style="font-size: 4rem; color: #6c757d;"></i>
                <h3 class="mt-3">No users found</h3>
                <p class="text-muted">Create your first user to get started</p>
            </div>
        </c:if>
    </div>

    <!-- Create User Modal -->
    <div class="modal fade" id="createModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-plus-circle"></i> Create New User</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/accounts" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="create">
                        
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="fullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone</label>
                            <input type="tel" class="form-control" id="phone" name="phone">
                        </div>
                        
                        <div class="mb-3">
                            <label for="role" class="form-label">Role</label>
                            <select class="form-control" id="role" name="role">
                                <option value="STAFF">Staff</option>
                                <option value="ADMIN">Admin</option>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-success">Create User</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit User Modal -->
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-pencil"></i> Edit User</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/accounts" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" id="editUserId" name="userId">
                        
                        <div class="mb-3">
                            <label for="editEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="editEmail" name="email" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="editFullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="editFullName" name="fullName" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="editPhone" class="form-label">Phone</label>
                            <input type="tel" class="form-control" id="editPhone" name="phone">
                        </div>
                        
                        <div class="mb-3">
                            <label for="editRole" class="form-label">Role</label>
                            <select class="form-control" id="editRole" name="role">
                                <option value="STAFF">Staff</option>
                                <option value="ADMIN">Admin</option>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label for="editPassword" class="form-label">New Password (leave blank to keep current)</label>
                            <input type="password" class="form-control" id="editPassword" name="password">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Update User</button>
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
        
        function editUser(userId, email, fullName, phone, role) {
            document.getElementById('editUserId').value = userId;
            document.getElementById('editEmail').value = email;
            document.getElementById('editFullName').value = fullName;
            document.getElementById('editPhone').value = phone;
            document.getElementById('editRole').value = role;
            
            new bootstrap.Modal(document.getElementById('editModal')).show();
        }
    </script>
</body>
</html>
