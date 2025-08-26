<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
