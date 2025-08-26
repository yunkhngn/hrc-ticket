<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hanoi Rock City - Events</title>
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
        
        /* Search and Navigation Bar */
        .search-nav-bar {
            background-color: white;
            border-bottom: 1px solid #eee;
            padding: 1rem 0;
            position: sticky;
            top: 80px;
            z-index: 999;
        }
        
        .search-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .search-box {
            flex: 1;
            position: relative;
        }
        
        .search-input {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
        }
        
        .search-icon {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }
        
        .search-btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 4px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        
        .search-btn:hover {
            background-color: #0056b3;
        }
        
        .view-tabs {
            display: flex;
            gap: 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
        }
        
        .view-tab {
            padding: 0.75rem 1rem;
            background-color: white;
            border: none;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background-color 0.3s ease;
        }
        
        .view-tab.active {
            background-color: #333;
            color: white;
        }
        
        .view-tab:hover:not(.active) {
            background-color: #f8f9fa;
        }
        
        /* Event Navigation */
        .event-nav {
            background-color: white;
            border-bottom: 1px solid #eee;
            padding: 1rem 0;
        }
        
        .event-nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .date-nav {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .nav-arrow {
            background: none;
            border: 1px solid #ddd;
            padding: 0.5rem;
            border-radius: 4px;
            cursor: pointer;
            color: #666;
        }
        
        .today-btn {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9rem;
        }
        
        .event-filter {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 600;
            font-size: 1.1rem;
        }
        
        .filter-dropdown {
            background: none;
            border: none;
            cursor: pointer;
            font-weight: 600;
            font-size: 1.1rem;
        }
        
        /* Event List Styles */
        .event-list-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .event-list-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 2rem;
            color: #333;
        }
        
        .event-item {
            display: flex;
            gap: 2rem;
            margin-bottom: 3rem;
            padding: 1rem;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }
        
        .event-item:hover {
            background-color: #f8f9fa;
        }
        
        .event-date {
            min-width: 80px;
            text-align: center;
            padding: 1rem;
            background-color: #f8f9fa;
            border-radius: 8px;
            border: 1px solid #eee;
        }
        
        .event-month {
            font-size: 0.8rem;
            font-weight: 600;
            color: #666;
            text-transform: uppercase;
        }
        
        .event-day {
            font-size: 1.5rem;
            font-weight: 700;
            color: #333;
        }
        
        .event-year {
            font-size: 0.8rem;
            color: #666;
        }
        
        .event-details {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        
        .event-time {
            font-size: 0.9rem;
            color: #666;
        }
        
        .event-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: #333;
            margin: 0;
        }
        
        .event-venue {
            font-size: 0.9rem;
            color: #666;
        }
        
        .event-description {
            font-size: 0.9rem;
            color: #555;
            line-height: 1.5;
            margin: 0.5rem 0;
        }
        
        .event-price {
            font-size: 0.9rem;
            color: var(--hrc-red);
            font-weight: 600;
        }
        
        .event-image {
            width: 200px;
            height: 150px;
            background: linear-gradient(45deg, var(--hrc-red), #c0392b);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }
        
        .event-image::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="music" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="2" fill="white" opacity="0.3"/></pattern></defs><rect width="100" height="100" fill="url(%23music)"/></svg>');
        }
        
        .event-image i {
            font-size: 2rem;
            color: white;
            z-index: 2;
            position: relative;
        }
        
        /* Status badges */
        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            margin-left: 1rem;
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
        
        /* Alert styles */
        .alert {
            border-radius: 8px;
            border: none;
            margin-bottom: 2rem;
        }
        
        .alert-success {
            background: rgba(39, 174, 96, 0.1);
            color: #27ae60;
            border-left: 4px solid #27ae60;
        }
        
        .alert-danger {
            background: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
            border-left: 4px solid #e74c3c;
        }
        
        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background-color: #f8f9fa;
            border-radius: 8px;
            margin: 2rem 0;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #ccc;
            margin-bottom: 1rem;
        }
        
        .empty-state h3 {
            color: #666;
            margin-bottom: 0.5rem;
        }
        
        .empty-state p {
            color: #999;
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
            
            .search-container {
                flex-direction: column;
                gap: 1rem;
            }
            
            .event-nav-container {
                flex-direction: column;
                gap: 1rem;
            }
            
            .event-item {
                flex-direction: column;
                gap: 1rem;
            }
            
            .event-image {
                width: 100%;
                height: 200px;
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
                    <i class="bi bi-music-note-beamed"></i>
                </a>
                <div class="logo-text">Hanoi Rock City</div>
            </div>
            
            <nav>
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/events">Trang Chủ</a></li>
                    <li><a href="#">Về Chúng Tôi</a></li>
                    <li><a href="${pageContext.request.contextPath}/events">Sự Kiện Sắp Tới</a></li>
                    <li><a href="#">Cities in Sync</a></li>
                    <li><a href="#">Quà Lưu Niệm</a></li>
                </ul>
            </nav>
            
            <div class="language-selector">
                <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMTYiIHZpZXdCb3g9IjAgMCAyNCAxNiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3Qgd2lkdGg9IjI0IiBoZWlnaHQ9IjE2IiBmaWxsPSIjRDAwMDAwIi8+CjxwYXRoIGQ9Ik0xMiA0TDE0IDhIMTBMOCA0SDZMMTAgOEg2TDEyIDEyTDE4IDhIMTRMMTggNEgxNkwxMiA4SDEwTDEyIDRaIiBmaWxsPSIjRkZGRkZGIi8+Cjwvc3ZnPgo=" alt="Vietnamese" class="flag">
                <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMTYiIHZpZXdCb3g9IjAgMCAyNCAxNiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3Qgd2lkdGg9IjI0IiBoZWlnaHQ9IjE2IiBmaWxsPSIjMDAwMDgwIi8+CjxyZWN0IHdpZHRoPSIyNCIgaGVpZ2h0PSIxIiB5PSIzIiBmaWxsPSIjRkZGRkZGIi8+CjxyZWN0IHdpZHRoPSIyNCIgaGVpZ2h0PSIxIiB5PSI2IiBmaWxsPSIjRkZGRkZGIi8+CjxyZWN0IHdpZHRoPSIyNCIgaGVpZ2h0PSIxIiB5PSI5IiBmaWxsPSIjRkZGRkZGIi8+CjxyZWN0IHdpZHRoPSIyNCIgaGVpZ2h0PSIxIiB5PSIxMiIgZmlsbD0iI0ZGRkZGRiIvPgo8cmVjdCB3aWR0aD0iMTAiIGhlaWdodD0iOCIgZmlsbD0iIzAwMDA4MCIvPgo8ZyBmaWxsPSIjRkZGRkZGIj4KPGNpcmNsZSBjeD0iNSIgY3k9IjQiIHI9IjAuNSIvPgo8Y2lyY2xlIGN4PSI3IiBjeT0iMyIgcj0iMC41Ii8+CjxjaXJjbGUgY3g9IjkiIGN5PSI0IiByPSIwLjUiLz4KPGNpcmNsZSBjeD0iOCIgY3k9IjYiIHI9IjAuNSIvPgo8Y2lyY2xlIGN4PSI2IiBjeT0iNiIgcj0iMC41Ii8+CjwvZz4KPC9zdmc+Cg==" alt="English" class="flag">
            </div>
        </div>
    </header>

    <!-- Search and Navigation Bar -->
    <div class="search-nav-bar">
        <div class="search-container">
            <div class="search-box">
                <i class="bi bi-search search-icon"></i>
                <input type="text" class="search-input" placeholder="Tìm kiếm các sự kiện">
            </div>
            <button class="search-btn">Tìm Các sự kiện</button>
            <div class="view-tabs">
                <button class="view-tab active">Danh sách</button>
                <button class="view-tab">Tháng</button>
                <button class="view-tab">Ngày</button>
            </div>
        </div>
    </div>

    <!-- Event Navigation -->
    <div class="event-nav">
        <div class="event-nav-container">
            <div class="date-nav">
                <button class="nav-arrow">
                    <i class="bi bi-chevron-left"></i>
                </button>
                <button class="today-btn">Ngày hôm nay</button>
                <button class="nav-arrow">
                    <i class="bi bi-chevron-right"></i>
                </button>
            </div>
            <div class="event-filter">
                <span>Sắp tới</span>
                <button class="filter-dropdown">
                    <i class="bi bi-chevron-down"></i>
                </button>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <main class="event-list-container">
        <h1 class="event-list-title">Các sự kiện sắp tới</h1>
        
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
        
        <c:if test="${not empty events}">
            <c:forEach var="event" items="${events}">
                <div class="event-item">
                    <div class="event-date">
                        <div class="event-month">
                            ${event.startAt.month.toString().substring(0,3).toUpperCase()}
                        </div>
                        <div class="event-day">
                            ${event.startAt.dayOfMonth}
                        </div>
                        <div class="event-year">
                            ${event.startAt.year}
                        </div>
                    </div>
                    
                    <div class="event-details">
                        <div class="event-time">
                            ${event.startAt.month.toString().substring(0,3)} ${event.startAt.dayOfMonth} @ ${event.startAt.hour}:${event.startAt.minute < 10 ? '0' : ''}${event.startAt.minute} ${event.startAt.hour < 12 ? 'AM' : 'PM'} - 
                            ${event.endAt.hour}:${event.endAt.minute < 10 ? '0' : ''}${event.endAt.minute} ${event.endAt.hour < 12 ? 'AM' : 'PM'}
                        </div>
                        <h3 class="event-title">
                            ${event.name}
                            <span class="status-badge status-${fn:toLowerCase(event.status)}">${event.status}</span>
                        </h3>
                                                 <div class="event-venue">
                             Venue ID: ${event.venueId}
                         </div>
                        <p class="event-description">${event.description}</p>
                        <div class="event-price">
                            <c:set var="eventArtists" value="${eventArtistsMap[event.id]}" />
                            <c:if test="${not empty eventArtists}">
                                <strong>Artists:</strong> 
                                <c:forEach var="artist" items="${eventArtists}" varStatus="status">
                                    ${artist.artistName}<c:if test="${!status.last}">, </c:if>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                    
                    <div class="event-image">
                        <i class="bi bi-music-note-beamed"></i>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        
        <c:if test="${empty events}">
            <div class="empty-state">
                <i class="bi bi-music-note-beamed"></i>
                <h3>Không có sắp tới các sự kiện</h3>
                <p>Check back soon for upcoming rock concerts!</p>
            </div>
        </c:if>
    </main>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
