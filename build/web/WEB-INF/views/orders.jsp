<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đơn Hàng Của Tôi - HRC</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    
    <!-- Favicon -->
    <link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/favicon/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/favicon/favicon-16x16.png">
    <link rel="manifest" href="${pageContext.request.contextPath}/favicon/manifest.json">
    <link rel="mask-icon" href="${pageContext.request.contextPath}/favicon/safari-pinned-tab.svg" color="#e74c3c">
    <meta name="msapplication-TileColor" content="#e74c3c">
    <meta name="theme-color" content="#e74c3c">
    
    <style>
        :root {
            --hrc-red: #e74c3c;
            --hrc-dark: #1a1a1a;
            --hrc-light: #f8f9fa;
            --hrc-gray: #6c757d;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--hrc-light);
            margin: 0;
            padding: 0;
        }
        
                 /* Header Styles */
         .header {
             background-color: black;
             color: white;
             padding: 1rem 0;
             position: sticky;
             top: 0;
             z-index: 1000;
         }
         
         .header-content {
             display: flex;
             align-items: center;
             justify-content: space-between;
             max-width: 1200px;
             margin: 0 auto;
             padding: 0 2rem;
         }
         
         .logo-section {
             display: flex;
             align-items: center;
             gap: 1rem;
         }
         
         .logo {
             font-size: 2rem;
             font-weight: bold;
             color: white;
             text-decoration: none;
         }
         
         .logo-image {
             height: 40px;
             width: auto;
             max-width: 120px;
         }
         
         .logo-text {
             font-size: 0.9rem;
             text-transform: uppercase;
             letter-spacing: 1px;
         }
         
         /* Header Actions Styles */
         .header-actions {
             display: flex;
             align-items: center;
             gap: 1.5rem;
         }
         
         .auth-links {
             display: flex;
             gap: 1rem;
             align-items: center;
         }
         
         .auth-link {
             color: white;
             text-decoration: none;
             text-transform: uppercase;
             font-size: 0.9rem;
             font-weight: 600;
             padding: 0.75rem 1.5rem;
             border-radius: 8px;
             transition: all 0.3s ease;
             display: inline-block;
             min-width: 120px;
             text-align: center;
         }
         
         .auth-link.login {
             background: linear-gradient(135deg, var(--hrc-red), #c0392b);
             border: 2px solid var(--hrc-red);
             box-shadow: 0 4px 12px rgba(231, 76, 60, 0.3);
         }
         
         .auth-link.login:hover {
             background: linear-gradient(135deg, #c0392b, #a93226);
             transform: translateY(-2px);
             box-shadow: 0 6px 16px rgba(231, 76, 60, 0.4);
         }
         
         .auth-link.register {
             background: transparent;
             border: 2px solid transparent;
             color: white;
         }
         
         .auth-link.register:hover {
             background: rgba(255, 255, 255, 0.1);
             border-color: rgba(255, 255, 255, 0.3);
             transform: translateY(-1px);
         }
         
         .user-menu {
             display: flex;
             gap: 1rem;
             align-items: center;
         }
        
                 .user-link {
             color: white;
             text-decoration: none;
             text-transform: uppercase;
             font-size: 0.8rem;
             font-weight: 500;
             padding: 0.5rem 0.75rem;
             border-radius: 4px;
             transition: all 0.3s ease;
             display: flex;
             align-items: center;
             gap: 0.5rem;
         }
         
         .user-link:hover {
             background-color: var(--hrc-red);
             color: white;
         }
         
         .user-link i {
             font-size: 1rem;
         }
        
        /* Banner Section */
        .banner-section {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), 
                        url('${pageContext.request.contextPath}/img/HRC-banner.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: white;
            padding: 4rem 0;
            text-align: center;
        }
        
        .banner-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }
        
        .banner-title {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        
        .banner-subtitle {
            font-size: 1.2rem;
            opacity: 0.9;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
        }
        
        /* Main Content */
        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 3rem 1rem;
        }
        
        .page-title {
            color: var(--hrc-dark);
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 2rem;
            text-align: center;
        }
        
        .alert {
            border-radius: 12px;
            padding: 1rem 1.5rem;
            margin-bottom: 2rem;
            border: none;
            font-weight: 500;
        }
        
        .alert-success {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
            border-left: 4px solid #28a745;
        }
        
        .alert-danger {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
            border-left: 4px solid #dc3545;
        }
        
        .orders-grid {
            display: grid;
            gap: 2rem;
            margin-bottom: 3rem;
        }
        
                 .order-card {
             background: white;
             border-radius: 12px;
             box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
             overflow: hidden;
             transition: all 0.3s ease;
             border: 1px solid #f0f0f0;
         }
         
         .order-card:hover {
             transform: translateY(-2px);
             box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
         }
         
         .order-header {
             background: var(--hrc-red);
             color: white;
             padding: 1.25rem 1.5rem;
             display: flex;
             justify-content: space-between;
             align-items: center;
             flex-wrap: wrap;
             gap: 1rem;
         }
         
         .order-number {
             font-size: 1.3rem;
             font-weight: 700;
         }
         
         .order-date {
             font-size: 0.85rem;
             opacity: 0.9;
         }
         
         .order-body {
             padding: 1.5rem;
         }
         
         .order-info {
             display: table;
             width: 100%;
             margin-bottom: 1.5rem;
             border-collapse: collapse;
         }
         
         .info-item {
             display: table-row;
         }
         
         .info-label {
             display: table-cell;
             font-size: 0.9rem;
             color: #666;
             font-weight: 500;
             padding: 0.5rem 0;
             padding-right: 1rem;
             vertical-align: top;
             width: 30%;
         }
         
         .info-value {
             display: table-cell;
             font-weight: 600;
             color: var(--hrc-dark);
             padding: 0.5rem 0;
             vertical-align: top;
         }
         
         .price-value {
             color: var(--hrc-red);
             font-weight: 700;
             font-size: 1.1rem;
         }
        
                 .status-badge {
             display: inline-flex;
             align-items: center;
             gap: 0.5rem;
             padding: 0.75rem 1.25rem;
             border-radius: 25px;
             font-weight: 700;
             font-size: 0.9rem;
             text-align: center;
             text-transform: uppercase;
             letter-spacing: 0.5px;
             box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
             border: 2px solid transparent;
             position: relative;
             overflow: hidden;
         }
         
         .status-badge::before {
             content: '';
             position: absolute;
             top: 0;
             left: -100%;
             width: 100%;
             height: 100%;
             background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
             transition: left 0.5s;
         }
         
         .status-badge:hover::before {
             left: 100%;
         }
         
         .status-pending {
             background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
             color: white;
             border-color: #d68910;
         }
         
         .status-confirmed {
             background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
             color: white;
             border-color: #229954;
         }
         
         .status-cancelled {
             background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
             color: white;
             border-color: #c0392b;
         }
        
                 .order-actions {
             display: flex;
             gap: 0.75rem;
             justify-content: flex-end;
             flex-wrap: wrap;
             margin-top: 1rem;
             padding-top: 1rem;
             border-top: 1px solid #f0f0f0;
         }
        
                 .btn {
             padding: 0.6rem 1.2rem;
             border-radius: 6px;
             font-weight: 600;
             font-size: 0.9rem;
             text-decoration: none;
             transition: all 0.3s ease;
             border: none;
             cursor: pointer;
             display: inline-flex;
             align-items: center;
             gap: 0.5rem;
         }
         
         .btn-primary {
             background: var(--hrc-red);
             color: white;
         }
         
         .btn-primary:hover {
             background: #c0392b;
             transform: translateY(-1px);
             color: white;
         }
         
         .btn-secondary {
             background: var(--hrc-dark);
             color: white;
         }
         
         .btn-secondary:hover {
             background: #343a40;
             transform: translateY(-1px);
             color: white;
         }
         
         .btn-danger {
             background: #dc3545;
             color: white;
         }
         
         .btn-danger:hover {
             background: #c82333;
             transform: translateY(-1px);
             color: white;
         }
        
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }
        
        .empty-state i {
            font-size: 4rem;
            color: var(--hrc-gray);
            margin-bottom: 1rem;
        }
        
        .empty-state h3 {
            color: var(--hrc-dark);
            margin-bottom: 1rem;
            font-weight: 600;
        }
        
        .empty-state p {
            color: var(--hrc-gray);
            margin-bottom: 2rem;
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 3rem;
            flex-wrap: wrap;
        }
        
        @media (max-width: 768px) {
            .banner-title {
                font-size: 2rem;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .order-header {
                flex-direction: column;
                text-align: center;
            }
            
            .order-info {
                grid-template-columns: 1fr;
            }
            
            .order-actions {
                justify-content: center;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                width: 100%;
                max-width: 300px;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-content">
            <div class="logo-section">
                <a href="${pageContext.request.contextPath}/events" class="logo">
                    <img src="${pageContext.request.contextPath}/img/HRC-Logo.png" alt="Hanoi Rock City" class="logo-image">
                </a>
                <div class="logo-text">Hanoi Rock City</div>
            </div>
            
            <div class="header-actions">
                <c:choose>
                    <c:when test="${empty sessionScope.userId}">
                        <!-- Guest user - show login/register -->
                        <div class="auth-links">
                            <a href="${pageContext.request.contextPath}/login" class="auth-link login">Đăng Nhập</a>
                            <a href="${pageContext.request.contextPath}/register" class="auth-link register">Đăng Ký</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Logged in user - show user menu and orders -->
                        <div class="user-menu">
                            <c:if test="${sessionScope.userRole eq 'CUSTOMER'}">
                                <a href="${pageContext.request.contextPath}/cart" class="user-link">
                                    <i class="bi bi-cart3"></i> Giỏ Hàng
                                </a>
                                <a href="${pageContext.request.contextPath}/orders" class="user-link">
                                    <i class="bi bi-list-ul"></i> Đơn Hàng Của Tôi
                                </a>
                            </c:if>
                            <c:if test="${sessionScope.userRole eq 'ADMIN' || sessionScope.userRole eq 'STAFF'}">
                                <a href="${pageContext.request.contextPath}/admin/orders" class="user-link">
                                    <i class="bi bi-gear"></i> Quản Lý Đơn Hàng
                                </a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/logout" class="user-link">
                                <i class="bi bi-box-arrow-right"></i> Đăng Xuất
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <!-- Banner Section -->
    <section class="banner-section">
        <div class="banner-container">
            <h1 class="banner-title">Đơn Hàng Của Tôi</h1>
            <p class="banner-subtitle">Quản lý và theo dõi đơn hàng của bạn</p>
        </div>
    </section>

    <!-- Main Content -->
    <main class="main-content">
        <h1 class="page-title">Danh Sách Đơn Hàng</h1>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="bi bi-check-circle"></i> ${success}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="bi bi-exclamation-triangle"></i> ${error}
            </div>
        </c:if>
        
        <c:if test="${not empty orders}">
            <div class="orders-grid">
                <c:forEach var="order" items="${orders}">
                    <div class="order-card">
                        <div class="order-header">
                            <div>
                                <div class="order-number">Đơn Hàng #${order.id}</div>
                                                                 <div class="order-date">
                                     ${order.createdAt}
                                 </div>
                            </div>
                            <div class="status-badge 
                                <c:choose>
                                    <c:when test="${order.status eq 'PENDING'}">status-pending</c:when>
                                    <c:when test="${order.status eq 'CONFIRMED'}">status-confirmed</c:when>
                                    <c:when test="${order.status eq 'CANCELLED'}">status-cancelled</c:when>
                                </c:choose>">
                                <c:choose>
                                    <c:when test="${order.status eq 'PENDING'}">Đang Chờ</c:when>
                                    <c:when test="${order.status eq 'CONFIRMED'}">Đã Xác Nhận</c:when>
                                    <c:when test="${order.status eq 'CANCELLED'}">Đã Hủy</c:when>
                                    <c:otherwise>${order.status}</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                                                 <div class="order-body">
                             <div class="order-info">
                                 <div class="info-item">
                                     <span class="info-label">Trạng Thái Thanh Toán</span>
                                     <span class="info-value">
                                         <c:choose>
                                             <c:when test="${order.paymentStatus eq 'PENDING'}">Đang Chờ</c:when>
                                             <c:when test="${order.paymentStatus eq 'CONFIRMED'}">Đã Xác Nhận</c:when>
                                             <c:when test="${order.paymentStatus eq 'FAILED'}">Thất Bại</c:when>
                                             <c:otherwise>${order.paymentStatus}</c:otherwise>
                                         </c:choose>
                                     </span>
                                 </div>
                                 
                                 <div class="info-item">
                                     <span class="info-label">Tổng Tiền</span>
                                     <span class="info-value price-value">
                                         <fmt:formatNumber value="${order.totalAmount}" pattern="#,###" /> VND
                                     </span>
                                 </div>
                                 
                                 <div class="info-item">
                                     <span class="info-label">Phương Thức</span>
                                     <span class="info-value">
                                         <c:choose>
                                             <c:when test="${order.paymentMethod eq 'BANK'}">Chuyển Khoản</c:when>
                                             <c:otherwise>${order.paymentMethod}</c:otherwise>
                                         </c:choose>
                                     </span>
                                 </div>
                                 
                                 <c:if test="${not empty order.bankRef}">
                                     <div class="info-item">
                                         <span class="info-label">Mã Tham Chiếu</span>
                                         <span class="info-value">${order.bankRef}</span>
                                     </div>
                                 </c:if>
                             </div>
                            
                            <div class="order-actions">
                                <a href="${pageContext.request.contextPath}/order?id=${order.id}" class="btn btn-primary">
                                    <i class="bi bi-eye"></i> Xem Chi Tiết
                                </a>
                                
                                <c:if test="${order.status eq 'PENDING' and order.paymentStatus eq 'PENDING'}">
                                    <form action="${pageContext.request.contextPath}/orders" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="cancel">
                                        <input type="hidden" name="orderId" value="${order.id}">
                                        <button type="submit" class="btn btn-danger" onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')">
                                            <i class="bi bi-x-circle"></i> Hủy Đơn Hàng
                                        </button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        
        <c:if test="${empty orders}">
            <div class="empty-state">
                <i class="bi bi-inbox"></i>
                <h3>Chưa Có Đơn Hàng Nào</h3>
                <p>Bạn chưa có đơn hàng nào. Hãy khám phá các sự kiện và đặt vé ngay!</p>
            </div>
        </c:if>
        
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/events" class="btn btn-primary">
                <i class="bi bi-calendar-event"></i> Xem Sự Kiện
            </a>
            <c:if test="${sessionScope.userRole eq 'ADMIN' || sessionScope.userRole eq 'STAFF'}">
                <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-secondary">
                    <i class="bi bi-gear"></i> Quản Lý Đơn Hàng
                </a>
            </c:if>
        </div>
    </main>

    <!-- Footer -->
    <jsp:include page="fragments/footer.jsp" />

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
