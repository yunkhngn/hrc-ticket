<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${event.name} - Hanoi Rock City</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root {
            --hrc-red: #e74c3c;
            --hrc-dark: #1a1a1a;
            --hrc-gray: #2c2c2c;
            --hrc-light-gray: #f8f9fa;
        }
        
        body {
            background-color: white;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
        
        .language-selector {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        
        .flag {
            width: 24px;
            height: 16px;
            cursor: pointer;
            border: 1px solid #333;
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
            font-weight: 500;
            padding: 0.5rem 1rem;
            border: 1px solid var(--hrc-red);
            border-radius: 4px;
            transition: all 0.3s ease;
        }
        
        .auth-link:hover {
            background-color: var(--hrc-red);
            color: white;
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
        
        /* Event Detail Styles */
        .event-detail-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .event-header {
            display: flex;
            gap: 2rem;
            margin-bottom: 3rem;
            align-items: flex-start;
        }
        
        .event-image-large {
            width: 400px;
            height: 300px;
            background: linear-gradient(45deg, var(--hrc-red), #c0392b);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            flex-shrink: 0;
        }
        
        .event-image-large::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="music" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="2" fill="white" opacity="0.3"/></pattern></defs><rect width="100" height="100" fill="url(%23music)"/></svg>');
        }
        
        .event-image-large i {
            font-size: 4rem;
            color: white;
            z-index: 2;
            position: relative;
        }
        
        .event-info {
            flex: 1;
        }
        
        .event-title-large {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--hrc-dark);
            margin-bottom: 1rem;
        }
        
        .event-date-large {
            font-size: 1.2rem;
            color: #666;
            margin-bottom: 1rem;
        }
        
        .event-venue-info {
            font-size: 1.1rem;
            color: #555;
            margin-bottom: 1rem;
        }
        
        .status-badge-large {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 1rem;
        }
        
        .status-onsale {
            background: #27ae60;
            color: white;
        }
        
        .status-draft {
            background: #f39c12;
            color: white;
        }
        
        .status-soldout {
            background: #e74c3c;
            color: white;
        }
        
        .status-closed {
            background: #95a5a6;
            color: white;
        }
        
        .status-cancelled {
            background: #34495e;
            color: white;
        }
        
        .event-description-large {
            font-size: 1.1rem;
            color: #555;
            line-height: 1.6;
            margin-bottom: 2rem;
        }
        
                 .event-actions-large {
             display: flex;
             gap: 1rem;
             margin-bottom: 2rem;
             flex-wrap: wrap;
         }
         
         .add-to-cart-form {
             display: flex;
             flex-direction: column;
             gap: 1rem;
             min-width: 300px;
         }
         
         .ticket-selection {
             display: flex;
             flex-direction: column;
             gap: 0.5rem;
         }
         
         .quantity-selector {
             display: flex;
             align-items: center;
             gap: 0.5rem;
         }
         
         .quantity-selector label {
             font-weight: 600;
             color: var(--hrc-dark);
             min-width: 80px;
         }
         
         .form-select {
             padding: 0.5rem;
             border: 1px solid #ddd;
             border-radius: 4px;
             font-size: 0.9rem;
         }
        
        .btn-primary {
            background-color: var(--hrc-red);
            border-color: var(--hrc-red);
            padding: 0.75rem 2rem;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background-color: #c0392b;
            border-color: #c0392b;
            transform: translateY(-2px);
        }
        
        .btn-outline-secondary {
            border-color: #666;
            color: #666;
            padding: 0.75rem 2rem;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .btn-outline-secondary:hover {
            background-color: #666;
            border-color: #666;
            color: white;
        }
        
        .event-details-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 3rem;
            margin-top: 3rem;
        }
        
        .detail-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        
        .detail-card h3 {
            color: var(--hrc-dark);
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .detail-card h3 i {
            color: var(--hrc-red);
        }
        
        .artist-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .artist-item {
            padding: 1rem;
            border: 1px solid #eee;
            border-radius: 8px;
            margin-bottom: 1rem;
            background: #f8f9fa;
        }
        
        .artist-name {
            font-weight: 600;
            color: var(--hrc-dark);
            margin-bottom: 0.5rem;
        }
        
        .artist-description {
            color: #666;
            font-size: 0.9rem;
        }
        
        .venue-info {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            border: 1px solid #eee;
        }
        
        .venue-name {
            font-weight: 600;
            color: var(--hrc-dark);
            margin-bottom: 0.5rem;
        }
        
        .venue-address {
            color: #666;
            margin-bottom: 0.5rem;
        }
        
        .venue-capacity {
            color: #666;
            font-size: 0.9rem;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 1rem;
            }
            
            .event-header {
                flex-direction: column;
                gap: 1rem;
            }
            
            .event-image-large {
                width: 100%;
                height: 250px;
            }
            
            .event-title-large {
                font-size: 2rem;
            }
            
            .event-details-section {
                grid-template-columns: 1fr;
                gap: 2rem;
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
                            <a href="${pageContext.request.contextPath}/login" class="auth-link">Đăng Nhập</a>
                            <a href="${pageContext.request.contextPath}/register" class="auth-link">Đăng Ký</a>
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
                
                <div class="language-selector">
                    <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMTYiIHZpZXdCb3g9IjAgMCAyNCAxNiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3Qgd2lkdGg9IjI0IiBoZWlnaHQ9IjE2IiBmaWxsPSIjRDAwMDAwIi8+CjxwYXRoIGQ9Ik0xMiA0TDE0IDhIMTBMOCA0SDZMMTAgOEg2TDEyIDEyTDE4IDhIMTRMMTggNEgxNkwxMiA4SDEwTDEyIDRaIiBmaWxsPSIjRkZGRkZGIi8+Cjwvc3ZnPgo=" alt="Vietnamese" class="flag">
                    <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMTYiIHZpZXdCb3g9IjAgMCAyNCAxNiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3Qgd2lkdGg9IjI0IiBoZWlnaHQ9IjE2IiBmaWxsPSIjMDAwMDgwIi8+CjxyZWN0IHdpZHRoPSIyNCIgaGVpZ2h0PSIxIiB5PSIzIiBmaWxsPSIjRkZGRkZGIi8+CjxyZWN0IHdpZHRoPSIyNCIgaGVpZ2h0PSIxIiB5PSI2IiBmaWxsPSIjRkZGRkZGIi8+CjxyZWN0IHdpZHRoPSIyNCIgaGVpZ2h0PSIxIiB5PSI5IiBmaWxsPSIjRkZGRkZGIi8+CjxyZWN0IHdpZHRoPSIyNCIgaGVpZ2h0PSIxIiB5PSIxMiIgZmlsbD0iI0ZGRkZGRiIvPgo8cmVjdCB3aWR0aD0iMTAiIGhlaWdodD0iOCIgZmlsbD0iIzAwMDA4MCIvPgo8ZyBmaWxsPSIjRkZGRkZGIj4KPGNpcmNsZSBjeD0iNSIgY3k9IjQiIHI9IjAuNSIvPgo8Y2lyY2xlIGN4PSI3IiBjeT0iMyIgcj0iMC41Ii8+CjxjaXJjbGUgY3g9IjkiIGN5PSI0IiByPSIwLjUiLz4KPGNpcmNsZSBjeD0iOCIgY3k9IjYiIHI9IjAuNSIvPgo8Y2lyY2xlIGN4PSI2IiBjeT0iNiIgcj0iMC41Ii8+CjwvZz4KPC9zdmc+Cg==" alt="English" class="flag">
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="event-detail-container">
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <div class="event-header">
            <div class="event-image-large">
                <i class="bi bi-music-note-beamed"></i>
            </div>
            
            <div class="event-info">
                <h1 class="event-title-large">${event.name}</h1>
                
                <div class="event-date-large">
                    <i class="bi bi-calendar-event"></i>
                    ${event.startAt.month.toString().substring(0,3)} ${event.startAt.dayOfMonth}, ${event.startAt.year} @ 
                    ${event.startAt.hour}:${event.startAt.minute < 10 ? '0' : ''}${event.startAt.minute} ${event.startAt.hour < 12 ? 'AM' : 'PM'} - 
                    ${event.endAt.hour}:${event.endAt.minute < 10 ? '0' : ''}${event.endAt.minute} ${event.endAt.hour < 12 ? 'AM' : 'PM'}
                </div>
                
                <c:if test="${not empty venue}">
                    <div class="event-venue-info">
                        <i class="bi bi-geo-alt"></i>
                        ${venue.name} - ${venue.address}
                    </div>
                </c:if>
                
                <span class="status-badge-large status-${fn:toLowerCase(event.status)}">${event.status}</span>
                
                <p class="event-description-large">${event.description}</p>
                
                <div class="event-actions-large">
                    <c:if test="${sessionScope.userRole eq 'CUSTOMER' && not empty eventZones}">
                        <form action="${pageContext.request.contextPath}/cart" method="post" class="add-to-cart-form">
                            <input type="hidden" name="action" value="add">
                            <div class="ticket-selection">
                                <select name="eventZoneId" class="form-select mb-2" required>
                                    <option value="">Chọn khu vực...</option>
                                    <c:forEach var="zone" items="${eventZones}">
                                        <option value="${zone.id}">
                                            ${zone.venueZoneName} - ${zone.price} ${zone.currency}
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="quantity-selector">
                                    <label for="quantity">Số lượng:</label>
                                    <select name="quantity" class="form-select" required>
                                        <option value="">Chọn số lượng...</option>
                                        <c:forEach var="i" begin="1" end="10">
                                            <option value="${i}">${i}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-cart-plus"></i> Thêm Vào Giỏ Hàng
                                </button>
                            </div>
                        </form>
                    </c:if>
                    <c:if test="${sessionScope.userRole eq 'CUSTOMER' && empty eventZones}">
                        <div class="alert alert-warning">
                            <i class="bi bi-exclamation-triangle"></i> Chưa có thông tin vé cho sự kiện này
                        </div>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/events" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left"></i> Quay Lại Danh Sách
                    </a>
                </div>
            </div>
        </div>
        
        <div class="event-details-section">
            <div class="detail-card">
                <h3><i class="bi bi-music-note-beamed"></i> Nghệ Sĩ Tham Gia</h3>
                <c:if test="${not empty eventArtists}">
                    <ul class="artist-list">
                        <c:forEach var="eventArtist" items="${eventArtists}">
                            <li class="artist-item">
                                <div class="artist-name">${eventArtist.artistName}</div>
                                                        <c:if test="${not empty eventArtist.artistCountry}">
                            <div class="artist-description">Country: ${eventArtist.artistCountry}</div>
                        </c:if>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
                <c:if test="${empty eventArtists}">
                    <p class="text-muted">Chưa có thông tin nghệ sĩ</p>
                </c:if>
            </div>
            
            <div class="detail-card">
                <h3><i class="bi bi-geo-alt"></i> Thông Tin Địa Điểm</h3>
                <c:if test="${not empty venue}">
                    <div class="venue-info">
                        <div class="venue-name">${venue.name}</div>
                        <div class="venue-address">${venue.address}</div>
                        <c:if test="${not empty venue.capacity}">
                            <div class="venue-capacity">Sức chứa: ${venue.capacity} người</div>
                        </c:if>
                    </div>
                </c:if>
                <c:if test="${empty venue}">
                    <p class="text-muted">Chưa có thông tin địa điểm</p>
                </c:if>
            </div>
        </div>
    </main>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
