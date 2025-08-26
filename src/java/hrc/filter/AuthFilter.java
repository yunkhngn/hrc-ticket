package hrc.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*", "/checkout", "/orders", "/order"})
public class AuthFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Check if user is logged in
        boolean isLoggedIn = session != null && session.getAttribute("userRole") != null;
        
        // Check if accessing admin pages
        boolean isAdminPage = requestURI.startsWith(contextPath + "/admin/");
        
        if (!isLoggedIn) {
            // Not logged in, redirect to login page
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }
        
        if (isAdminPage) {
            // Check if user has admin or staff role
            String userRole = (String) session.getAttribute("userRole");
            if (!"ADMIN".equals(userRole) && !"STAFF".equals(userRole)) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin or Staff access required");
                return;
            }
        }
        
        // Continue with the request
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
