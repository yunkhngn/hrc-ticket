<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Thanh Toán - Hanoi Rock City</title>
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
        
        .checkout-title {
            text-align: center;
            margin-bottom: 3rem;
        }
        
        .checkout-title h1 {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--hrc-dark);
            margin-bottom: 0.5rem;
        }
        
        .checkout-title p {
            font-size: 1.1rem;
            color: #666;
            margin: 0;
        }
        
        /* Checkout Layout */
        .checkout-layout {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 3rem;
            align-items: start;
        }
        
        /* Order Summary */
        .order-summary-section {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 2rem;
        }
        
        .section-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--hrc-dark);
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .order-items {
            margin-bottom: 2rem;
        }
        
        .order-item {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            border: 1px solid #e9ecef;
        }
        
        .order-item h4 {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--hrc-dark);
            margin-bottom: 1rem;
        }
        
        .item-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .item-detail {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .detail-label {
            font-size: 0.9rem;
            color: #666;
            font-weight: 500;
        }
        
        .detail-value {
            font-size: 1rem;
            font-weight: 600;
            color: var(--hrc-dark);
        }
        
        .price-value {
            color: var(--hrc-red);
            font-size: 1.1rem;
        }
        
        .order-total {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
            font-size: 1rem;
        }
        
        .total-label {
            color: #666;
            font-weight: 500;
        }
        
        .total-value {
            font-weight: 600;
            color: var(--hrc-dark);
        }
        
        .final-total {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--hrc-red);
            border-top: 2px solid #e9ecef;
            padding-top: 1rem;
            margin-top: 1rem;
        }
        
        /* Promo Code Section */
        .promo-code-section {
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            border: 2px solid #e9ecef;
            margin-bottom: 2rem;
        }
        
        .promo-code-section h4 {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--hrc-dark);
            margin-bottom: 1rem;
        }
        
        .promo-form {
            display: flex;
            gap: 1rem;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .promo-input {
            flex: 1;
            padding: 0.75rem 1rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .promo-input:focus {
            border-color: var(--hrc-red);
            outline: none;
            box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.1);
        }
        
        .promo-applied {
            background: #d4edda;
            border: 1px solid #c3e6cb;
            border-radius: 8px;
            padding: 1rem;
            margin-top: 1rem;
        }
        
        .promo-applied p {
            margin: 0.5rem 0;
            color: #155724;
        }
        
        /* Payment Section */
        .payment-section {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 2rem;
        }
        
        .payment-method {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border: 1px solid #e9ecef;
        }
        
        .payment-method h4 {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--hrc-dark);
            margin-bottom: 1rem;
        }
        
        .bank-details {
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border: 1px solid #e9ecef;
        }
        
        .bank-details h5 {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--hrc-dark);
            margin-bottom: 1rem;
        }
        
        .bank-info {
            display: grid;
            gap: 0.75rem;
        }
        
        .bank-info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
        }
        
        .bank-label {
            font-weight: 600;
            color: #666;
        }
        
        .bank-value {
            font-weight: 700;
            color: var(--hrc-dark);
        }
        
        .amount-value {
            color: var(--hrc-red);
            font-size: 1.2rem;
        }
        
        .bank-ref-input {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            margin-top: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .bank-ref-input:focus {
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
        
        /* Checkout Actions */
        .checkout-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            flex-wrap: wrap;
        }
        
        .checkout-actions .btn {
            min-width: 150px;
            justify-content: center;
        }
        
        /* Error/Success Messages */
        .alert {
            border-radius: 8px;
            border: none;
            margin-bottom: 1.5rem;
            padding: 1rem 1.5rem;
        }
        
        .alert-danger {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
            border-left: 4px solid #dc3545;
        }
        
        .alert-success {
            background: rgba(40, 167, 69, 0.1);
            color: #28a745;
            border-left: 4px solid #28a745;
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
            
            .checkout-title h1 {
                font-size: 2rem;
            }
            
            .checkout-layout {
                grid-template-columns: 1fr;
                gap: 2rem;
            }
            
            .item-details {
                grid-template-columns: 1fr;
            }
            
            .checkout-actions {
                flex-direction: column;
                align-items: stretch;
            }
            
            .checkout-actions .btn {
                width: 100%;
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
                <h1 class="banner-title">Thanh Toán</h1>
                <p class="banner-subtitle">Hoàn tất đơn hàng của bạn</p>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="main-content">
        <div class="checkout-title">
            <h1>Thanh Toán</h1>
            <p>Xem lại đơn hàng và hoàn tất thanh toán</p>
        </div>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="bi bi-exclamation-triangle"></i> ${error}
            </div>
        </c:if>
        
        <c:if test="${not empty cartItems}">
            <div class="checkout-layout">
                <!-- Left Column - Order Summary -->
                <div class="order-summary-section">
                    <h2 class="section-title">Tóm Tắt Đơn Hàng</h2>
                    
                    <div class="order-items">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="order-item">
                                <h4>${item.eventName}</h4>
                                <div class="item-details">
                                    <div class="item-detail">
                                        <span class="detail-label">Khu Vực:</span>
                                        <span class="detail-value">${item.zoneName}</span>
                                    </div>
                                    <div class="item-detail">
                                        <span class="detail-label">Số Lượng:</span>
                                        <span class="detail-value">${item.quantity}</span>
                                    </div>
                                    <div class="item-detail">
                                        <span class="detail-label">Giá Vé:</span>
                                        <span class="detail-value price-value">
                                            <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###" /> VND
                                        </span>
                                    </div>
                                    <div class="item-detail">
                                        <span class="detail-label">Phí Dịch Vụ:</span>
                                        <span class="detail-value">
                                            <fmt:formatNumber value="${item.fee * item.quantity}" pattern="#,###" /> VND
                                        </span>
                                    </div>
                                </div>
                                <div class="item-detail">
                                    <span class="detail-label">Tổng Cộng:</span>
                                    <span class="detail-value price-value">
                                        <fmt:formatNumber value="${item.total}" pattern="#,###" /> VND
                                    </span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <div class="order-total">
                        <div class="total-row">
                            <span class="total-label">Tổng tiền vé:</span>
                            <span class="total-value">
                                <fmt:formatNumber value="${cartTotal}" pattern="#,###" /> VND
                            </span>
                        </div>
                        
                        <!-- Promo Code Section -->
                        <div class="promo-code-section">
                            <h4><i class="bi bi-tag"></i> Mã Giảm Giá</h4>
                            
                            <c:if test="${not empty promoCodeError}">
                                <div class="alert alert-danger">
                                    <i class="bi bi-exclamation-triangle"></i> ${promoCodeError}
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty promoCodeSuccess}">
                                <div class="alert alert-success">
                                    <i class="bi bi-check-circle"></i> ${promoCodeSuccess}
                                </div>
                            </c:if>
                            
                            <form action="${pageContext.request.contextPath}/checkout" method="post" class="promo-form">
                                <input type="hidden" name="action" value="applyPromoCode">
                                <input type="text" name="promoCode" placeholder="Nhập mã giảm giá" 
                                       value="${appliedPromoCode}" class="promo-input">
                                <button type="submit" class="btn btn-success">
                                    <i class="bi bi-check"></i> Áp Dụng
                                </button>
                            </form>
                            
                            <c:if test="${not empty appliedPromoCode}">
                                <div class="promo-applied">
                                    <p><strong>Mã đã áp dụng:</strong> ${appliedPromoCode}</p>
                                    <p><strong>Giảm giá:</strong> <fmt:formatNumber value="${discountAmount}" pattern="#,###" /> VND</p>
                                    <form action="${pageContext.request.contextPath}/checkout" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="removePromoCode">
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            <i class="bi bi-x"></i> Xóa
                                        </button>
                                    </form>
                                </div>
                            </c:if>
                        </div>
                        
                        <div class="total-row final-total">
                            <span class="total-label">Tổng Cộng:</span>
                            <span class="total-value">
                                <fmt:formatNumber value="${finalTotal}" pattern="#,###" /> VND
                            </span>
                        </div>
                    </div>
                </div>
                
                <!-- Right Column - Payment Information -->
                <div class="payment-section">
                    <h2 class="section-title">Thông Tin Thanh Toán</h2>
                    
                    <form action="${pageContext.request.contextPath}/checkout" method="post">
                        <div class="payment-method">
                            <h4><i class="bi bi-bank"></i> Phương Thức Thanh Toán</h4>
                            <p><strong>Chuyển Khoản Ngân Hàng</strong></p>
                        </div>
                        
                        <div class="bank-details">
                            <h5><i class="bi bi-info-circle"></i> Thông Tin Tài Khoản</h5>
                            <div class="bank-info">
                                <div class="bank-info-row">
                                    <span class="bank-label">Ngân hàng:</span>
                                    <span class="bank-value">Vietcombank</span>
                                </div>
                                <div class="bank-info-row">
                                    <span class="bank-label">Số tài khoản:</span>
                                    <span class="bank-value">1234567890</span>
                                </div>
                                <div class="bank-info-row">
                                    <span class="bank-label">Tên tài khoản:</span>
                                    <span class="bank-value">Hanoi Rock Concert</span>
                                </div>
                                <div class="bank-info-row">
                                    <span class="bank-label">Số tiền:</span>
                                    <span class="bank-value amount-value">
                                        <fmt:formatNumber value="${finalTotal}" pattern="#,###" /> VND
                                    </span>
                                </div>
                            </div>
                            
                            <div style="margin-top: 1.5rem;">
                                <label for="bankRef" style="font-weight: 600; color: var(--hrc-dark);">
                                    <i class="bi bi-receipt"></i> Mã Tham Chiếu Chuyển Khoản:
                                </label>
                                <input type="text" id="bankRef" name="bankRef" 
                                       placeholder="Nhập mã tham chiếu từ ngân hàng" 
                                       class="bank-ref-input" required>
                                <small style="color: #666; margin-top: 0.5rem; display: block;">
                                    Vui lòng nhập mã tham chiếu sau khi hoàn tất chuyển khoản
                                </small>
                            </div>
                        </div>
                        
                        <div class="checkout-actions">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-circle"></i> Đặt Hàng
                            </button>
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-secondary">
                                <i class="bi bi-arrow-left"></i> Quay Lại Giỏ Hàng
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </c:if>
        
        <div style="text-align: center; margin-top: 2rem;">
            <a href="${pageContext.request.contextPath}/events" class="btn btn-secondary">
                <i class="bi bi-house"></i> Về Trang Chủ
            </a>
        </div>
    </main>

    <!-- Include Footer -->
    <jsp:include page="fragments/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>