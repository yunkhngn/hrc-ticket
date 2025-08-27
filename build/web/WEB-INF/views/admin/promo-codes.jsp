<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Promo Codes Management - HRC Admin</title>
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
        
        .promo-card {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border-left: 4px solid var(--hrc-red);
            transition: all 0.3s ease;
        }
        
        .promo-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        }
        
        .promo-code {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--hrc-red);
            margin-bottom: 1rem;
            font-family: 'Courier New', monospace;
            letter-spacing: 2px;
        }
        
        .promo-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
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
        
        .discount-badge {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 1rem;
            font-weight: 700;
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }
        
        .type-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
        }
        
        .type-percentage {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
        }
        
        .type-fixed {
            background: linear-gradient(135deg, #6f42c1, #5a32a3);
            color: white;
        }
        
        .promo-actions {
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
            .promo-info {
                grid-template-columns: 1fr;
            }
            
            .promo-actions {
                flex-direction: column;
            }
            
            .promo-actions .btn {
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
            <h1><i class="bi bi-tag"></i> Promo Codes Management</h1>
            <p>Manage promotional codes and discounts</p>
        </div>
    </div>
    
    <div class="container" style="margin-bottom: 100px;">
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
            <i class="bi bi-plus-circle"></i> Create New Promo Code
        </button>
    
        <!-- Promo Codes List -->
        <c:if test="${not empty promoCodes}">
            <div class="row">
                <c:forEach var="promoCode" items="${promoCodes}">
                    <div class="col-12">
                        <div class="promo-card">
                            <div class="promo-code">${promoCode.code}</div>
                            
                            <div class="promo-info">
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="bi bi-tag"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-label">Discount Type</div>
                                        <div class="info-value">
                                            <span class="type-badge ${promoCode.discountType eq 'PERCENTAGE' ? 'type-percentage' : 'type-fixed'}">
                                                ${promoCode.discountType}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="bi bi-percent"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-label">Discount Value</div>
                                        <div class="info-value">
                                            <span class="discount-badge">
                                                <c:choose>
                                                    <c:when test="${promoCode.discountType eq 'PERCENTAGE'}">
                                                        ${promoCode.discountValue}%
                                                    </c:when>
                                                    <c:otherwise>
                                                        $${promoCode.discountValue}
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="bi bi-people"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-label">Max Uses</div>
                                        <div class="info-value">${promoCode.maxUses != null ? promoCode.maxUses : 'Unlimited'}</div>
                                    </div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="bi bi-person-check"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-label">Per Customer Limit</div>
                                        <div class="info-value">${promoCode.perCustomerLimit != null ? promoCode.perCustomerLimit : 'Unlimited'}</div>
                                    </div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="bi bi-currency-dollar"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-label">Min Order Amount</div>
                                        <div class="info-value">${promoCode.minOrderAmount != null ? '$' : ''}${promoCode.minOrderAmount != null ? promoCode.minOrderAmount : 'No minimum'}</div>
                                    </div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="bi bi-calendar-event"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-label">Valid From</div>
                                        <div class="info-value">
                                            <c:choose>
                                                <c:when test="${promoCode.startAt != null}">
                                                    ${promoCode.startAt}
                                                </c:when>
                                                <c:otherwise>No start date</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="bi bi-calendar-x"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-label">Valid Until</div>
                                        <div class="info-value">
                                            <c:choose>
                                                <c:when test="${promoCode.endAt != null}">
                                                    ${promoCode.endAt}
                                                </c:when>
                                                <c:otherwise>No end date</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="bi bi-calendar"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-label">Created</div>
                                        <div class="info-value">
                                            <c:choose>
                                                <c:when test="${promoCode.createdAt != null}">
                                                    ${promoCode.createdAt}
                                                </c:when>
                                                <c:otherwise>Unknown</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="promo-actions">
                                <button class="btn-edit" onclick="editPromoCode(${promoCode.id}, '${promoCode.code}', '${promoCode.discountType}', ${promoCode.discountValue}, ${promoCode.maxUses}, ${promoCode.perCustomerLimit}, '${promoCode.startAt}', '${promoCode.endAt}', ${promoCode.minOrderAmount})">
                                    <i class="bi bi-pencil"></i> Edit
                                </button>
                                
                                <form action="${pageContext.request.contextPath}/admin/promo-codes" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="promoCodeId" value="${promoCode.id}">
                                    <button type="submit" class="btn-delete" onclick="return confirm('Are you sure you want to delete this promo code?')">
                                        <i class="bi bi-trash"></i> Delete
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    
        <c:if test="${empty promoCodes}">
            <div class="text-center py-5">
                <i class="bi bi-tag" style="font-size: 4rem; color: #6c757d;"></i>
                <h3 class="mt-3">No promo codes available</h3>
                <p class="text-muted">Create your first promo code to get started</p>
            </div>
        </c:if>
    </div>

    <!-- Create Promo Code Modal -->
    <div class="modal fade" id="createModal" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-plus-circle"></i> Create New Promo Code</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/promo-codes" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="create">
                        
                        <!-- Basic Information Section -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="text-primary mb-3"><i class="bi bi-info-circle"></i> Basic Information</h6>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="code" class="form-label">
                                    <i class="bi bi-tag"></i> Promo Code <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="code" name="code" required 
                                       style="text-transform: uppercase;" placeholder="Enter promo code">
                                <div class="form-text">Code will be automatically converted to uppercase</div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="discountType" class="form-label">
                                    <i class="bi bi-percent"></i> Discount Type <span class="text-danger">*</span>
                                </label>
                                <select class="form-control" id="discountType" name="discountType" required>
                                    <option value="">Select discount type</option>
                                    <option value="PERCENTAGE">Percentage (%)</option>
                                    <option value="FIXED_AMOUNT">Fixed Amount ($)</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="discountValue" class="form-label">
                                    <i class="bi bi-currency-dollar"></i> Discount Value <span class="text-danger">*</span>
                                </label>
                                <input type="number" class="form-control" id="discountValue" name="discountValue" 
                                       min="0" step="0.01" required placeholder="0.00">
                                <div class="form-text">Enter the discount amount or percentage</div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="minOrderAmount" class="form-label">
                                    <i class="bi bi-cart-check"></i> Minimum Order Amount
                                </label>
                                <input type="number" class="form-control" id="minOrderAmount" name="minOrderAmount" 
                                       min="0" step="0.01" placeholder="0.00">
                                <div class="form-text">Leave empty for no minimum requirement</div>
                            </div>
                        </div>
                        
                        <!-- Usage Limits Section -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="text-success mb-3"><i class="bi bi-shield-check"></i> Usage Limits</h6>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="maxUses" class="form-label">
                                    <i class="bi bi-people"></i> Maximum Uses
                                </label>
                                <input type="number" class="form-control" id="maxUses" name="maxUses" 
                                       min="1" placeholder="Unlimited">
                                <div class="form-text">Leave empty for unlimited uses</div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="perCustomerLimit" class="form-label">
                                    <i class="bi bi-person-check"></i> Per Customer Limit
                                </label>
                                <input type="number" class="form-control" id="perCustomerLimit" name="perCustomerLimit" 
                                       min="1" placeholder="Unlimited">
                                <div class="form-text">Leave empty for unlimited uses per customer</div>
                            </div>
                        </div>
                        
                        <!-- Validity Period Section -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="text-warning mb-3"><i class="bi bi-calendar-range"></i> Validity Period</h6>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="startAt" class="form-label">
                                    <i class="bi bi-calendar-event"></i> Valid From
                                </label>
                                <input type="datetime-local" class="form-control" id="startAt" name="startAt">
                                <div class="form-text">Leave empty to start immediately</div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="endAt" class="form-label">
                                    <i class="bi bi-calendar-x"></i> Valid Until
                                </label>
                                <input type="datetime-local" class="form-control" id="endAt" name="endAt">
                                <div class="form-text">Leave empty for no expiration</div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle"></i> Cancel
                        </button>
                        <button type="submit" class="btn btn-success">
                            <i class="bi bi-check-circle"></i> Create Promo Code
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Edit Promo Code Modal -->
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-pencil"></i> Edit Promo Code</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/promo-codes" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" id="editPromoCodeId" name="promoCodeId">
                        
                        <!-- Basic Information Section -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="text-primary mb-3"><i class="bi bi-info-circle"></i> Basic Information</h6>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="editCode" class="form-label">
                                    <i class="bi bi-tag"></i> Promo Code <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="editCode" name="code" required 
                                       style="text-transform: uppercase;" placeholder="Enter promo code">
                                <div class="form-text">Code will be automatically converted to uppercase</div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="editDiscountType" class="form-label">
                                    <i class="bi bi-percent"></i> Discount Type <span class="text-danger">*</span>
                                </label>
                                <select class="form-control" id="editDiscountType" name="discountType" required>
                                    <option value="">Select discount type</option>
                                    <option value="PERCENTAGE">Percentage (%)</option>
                                    <option value="FIXED_AMOUNT">Fixed Amount ($)</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="editDiscountValue" class="form-label">
                                    <i class="bi bi-currency-dollar"></i> Discount Value <span class="text-danger">*</span>
                                </label>
                                <input type="number" class="form-control" id="editDiscountValue" name="discountValue" 
                                       min="0" step="0.01" required placeholder="0.00">
                                <div class="form-text">Enter the discount amount or percentage</div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="editMinOrderAmount" class="form-label">
                                    <i class="bi bi-cart-check"></i> Minimum Order Amount
                                </label>
                                <input type="number" class="form-control" id="editMinOrderAmount" name="minOrderAmount" 
                                       min="0" step="0.01" placeholder="0.00">
                                <div class="form-text">Leave empty for no minimum requirement</div>
                            </div>
                        </div>
                        
                        <!-- Usage Limits Section -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="text-success mb-3"><i class="bi bi-shield-check"></i> Usage Limits</h6>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="editMaxUses" class="form-label">
                                    <i class="bi bi-people"></i> Maximum Uses
                                </label>
                                <input type="number" class="form-control" id="editMaxUses" name="maxUses" 
                                       min="1" placeholder="Unlimited">
                                <div class="form-text">Leave empty for unlimited uses</div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="editPerCustomerLimit" class="form-label">
                                    <i class="bi bi-person-check"></i> Per Customer Limit
                                </label>
                                <input type="number" class="form-control" id="editPerCustomerLimit" name="perCustomerLimit" 
                                       min="1" placeholder="Unlimited">
                                <div class="form-text">Leave empty for unlimited uses per customer</div>
                            </div>
                        </div>
                        
                        <!-- Validity Period Section -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="text-warning mb-3"><i class="bi bi-calendar-range"></i> Validity Period</h6>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="editStartAt" class="form-label">
                                    <i class="bi bi-calendar-event"></i> Valid From
                                </label>
                                <input type="datetime-local" class="form-control" id="editStartAt" name="startAt">
                                <div class="form-text">Leave empty to start immediately</div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="editEndAt" class="form-label">
                                    <i class="bi bi-calendar-x"></i> Valid Until
                                </label>
                                <input type="datetime-local" class="form-control" id="editEndAt" name="endAt">
                                <div class="form-text">Leave empty for no expiration</div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle"></i> Cancel
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle"></i> Update Promo Code
                        </button>
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
            
            new bootstrap.Modal(document.getElementById('editModal')).show();
        }
    </script>
</body>
</html>
