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
            width: 100%;
            height: 400px;
            position: relative;
            overflow: hidden;
        }
        
        .banner-container {
            width: 100%;
            height: 100%;
            position: relative;
        }
        
        .banner-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
        }
        
        .banner-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(231, 76, 60, 0.8), rgba(26, 26, 26, 0.9));
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .banner-content {
            text-align: center;
            color: white;
            max-width: 800px;
            padding: 0 2rem;
        }
        
        .banner-title {
            font-size: 4rem;
            font-weight: 800;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            letter-spacing: 2px;
        }
        
        .banner-subtitle {
            font-size: 1.5rem;
            font-weight: 400;
            margin: 0;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
            opacity: 0.9;
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
        }
        
        .search-form {
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
            border: 2px solid var(--hrc-red);
            border-radius: 8px;
            font-size: 1rem;
            background-color: rgba(255, 255, 255, 0.95);
            color: var(--hrc-dark);
            transition: all 0.3s ease;
        }
        
        .search-input:focus {
            outline: none;
            border-color: var(--hrc-red);
            box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.2);
            background-color: white;
        }
        
        .search-icon {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--hrc-red);
            font-size: 1.1rem;
        }
        
        .search-btn {
            background: linear-gradient(135deg, var(--hrc-red), #c0392b);
            color: white;
            border: 2px solid var(--hrc-red);
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 12px rgba(231, 76, 60, 0.3);
        }
        
        .search-btn:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(231, 76, 60, 0.4);
        }
        

        
        /* Event List Styles */
        .event-list-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .event-list-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--hrc-dark);
            margin-bottom: 2rem;
            text-align: center;
        }
        
        .clear-search-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1rem;
            color: var(--hrc-red);
            text-decoration: none;
            margin-left: 1rem;
            padding: 0.5rem 1rem;
            border: 1px solid var(--hrc-red);
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .clear-search-link:hover {
            background-color: var(--hrc-red);
            color: white;
            transform: translateY(-1px);
        }
        
        .event-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .event-row {
            display: flex;
            align-items: flex-start;
            gap: 2rem;
            padding: 1.25rem 0;
            width: 100%;
            border-bottom: 1px solid #eee;
            text-decoration: none;
            color: inherit;
            transition: background-color 0.3s ease;
        }
        
        .event-row:hover {
            background: #fafafa;
        }
        
        .event-date {
            min-width: 120px;
            flex-shrink: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }
        
        .event-date .month {
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--hrc-red);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .event-date .day {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--hrc-dark);
            line-height: 1;
        }
        
        .event-date .year {
            font-size: 0.9rem;
            color: #666;
            font-weight: 500;
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
            font-weight: 500;
        }
        
        .event-title {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--hrc-dark);
            line-height: 1.3;
            margin: 0;
        }
        
        .event-status {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            background-color: var(--hrc-red);
            color: white;
            font-size: 0.8rem;
            font-weight: 600;
            border-radius: 20px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .event-venue {
            font-size: 0.95rem;
            color: #555;
            font-weight: 500;
        }
        
        .event-description {
            color: #666;
            line-height: 1.5;
            margin: 0;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .event-artists {
            font-size: 0.9rem;
            color: #666;
            font-weight: 500;
        }
        
        .event-image {
            width: 240px;
            height: 140px;
            flex-shrink: 0;
            border-radius: 8px;
            background: linear-gradient(45deg, #e74c3c, #c0392b);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 0.9rem;
            text-align: center;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .event-row {
                flex-direction: column;
            }
            
            .event-image {
                width: 100%;
                height: 200px;
            }
            
            .event-date {
                flex-direction: row;
                gap: 0.5rem;
            }
        }
        
                 .event-venue {
             font-size: 0.95rem;
             color: #666;
             font-weight: 500;
         }
         
         .event-description {
             font-size: 0.9rem;
             color: #555;
             line-height: 1.5;
             margin: 0.5rem 0;
         }
         
         .event-artists {
             font-size: 0.9rem;
             color: var(--hrc-red);
             font-weight: 500;
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
             margin-top: 0.5rem;
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
             flex-shrink: 0;
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
             font-size: 1.5rem;
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
            background: linear-gradient(135deg, #00d4aa, #00b894);
            color: white;
            box-shadow: 0 2px 8px rgba(0, 212, 170, 0.3);
        }
        
        .status-draft {
            background: linear-gradient(135deg, #fdcb6e, #e17055);
            color: white;
            box-shadow: 0 2px 8px rgba(253, 203, 110, 0.3);
        }
        
        .status-soldout {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            box-shadow: 0 2px 8px rgba(231, 76, 60, 0.3);
        }
        
        .status-closed {
            background: linear-gradient(135deg, #636e72, #2d3436);
            color: white;
            box-shadow: 0 2px 8px rgba(99, 110, 114, 0.3);
        }
        
        .status-cancelled {
            background: linear-gradient(135deg, #6c5ce7, #5f3dc4);
            color: white;
            box-shadow: 0 2px 8px rgba(108, 92, 231, 0.3);
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
             
             .banner-section {
                 height: 300px;
             }
             
             .banner-title {
                 font-size: 2.5rem;
             }
             
             .banner-subtitle {
                 font-size: 1.2rem;
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
                 padding-bottom: 1rem;
             }
             
             .event-image {
                 width: 100%;
                 height: 200px;
             }
             
             .event-date {
                 min-width: auto;
                 flex-direction: row;
                 gap: 0.5rem;
                 align-items: center;
             }
                  }
         
         /* Footer Styles */
         .footer {
             background-color: var(--hrc-dark);
             color: white;
             margin-top: 4rem;
         }
         
         .footer-content {
             max-width: 1200px;
             margin: 0 auto;
             padding: 3rem 2rem 2rem;
             display: grid;
             grid-template-columns: 2fr 1fr 1.5fr 1.5fr;
             gap: 3rem;
         }
         
         .footer-section h4 {
             color: var(--hrc-red);
             font-size: 1.1rem;
             font-weight: 600;
             margin-bottom: 1.5rem;
             text-transform: uppercase;
             letter-spacing: 0.5px;
         }
         
         .footer-logo {
             display: flex;
             align-items: center;
             gap: 1rem;
             margin-bottom: 1rem;
         }
         
         .footer-logo-image {
             height: 40px;
             width: auto;
         }
         
         .footer-logo h3 {
             font-size: 1.5rem;
             font-weight: 700;
             margin: 0;
             color: white;
         }
         
         .footer-description {
             color: #ccc;
             line-height: 1.6;
             margin-bottom: 1.5rem;
         }
         
         .social-links {
             display: flex;
             gap: 1rem;
         }
         
         .social-link {
             display: flex;
             align-items: center;
             justify-content: center;
             width: 40px;
             height: 40px;
             background-color: #333;
             color: white;
             border-radius: 50%;
             text-decoration: none;
             transition: all 0.3s ease;
         }
         
         .social-link:hover {
             background-color: var(--hrc-red);
             color: white;
             transform: translateY(-2px);
         }
         
         .footer-links {
             list-style: none;
             padding: 0;
             margin: 0;
         }
         
         .footer-links li {
             margin-bottom: 0.75rem;
         }
         
         .footer-links a {
             color: #ccc;
             text-decoration: none;
             transition: color 0.3s ease;
         }
         
         .footer-links a:hover {
             color: var(--hrc-red);
         }
         
         .contact-info {
             display: flex;
             flex-direction: column;
             gap: 1rem;
         }
         
         .contact-item {
             display: flex;
             align-items: center;
             gap: 0.75rem;
             color: #ccc;
         }
         
         .contact-item i {
             color: var(--hrc-red);
             font-size: 1.1rem;
             min-width: 20px;
         }
         
         .newsletter-form {
             margin-top: 1rem;
         }
         
         .input-group {
             display: flex;
             gap: 0.5rem;
         }
         
         .newsletter-input {
             flex: 1;
             padding: 0.75rem 1rem;
             border: 1px solid #333;
             border-radius: 4px;
             background-color: #333;
             color: white;
             font-size: 0.9rem;
         }
         
         .newsletter-input::placeholder {
             color: #999;
         }
         
         .newsletter-input:focus {
             outline: none;
             border-color: var(--hrc-red);
         }
         
         .newsletter-btn {
             padding: 0.75rem 1rem;
             background-color: var(--hrc-red);
             color: white;
             border: none;
             border-radius: 4px;
             cursor: pointer;
             transition: background-color 0.3s ease;
         }
         
         .newsletter-btn:hover {
             background-color: #c0392b;
         }
         
         .footer-bottom {
             border-top: 1px solid #333;
             padding: 1.5rem 2rem;
         }
         
         .footer-bottom-content {
             max-width: 1200px;
             margin: 0 auto;
             display: flex;
             justify-content: space-between;
             align-items: center;
         }
         
         .footer-bottom p {
             color: #999;
             margin: 0;
         }
         
         .footer-bottom-links {
             display: flex;
             gap: 2rem;
         }
         
         .footer-bottom-links a {
             color: #999;
             text-decoration: none;
             font-size: 0.9rem;
             transition: color 0.3s ease;
         }
         
         .footer-bottom-links a:hover {
             color: var(--hrc-red);
         }
         
         /* Responsive Footer */
         @media (max-width: 768px) {
             .footer-content {
                 grid-template-columns: 1fr;
                 gap: 2rem;
                 padding: 2rem 1rem 1rem;
             }
             
             .footer-bottom-content {
                 flex-direction: column;
                 gap: 1rem;
                 text-align: center;
             }
             
             .footer-bottom-links {
                 gap: 1rem;
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
                                <a href="${pageContext.request.contextPath}/admin" class="user-link">
                                    <i class="bi bi-speedometer2"></i> Admin Dashboard
                                </a>
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
    <div class="banner-section">
        <div class="banner-container">
            <img src="${pageContext.request.contextPath}/img/HRC-banner.jpg" alt="Hanoi Rock City Banner" class="banner-image">
            <div class="banner-overlay">
                <div class="banner-content">
                    <h1 class="banner-title">Hanoi Rock City</h1>
                    <p class="banner-subtitle">Khám phá những sự kiện âm nhạc tuyệt vời nhất</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Search Bar -->
    <div class="search-nav-bar">
        <div class="search-container">
            <form action="${pageContext.request.contextPath}/events" method="get" class="search-form">
                <div class="search-box">
                    <i class="bi bi-search search-icon"></i>
                    <input type="text" name="search" class="search-input" placeholder="Tìm kiếm các sự kiện" value="${param.search}">
                </div>
                <button type="submit" class="search-btn">Tìm Các sự kiện</button>
            </form>
        </div>
    </div>

    <!-- Main Content -->
    <main class="event-list-container">
        <h1 class="event-list-title">
            <c:choose>
                <c:when test="${not empty param.search}">
                    Kết quả tìm kiếm cho "${param.search}"
                    <a href="${pageContext.request.contextPath}/events" class="clear-search-link">
                        <i class="bi bi-x-circle"></i> Xóa tìm kiếm
                    </a>
                </c:when>
                <c:otherwise>
                    Các sự kiện sắp tới
                </c:otherwise>
            </c:choose>
        </h1>
        
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
            <ul class="event-list">
                <c:forEach var="event" items="${events}">
                    <li>
                        <a href="${pageContext.request.contextPath}/event-detail?id=${event.id}" class="event-row">
                            <div class="event-date">
                                <div class="month">
                                    ${event.startAt.month.toString().substring(0,3).toUpperCase()}
                                </div>
                                <div class="day">
                                    ${event.startAt.dayOfMonth}
                                </div>
                                <div class="year">
                                    ${event.startAt.year}
                                </div>
                            </div>
                            
                            <div class="event-details">
                                <div class="event-time">
                                    ${event.startAt.hour}:${event.startAt.minute < 10 ? '0' : ''}${event.startAt.minute}
                                </div>
                                <h3 class="event-title">
                                    ${event.name}
                                    <span class="event-status">${event.status}</span>
                                </h3>
                                <div class="event-venue">
                                    <c:set var="venue" value="${eventVenuesMap[event.id]}" />
                                    <c:choose>
                                        <c:when test="${not empty venue}">
                                            ${venue.name}
                                        </c:when>
                                        <c:otherwise>
                                            Venue ID: ${event.venueId}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <p class="event-description">${event.description}</p>
                                <div class="event-artists">
                                    <c:set var="eventArtists" value="${eventArtistsMap[event.id]}" />
                                    <c:if test="${not empty eventArtists}">
                                        <c:forEach var="artist" items="${eventArtists}" varStatus="status">
                                            ${artist.artistName}<c:if test="${!status.last}">, </c:if>
                                        </c:forEach>
                                    </c:if>
                                </div>
                            </div>
                            
                            <div class="event-image">
                                <i class="bi bi-music-note-beamed"></i>
                            </div>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </c:if>
        
        <c:if test="${empty events}">
            <div class="empty-state">
                <i class="bi bi-music-note-beamed"></i>
                <h3>Không có sắp tới các sự kiện</h3>
                <p>Check back soon for upcoming rock concerts!</p>
            </div>
        </c:if>
         </main>
 
     <!-- Footer -->
     <footer class="footer">
         <div class="footer-content">
             <div class="footer-section">
                 <div class="footer-logo">
                     <img src="${pageContext.request.contextPath}/img/HRC-Logo.png" alt="Hanoi Rock City" class="footer-logo-image">
                     <h3>Hanoi Rock City</h3>
                 </div>
                 <p class="footer-description">
                     Nơi âm nhạc rock sống động nhất Hà Nội. Chúng tôi mang đến những trải nghiệm âm nhạc tuyệt vời nhất cho cộng đồng rock Việt Nam.
                 </p>
                 <div class="social-links">
                     <a href="#" class="social-link"><i class="bi bi-facebook"></i></a>
                     <a href="#" class="social-link"><i class="bi bi-instagram"></i></a>
                     <a href="#" class="social-link"><i class="bi bi-youtube"></i></a>
                     <a href="#" class="social-link"><i class="bi bi-twitter"></i></a>
                 </div>
             </div>
             
             <div class="footer-section">
                 <h4>Liên Kết Nhanh</h4>
                 <ul class="footer-links">
                     <li><a href="${pageContext.request.contextPath}/events">Sự Kiện</a></li>
                     <li><a href="#">Về Chúng Tôi</a></li>
                     <li><a href="#">Liên Hệ</a></li>
                     <li><a href="#">Tin Tức</a></li>
                     <li><a href="#">Hỗ Trợ</a></li>
                 </ul>
             </div>
             
             <div class="footer-section">
                 <h4>Thông Tin Liên Hệ</h4>
                 <div class="contact-info">
                     <div class="contact-item">
                         <i class="bi bi-geo-alt"></i>
                         <span>27/52 Tô Ngọc Vân, Tây Hồ, Hà Nội</span>
                     </div>
                     <div class="contact-item">
                         <i class="bi bi-telephone"></i>
                         <span>+84 24 3719 0567</span>
                     </div>
                     <div class="contact-item">
                         <i class="bi bi-envelope"></i>
                         <span>info@hanoirockcity.com</span>
                     </div>
                     <div class="contact-item">
                         <i class="bi bi-clock"></i>
                         <span>Thứ 2 - Chủ Nhật: 18:00 - 02:00</span>
                     </div>
                 </div>
             </div>
             
             <div class="footer-section">
                 <h4>Đăng Ký Nhận Tin</h4>
                 <p>Nhận thông báo về các sự kiện mới nhất</p>
                 <form class="newsletter-form">
                     <div class="input-group">
                         <input type="email" placeholder="Email của bạn" class="newsletter-input">
                         <button type="submit" class="newsletter-btn">
                             <i class="bi bi-send"></i>
                         </button>
                     </div>
                 </form>
             </div>
         </div>
         
         <div class="footer-bottom">
             <div class="footer-bottom-content">
                 <p>&copy; 2025 Hanoi Rock City. Tất cả quyền được bảo lưu.</p>
                 <div class="footer-bottom-links">
                     <a href="#">Chính Sách Bảo Mật</a>
                     <a href="#">Điều Khoản Sử Dụng</a>
                     <a href="#">Sơ Đồ Trang Web</a>
                 </div>
             </div>
         </div>
     </footer>
 
     <!-- Bootstrap JS -->
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
 </body>
 </html>
