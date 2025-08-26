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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <style>
        :root {
            --hrc-red: #e74c3c;
            --hrc-dark: #1a1a1a;
            --hrc-gray: #2c2c2c;
            --hrc-light-gray: #f8f9fa;
        }
        
        body {
            background-image: url('${pageContext.request.contextPath}/img/HRC-banner.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-repeat: no-repeat;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(231, 76, 60, 0.6), rgba(26, 26, 26, 0.7));
            z-index: -1;
        }
        
        /* Make buttons more prominent */
        .btn {
            position: relative;
            z-index: 10;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }
        
        .btn-outline-secondary {
            background-color: rgba(255, 255, 255, 0.9) !important;
            border-color: #6c757d !important;
            color: #6c757d !important;
            backdrop-filter: blur(10px);
        }
        
        .btn-outline-secondary:hover {
            background-color: #6c757d !important;
            border-color: #6c757d !important;
            color: white !important;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.4);
        }
        
        /* Form styling */
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 1rem 1.25rem;
            transition: all 0.3s ease;
            background-color: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(5px);
            font-size: 1rem;
        }
        
        .form-control:focus {
            border-color: var(--hrc-red);
            box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.15);
            background-color: rgba(255, 255, 255, 0.95);
            outline: none;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--hrc-dark);
            margin-bottom: 0.75rem;
            font-size: 0.95rem;
        }
        
        .form-label i {
            margin-right: 0.5rem;
            color: var(--hrc-red);
        }
        
        .mb-3 {
            margin-bottom: 1.5rem !important;
        }
        
        .mb-4 {
            margin-bottom: 2rem !important;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--hrc-red), #c0392b);
            border: none;
            border-radius: 8px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(231, 76, 60, 0.3);
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(231, 76, 60, 0.4);
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
             font-size: 0.9rem;
             font-weight: 600;
             padding: 0.75rem 1.5rem;
             border-radius: 8px;
             transition: all 0.3s ease;
             display: flex;
             align-items: center;
             gap: 0.75rem;
             min-width: 140px;
             justify-content: center;
         }
         
         .user-link:hover {
             background: rgba(255, 255, 255, 0.1);
             transform: translateY(-1px);
         }
         
         .user-link i {
             font-size: 1.1rem;
         }
         
         .user-link.logout {
             background: linear-gradient(135deg, var(--hrc-red), #c0392b);
             border: 2px solid var(--hrc-red);
             box-shadow: 0 4px 12px rgba(231, 76, 60, 0.3);
             font-weight: 700;
         }
         
                 .user-link.logout:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(231, 76, 60, 0.4);
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

    <!-- Main Content -->
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="card shadow-lg" style="background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px); border: none; border-radius: 16px;">
                    <div class="card-body p-5">
                        <div class="text-center mb-4">
                            <i class="bi bi-music-note-beamed text-danger" style="font-size: 3rem;"></i>
                            <h2 class="mt-3" style="font-weight: 700; color: var(--hrc-dark);">Chào Mừng Trở Lại</h2>
                            <p class="text-muted">Đăng nhập vào tài khoản Hanoi Rock City của bạn</p>
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
                                    <i class="bi bi-envelope"></i> Địa Chỉ Email
                                </label>
                                <input type="email" id="email" name="email" class="form-control" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="password" class="form-label">
                                    <i class="bi bi-lock"></i> Mật Khẩu
                                </label>
                                <input type="password" id="password" name="password" class="form-control" required>
                            </div>
                            
                            
                            
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="bi bi-box-arrow-in-right"></i> Đăng Nhập
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
                

            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="fragments/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
