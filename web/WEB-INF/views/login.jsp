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

    <!-- Include Footer -->
    <jsp:include page="fragments/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
