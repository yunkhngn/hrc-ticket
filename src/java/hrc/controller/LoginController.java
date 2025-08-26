package hrc.controller;

import hrc.dao.UserDAO;
import hrc.dao.CustomerDAO;
import hrc.entity.User;
import hrc.entity.Customer;
import hrc.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        
        // Try to authenticate as admin first
        UserDAO userDAO = new UserDAO();
        User user = userDAO.findByEmail(email);
        
        if (user != null && user.isActive() && PasswordUtil.verifyPassword(password, user.getPasswordHash())) {
            // Admin login successful
            HttpSession session = request.getSession();
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userId", user.getId());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userName", user.getFullName());
            
            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin");
            } else {
                response.sendRedirect(request.getContextPath() + "/events");
            }
            return;
        }
        
        // Try to authenticate as customer
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.findByEmail(email);
        
        if (customer != null && PasswordUtil.verifyPassword(password, customer.getPasswordHash())) {
            // Customer login successful
            HttpSession session = request.getSession();
            session.setAttribute("userRole", "CUSTOMER");
            session.setAttribute("userId", customer.getId()); // Changed from customerId to userId
            session.setAttribute("userEmail", customer.getEmail());
            session.setAttribute("userName", customer.getFullName());
            
            response.sendRedirect(request.getContextPath() + "/events");
            return;
        }
        
        // Authentication failed
        request.setAttribute("error", "Invalid email or password");
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
}
