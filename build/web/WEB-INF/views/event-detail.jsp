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
     
     <!-- Favicon -->
     <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/favicon.ico">
     <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/favicon-32x32.png">
     <link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/favicon-16x16.png">
     <link rel="icon" type="image/png" sizes="96x96" href="${pageContext.request.contextPath}/favicon-96x96.png">
     
     <!-- Apple Touch Icons -->
     <link rel="apple-touch-icon" sizes="57x57" href="${pageContext.request.contextPath}/apple-icon-57x57.png">
     <link rel="apple-touch-icon" sizes="60x60" href="${pageContext.request.contextPath}/apple-icon-60x60.png">
     <link rel="apple-touch-icon" sizes="72x72" href="${pageContext.request.contextPath}/apple-icon-72x72.png">
     <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/apple-icon-76x76.png">
     <link rel="apple-touch-icon" sizes="114x114" href="${pageContext.request.contextPath}/apple-icon-114x114.png">
     <link rel="apple-touch-icon" sizes="120x120" href="${pageContext.request.contextPath}/apple-icon-120x120.png">
     <link rel="apple-touch-icon" sizes="144x144" href="${pageContext.request.contextPath}/apple-icon-144x144.png">
     <link rel="apple-touch-icon" sizes="152x152" href="${pageContext.request.contextPath}/apple-icon-152x152.png">
     <link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/apple-icon-180x180.png">
     <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/apple-icon.png">
     
     <!-- Android Icons -->
     <link rel="icon" type="image/png" sizes="192x192" href="${pageContext.request.contextPath}/android-icon-192x192.png">
     <link rel="icon" type="image/png" sizes="144x144" href="${pageContext.request.contextPath}/android-icon-144x144.png">
     <link rel="icon" type="image/png" sizes="96x96" href="${pageContext.request.contextPath}/android-icon-96x96.png">
     <link rel="icon" type="image/png" sizes="72x72" href="${pageContext.request.contextPath}/android-icon-72x72.png">
     <link rel="icon" type="image/png" sizes="48x48" href="${pageContext.request.contextPath}/android-icon-48x48.png">
     <link rel="icon" type="image/png" sizes="36x36" href="${pageContext.request.contextPath}/android-icon-36x36.png">
     
     <!-- Microsoft Tiles -->
     <meta name="msapplication-TileColor" content="#e74c3c">
     <meta name="msapplication-TileImage" content="${pageContext.request.contextPath}/ms-icon-144x144.png">
     <meta name="msapplication-config" content="${pageContext.request.contextPath}/browserconfig.xml">
     
     <!-- Web App Manifest -->
     <link rel="manifest" href="${pageContext.request.contextPath}/manifest.json">
     
     <!-- Theme Colors -->
     <meta name="theme-color" content="#e74c3c">
     <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
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
          
          /* Back Navigation */
          .back-navigation {
              margin-bottom: 1.5rem;
          }
          
          .back-link {
              display: inline-flex;
              align-items: center;
              gap: 0.5rem;
              color: #666;
              text-decoration: none;
              font-size: 0.9rem;
              font-weight: 500;
              padding: 0.5rem 1rem;
              border: 1px solid #e9ecef;
              border-radius: 8px;
              background: white;
              transition: all 0.3s ease;
              box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
          }
          
          .back-link:hover {
              color: var(--hrc-red);
              border-color: var(--hrc-red);
              background: #fff5f5;
              transform: translateY(-1px);
              box-shadow: 0 4px 12px rgba(231, 76, 60, 0.2);
          }
          
          .back-link i {
              font-size: 1rem;
          }
         
         .event-header {
             display: flex;
             gap: 3rem;
             margin-bottom: 4rem;
             align-items: flex-start;
             background: white;
             border-radius: 16px;
             padding: 2rem;
             box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
         }
         
         .event-image-large {
             width: 450px;
             height: 320px;
             background: linear-gradient(135deg, var(--hrc-red), #c0392b);
             border-radius: 16px;
             display: flex;
             align-items: center;
             justify-content: center;
             position: relative;
             overflow: hidden;
             flex-shrink: 0;
             box-shadow: 0 8px 24px rgba(231, 76, 60, 0.3);
         }
         
         .event-image-large::before {
             content: '';
             position: absolute;
             top: 0;
             left: 0;
             right: 0;
             bottom: 0;
             background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="music" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="2" fill="white" opacity="0.2"/></pattern></defs><rect width="100" height="100" fill="url(%23music)"/></svg>');
         }
         
         .event-image-large i {
             font-size: 5rem;
             color: white;
             z-index: 2;
             position: relative;
             filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.3));
         }
         
                                       .event-info {
               flex: 1;
               display: flex;
               flex-direction: column;
               gap: 1.5rem;
               min-height: 320px; /* Changed from height to min-height */
           }
         
         .event-title-large {
             font-size: 3rem;
             font-weight: 800;
             color: var(--hrc-dark);
             margin: 0;
             line-height: 1.2;
             letter-spacing: -0.5px;
         }
         
         .event-date-large {
             font-size: 1.3rem;
             color: #555;
             margin: 0;
             display: flex;
             align-items: center;
             gap: 0.75rem;
             font-weight: 500;
         }
         
         .event-date-large i {
             color: var(--hrc-red);
             font-size: 1.2rem;
         }
         
         .event-venue-info {
             font-size: 1.2rem;
             color: #555;
             margin: 0;
             display: flex;
             align-items: center;
             gap: 0.75rem;
             font-weight: 500;
         }
         
         .event-venue-info i {
             color: var(--hrc-red);
             font-size: 1.2rem;
         }
         
         .status-badge-large {
             display: inline-block;
             padding: 0.75rem 1.5rem;
             border-radius: 25px;
             font-size: 1rem;
             font-weight: 700;
             text-transform: uppercase;
             margin: 0;
             letter-spacing: 1px;
             box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
         }
         
         .status-onsale {
             background: linear-gradient(135deg, #00d4aa, #00b894);
             color: white;
             box-shadow: 0 4px 12px rgba(0, 212, 170, 0.3);
         }
         
         .status-draft {
             background: linear-gradient(135deg, #fdcb6e, #e17055);
             color: white;
             box-shadow: 0 4px 12px rgba(253, 203, 110, 0.3);
         }
         
         .status-soldout {
             background: linear-gradient(135deg, #e74c3c, #c0392b);
             color: white;
             box-shadow: 0 4px 12px rgba(231, 76, 60, 0.3);
         }
         
         .status-closed {
             background: linear-gradient(135deg, #636e72, #2d3436);
             color: white;
             box-shadow: 0 4px 12px rgba(99, 110, 114, 0.3);
         }
         
         .status-cancelled {
             background: linear-gradient(135deg, #6c5ce7, #5f3dc4);
             color: white;
             box-shadow: 0 4px 12px rgba(108, 92, 231, 0.3);
         }
         
         .event-description-large {
             font-size: 1.2rem;
             color: #555;
             line-height: 1.7;
             margin: 0;
             font-weight: 400;
         }
         
                                                                               .event-actions-large {
                display: flex;
                flex-direction: column;
                gap: 1.5rem;
                margin: 0;
                padding-top: 1rem;
            }
         
                                                                               .add-to-cart-form {
                display: flex;
                flex-direction: column;
                gap: 1.5rem;
            }
         
                                       .ticket-selection {
               display: flex;
               flex-direction: column;
               gap: 1.5rem;
           }
         
                   .form-group {
              display: flex;
              flex-direction: column;
              gap: 0.5rem;
          }
          
          .form-group label {
              font-weight: 600;
              color: var(--hrc-dark);
              font-size: 1rem;
              margin: 0;
          }
         
         
         
         .form-select {
             padding: 0.75rem 1rem;
             border: 2px solid #e9ecef;
             border-radius: 8px;
             font-size: 1rem;
             background: white;
             transition: all 0.3s ease;
         }
         
         .form-select:focus {
             border-color: var(--hrc-red);
             box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.1);
             outline: none;
         }
        
                 .btn-primary {
             background: linear-gradient(135deg, var(--hrc-red), #c0392b);
             border: none;
             padding: 1rem 2rem;
             font-weight: 700;
             border-radius: 12px;
             transition: all 0.3s ease;
             font-size: 1.1rem;
             text-transform: uppercase;
             letter-spacing: 0.5px;
             box-shadow: 0 4px 16px rgba(231, 76, 60, 0.3);
         }
         
         .btn-primary:hover {
             background: linear-gradient(135deg, #c0392b, #a93226);
             transform: translateY(-2px);
             box-shadow: 0 8px 24px rgba(231, 76, 60, 0.4);
         }
         
         .btn-outline-secondary {
             border: 2px solid #6c757d;
             color: #6c757d;
             padding: 1rem 2rem;
             font-weight: 600;
             border-radius: 12px;
             transition: all 0.3s ease;
             font-size: 1rem;
             background: transparent;
         }
         
         .btn-outline-secondary:hover {
             background: linear-gradient(135deg, #6c757d, #5a6268);
             border-color: #6c757d;
             color: white;
             transform: translateY(-2px);
             box-shadow: 0 4px 16px rgba(108, 117, 125, 0.3);
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
         
         /* Zone Information */
         .zone-info {
             margin-top: 2rem;
             padding-top: 1.5rem;
             border-top: 1px solid #eee;
         }
         
         .zone-info h4 {
             color: var(--hrc-dark);
             font-weight: 600;
             margin-bottom: 1rem;
             display: flex;
             align-items: center;
             gap: 0.5rem;
             font-size: 1.1rem;
         }
         
         .zone-info h4 i {
             color: var(--hrc-red);
         }
         
         .zone-list {
             display: flex;
             flex-direction: column;
             gap: 0.75rem;
         }
         
         .zone-item {
             display: flex;
             justify-content: space-between;
             align-items: center;
             padding: 0.75rem 1rem;
             background: #f8f9fa;
             border: 1px solid #e9ecef;
             border-radius: 8px;
             transition: all 0.3s ease;
         }
         
         .zone-item:hover {
             background: #fff5f5;
             border-color: var(--hrc-red);
             transform: translateY(-1px);
             box-shadow: 0 2px 8px rgba(231, 76, 60, 0.1);
         }
         
         .zone-name {
             font-weight: 600;
             color: var(--hrc-dark);
             font-size: 0.95rem;
         }
         
         .zone-price {
             font-weight: 700;
             color: var(--hrc-red);
             font-size: 1rem;
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
        
                 <!-- Back Navigation -->
         <div class="back-navigation">
             <a href="${pageContext.request.contextPath}/events" class="back-link">
                 <i class="bi bi-arrow-left"></i> Quay Lại Danh Sách
             </a>
         </div>
         
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
                  
                  <!-- Zone Information -->
                  <c:if test="${not empty eventZones}">
                      <div class="zone-info">
                          <h4><i class="bi bi-ticket-perforated"></i> Khu Vực Vé</h4>
                          <div class="zone-list">
                              <c:forEach var="zone" items="${eventZones}">
                                  <div class="zone-item">
                                      <div class="zone-name">${zone.venueZoneName}</div>
                                      <div class="zone-price">${zone.price} ${zone.currency}</div>
                                  </div>
                              </c:forEach>
                          </div>
                      </div>
                  </c:if>
              </div>
         </div>
         
                   <!-- Add to Cart Section -->
          <c:if test="${sessionScope.userRole eq 'CUSTOMER'}">
              <div class="add-to-cart-section" style="margin-top: 3rem;">
                 <div class="detail-card">
                     <h3><i class="bi bi-cart-plus"></i> Đặt Vé</h3>
                     <c:if test="${not empty eventZones}">
                         <form action="${pageContext.request.contextPath}/cart" method="post" class="add-to-cart-form">
                             <input type="hidden" name="action" value="add">
                             <div class="ticket-selection">
                                 <div class="form-group">
                                     <label for="eventZoneId">Chọn khu vực:</label>
                                     <select name="eventZoneId" id="eventZoneId" class="form-select" required>
                                         <option value="">Chọn khu vực...</option>
                                         <c:forEach var="zone" items="${eventZones}">
                                             <option value="${zone.id}">
                                                 ${zone.venueZoneName} - ${zone.price} ${zone.currency}
                                             </option>
                                         </c:forEach>
                                     </select>
                                 </div>
                                 <div class="form-group">
                                     <label for="quantity">Số lượng:</label>
                                     <select name="quantity" id="quantity" class="form-select" required>
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
                     <c:if test="${empty eventZones}">
                         <div class="alert alert-warning">
                             <i class="bi bi-exclamation-triangle"></i> Chưa có thông tin vé cho sự kiện này
                         </div>
                     </c:if>
                 </div>
             </div>
         </c:if>
    </main>

    <!-- Include Footer -->
    <jsp:include page="fragments/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
