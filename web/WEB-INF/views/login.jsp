<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Hanoi Rock City</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        :root {
            --hrc-red: #e74c3c;
            --hrc-dark: #1a1a1a;
            --hrc-gray: #2c2c2c;
            --hrc-light-gray: #f8f9fa;
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
        
        /* Responsive */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 1rem;
            }
            
            .nav-links {
                gap: 1rem;
            }
        }
    </style>
</head>
<body class="bg-light">
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
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card shadow">
                    <div class="card-body p-5">
                        <div class="text-center mb-4">
                            <i class="bi bi-music-note-beamed text-danger" style="font-size: 3rem;"></i>
                            <h2 class="mt-3">Welcome Back</h2>
                            <p class="text-muted">Login to your Hanoi Rock City account</p>
                        </div>
                        
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-triangle"></i> ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="bi bi-check-circle"></i> ${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        
                        <form action="${pageContext.request.contextPath}/login" method="post">
                            <div class="mb-3">
                                <label for="email" class="form-label">
                                    <i class="bi bi-envelope"></i> Email Address
                                </label>
                                <input type="email" id="email" name="email" class="form-control" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="password" class="form-label">
                                    <i class="bi bi-lock"></i> Password
                                </label>
                                <input type="password" id="password" name="password" class="form-control" required>
                            </div>
                            
                            
                            
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="bi bi-box-arrow-in-right"></i> Login
                                </button>
                            </div>
                        </form>
                        
                        <div class="text-center mt-4">
                            <p class="text-muted">Don't have an account? 
                                <a href="${pageContext.request.contextPath}/register" class="text-danger text-decoration-none">
                                    <i class="bi bi-person-plus"></i> Register
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
                
                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/events" class="btn btn-outline-secondary">
                        <i class="bi bi-music-note"></i> View Events
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-0">
                <i class="bi bi-music-note-beamed text-danger"></i> 
                Hanoi Rock City - Your Premier Rock Concert Destination
            </p>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
