<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Giỏ Hàng - Hanoi Rock City</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
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
            --hrc-gray: #2c2c2c;
            --hrc-light-gray: #f8f9fa;
        }
        
        body {
            background-color: #f8f9fa;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
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
        
        .nav-links {
            display: flex;
            gap: 2rem;
            list-style: none;
            margin: 0;
            padding: 0;
        }
        
        .nav-links a {
            color: white;
            text-decoration: none;
            text-transform: uppercase;
            font-size: 0.9rem;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        
        .nav-links a:hover {
            color: var(--hrc-red);
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
        
        .user-link.logout {
            background: linear-gradient(135deg, var(--hrc-red), #c0392b);
            border: 2px solid var(--hrc-red);
            box-shadow: 0 4px 12px rgba(231, 76, 60, 0.3);
        }
        
        .user-link.logout:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(231, 76, 60, 0.4);
        }
        
        .user-link i {
            font-size: 1rem;
        }
        
        /* Banner Section */
        .banner-section {
            background: linear-gradient(135deg, var(--hrc-red), #c0392b);
            color: white;
            padding: 3rem 0;
            position: relative;
            overflow: hidden;
        }
        
        .banner-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            position: relative;
            z-index: 2;
        }
        
        .banner-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.3;
            z-index: 1;
        }
        
        .banner-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(231, 76, 60, 0.8), rgba(26, 26, 26, 0.9));
            z-index: 1;
        }
        
        .banner-content {
            text-align: center;
            position: relative;
            z-index: 2;
        }
        
        .banner-title {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        
        .banner-subtitle {
            font-size: 1.2rem;
            opacity: 0.9;
            margin-bottom: 0;
        }
        
        /* Main Content */
        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 3rem 2rem;
        }
        
        .cart-title {
            text-align: center;
            margin-bottom: 3rem;
        }
        
        .cart-title h1 {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--hrc-dark);
            margin-bottom: 0.5rem;
        }
        
        .cart-title p {
            font-size: 1.1rem;
            color: #666;
            margin: 0;
        }
        
        /* Cart Layout */
        .cart-layout {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            align-items: start;
        }
        
        .cart-items-column {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 2rem;
        }
        
        .column-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--hrc-dark);
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f0f0f0;
        }
        
        /* Cart Items */
        .cart-items {
            margin-bottom: 0;
        }
        
        .cart-item {
            background: #f8f9fa;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 1.5rem;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
            border: 1px solid #e9ecef;
        }
        
        .cart-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border-color: var(--hrc-red);
        }
        
        .cart-item-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
        }
        
        .event-info h3 {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--hrc-dark);
            margin-bottom: 0.5rem;
        }
        
        .event-meta {
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
            margin-bottom: 1.5rem;
        }
        
        .meta-item {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }
        
        .meta-label {
            font-size: 0.9rem;
            color: #666;
            font-weight: 500;
        }
        
        .meta-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--hrc-dark);
        }
        
        .price-value {
            color: var(--hrc-red);
            font-size: 1.2rem;
        }
        
        .cart-item-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .quantity-input {
            width: 80px;
            padding: 0.5rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            text-align: center;
            font-weight: 600;
        }
        
        .quantity-input:focus {
            border-color: var(--hrc-red);
            outline: none;
            box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.1);
        }
        
        /* Buttons */
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
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
            background: linear-gradient(135deg, var(--hrc-red), #c0392b);
            color: white;
            box-shadow: 0 4px 12px rgba(231, 76, 60, 0.3);
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(231, 76, 60, 0.4);
            color: white;
        }
        
        .btn-secondary {
            background: var(--hrc-dark);
            color: white;
        }
        
        .btn-secondary:hover {
            background: #343a40;
            transform: translateY(-2px);
            color: white;
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .btn-danger:hover {
            background: #c82333;
            transform: translateY(-2px);
            color: white;
        }
        
        .btn-success {
            background: var(--hrc-red);
            color: white;
        }
        
        .btn-success:hover {
            background: #c0392b;
            transform: translateY(-2px);
            color: white;
        }
        
        /* Cart Summary Column */
        .cart-summary-column {
            position: sticky;
            top: 120px;
        }
        
        .cart-summary {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            text-align: center;
        }
        
        .cart-summary h3 {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--hrc-dark);
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f0f0f0;
        }
        
        /* Summary Details */
        .summary-details {
            margin-bottom: 2rem;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem 0;
            font-size: 1rem;
        }
        
        .summary-label {
            color: #666;
            font-weight: 500;
        }
        
        .summary-value {
            font-weight: 600;
            color: var(--hrc-dark);
        }
        
        .summary-divider {
            height: 1px;
            background: #e9ecef;
            margin: 1rem 0;
        }
        
        .total-row {
            font-size: 1.2rem;
            font-weight: 700;
            padding: 1rem 0;
            border-top: 2px solid #f0f0f0;
            margin-top: 1rem;
        }
        
        .total-value {
            color: var(--hrc-red);
            font-size: 1.4rem;
        }
        
        .summary-actions {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        
        .summary-actions .btn {
            width: 100%;
            justify-content: center;
        }
        
        /* Empty Cart */
        .empty-cart {
            text-align: center;
            padding: 4rem 2rem;
        }
        
        .empty-cart-icon {
            font-size: 4rem;
            color: #ccc;
            margin-bottom: 2rem;
        }
        
        .empty-cart h3 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--hrc-dark);
            margin-bottom: 1rem;
        }
        
        .empty-cart p {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 2rem;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 1rem;
            }
            
            .nav-links {
                gap: 1rem;
            }
            
            .banner-title {
                font-size: 2rem;
            }
            
            .cart-title h1 {
                font-size: 2rem;
            }
            
            .cart-layout {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            
            .cart-summary-column {
                position: static;
                order: -1;
            }
            
            .event-meta {
                flex-direction: column;
                gap: 1rem;
            }
            
            .cart-item-actions {
                flex-direction: column;
                align-items: stretch;
            }
            
            .summary-actions {
                flex-direction: column;
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
                            <a href="${pageContext.request.contextPath}/logout" class="user-link logout">
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
        <img src="${pageContext.request.contextPath}/img/HRC-banner.jpg" alt="Hanoi Rock City Banner" class="banner-image">
        <div class="banner-overlay"></div>
        <div class="banner-container">
            <div class="banner-content">
                <h1 class="banner-title">Giỏ Hàng</h1>
                <p class="banner-subtitle">Quản lý vé của bạn</p>
        </div>
    </div>
    </section>

    <!-- Main Content -->
    <main class="main-content">
        <div class="cart-title">
            <h1>Giỏ Hàng Của Bạn</h1>
            <p>Xem lại và chỉnh sửa vé đã chọn</p>
        </div>
            
            <c:if test="${not empty cartItems}">
            <div class="cart-layout">
                <!-- Left Column - Cart Items -->
                <div class="cart-items-column">
                    <h2 class="column-title">Giỏ Hàng Của Bạn</h2>
                    <div class="cart-items">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="cart-item">
                                <div class="cart-item-header">
                                    <div class="event-info">
                                        <h3>${item.eventName}</h3>
                                <div class="event-meta">
                                            <div class="meta-item">
                                                <span class="meta-label">Khu Vực</span>
                                                <span class="meta-value">${item.zoneName}</span>
                                            </div>
                                            <div class="meta-item">
                                                <span class="meta-label">Số Lượng</span>
                                                <span class="meta-value">${item.quantity}</span>
                                            </div>
                                                                                         <div class="meta-item">
                                                 <span class="meta-label">Giá Vé (x${item.quantity})</span>
                                                 <span class="meta-value price-value">
                                                     <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###" /> VND
                                                 </span>
                                             </div>
                                             <div class="meta-item">
                                                 <span class="meta-label">Phí Dịch Vụ (x${item.quantity})</span>
                                                 <span class="meta-value">
                                                     <fmt:formatNumber value="${item.fee * item.quantity}" pattern="#,###" /> VND
                                                 </span>
                                    </div>
                                            <div class="meta-item">
                                                <span class="meta-label">Tổng Cộng</span>
                                                <span class="meta-value price-value">
                                                    <fmt:formatNumber value="${item.total}" pattern="#,###" /> VND
                                                </span>
                                    </div>
                                    </div>
                                    </div>
                                </div>
                                
                                <div class="cart-item-actions">
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display: flex; gap: 1rem; align-items: center;">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="eventZoneId" value="${item.eventZoneId}">
                                        <div class="quantity-control">
                                            <label for="quantity-${item.eventZoneId}" style="font-weight: 600; color: var(--hrc-dark);">Số lượng:</label>
                                            <input type="number" id="quantity-${item.eventZoneId}" name="quantity" value="${item.quantity}" min="1" max="10" class="quantity-input">
                                        </div>
                                        <button type="submit" class="btn btn-secondary">
                                            <i class="bi bi-arrow-clockwise"></i> Cập Nhật
                                        </button>
                                    </form>
                                    
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="eventZoneId" value="${item.eventZoneId}">
                                        <button type="submit" class="btn btn-danger">
                                            <i class="bi bi-trash"></i> Xóa
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                
                <!-- Right Column - Cart Summary -->
                <div class="cart-summary-column">
                    <div class="cart-summary">
                        <h3>Tổng Kết Giỏ Hàng</h3>
                        
                        <div class="summary-details">
                            <c:set var="subtotal" value="0" />
                            <c:set var="totalFees" value="0" />
                            <c:forEach var="item" items="${cartItems}">
                                <c:set var="subtotal" value="${subtotal + (item.price * item.quantity)}" />
                                <c:set var="totalFees" value="${totalFees + (item.fee * item.quantity)}" />
                            </c:forEach>
                            
                            <div class="summary-row">
                                <span class="summary-label">Tổng tiền vé:</span>
                                <span class="summary-value">
                                    <fmt:formatNumber value="${subtotal}" pattern="#,###" /> VND
                                </span>
                            </div>
                            <div class="summary-row">
                                <span class="summary-label">Tổng phí dịch vụ:</span>
                                <span class="summary-value">
                                    <fmt:formatNumber value="${totalFees}" pattern="#,###" /> VND
                                </span>
                            </div>
                            <div class="summary-divider"></div>
                            <div class="summary-row total-row">
                                <span class="summary-label">Tổng cộng:</span>
                                <span class="summary-value total-value">
                                    <fmt:formatNumber value="${subtotal + totalFees}" pattern="#,###" /> VND
                                </span>
                            </div>
                        </div>
                        
                        <div class="summary-actions">
                            <a href="${pageContext.request.contextPath}/events" class="btn btn-secondary">
                                <i class="bi bi-arrow-left"></i> Tiếp Tục Mua Sắm
                            </a>
                            <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success">
                                <i class="bi bi-credit-card"></i> Thanh Toán
                            </a>
                        </div>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${empty cartItems}">
            <div class="empty-cart">
                <div class="empty-cart-icon">
                    <i class="bi bi-cart-x"></i>
                    </div>
                <h3>Giỏ Hàng Trống</h3>
                <p>Bạn chưa thêm vé nào vào giỏ hàng.</p>
                <a href="${pageContext.request.contextPath}/events" class="btn btn-primary">
                    <i class="bi bi-music-note-beamed"></i> Xem Các Sự Kiện
                </a>
                </div>
            </c:if>
    </main>

    <!-- Include Footer -->
    <jsp:include page="fragments/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
