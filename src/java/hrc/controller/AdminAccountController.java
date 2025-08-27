package hrc.controller;

import hrc.dao.UserDAO;
import hrc.entity.User;
import hrc.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminAccountController", urlPatterns = {"/admin/accounts"})
public class AdminAccountController extends HttpServlet {
    private final UserDAO userDAO;
    
    public AdminAccountController() {
        this.userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        
        if (!"ADMIN".equals(userRole) && !"STAFF".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin or Staff access required");
            return;
        }
        
        // List all staff and admin accounts
        List<User> users = userDAO.list();
        request.setAttribute("users", users);
        
        // Pass through any success/error messages
        String success = request.getParameter("success");
        String error = request.getParameter("error");
        if (success != null) {
            request.setAttribute("success", success);
        }
        if (error != null) {
            request.setAttribute("error", error);
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin/accounts.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        
        if (!"ADMIN".equals(userRole) && !"STAFF".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin or Staff access required");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            createUser(request, response);
        } else if ("update".equals(action)) {
            updateUser(request, response);
        } else if ("delete".equals(action)) {
            deleteUser(request, response);
        } else if ("toggleStatus".equals(action)) {
            toggleUserStatus(request, response);
        } else if ("permanentDelete".equals(action)) {
            permanentDeleteUser(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    private void createUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");
        String password = request.getParameter("password");
        
        if (email == null || email.trim().isEmpty() || 
            fullName == null || fullName.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/accounts?error=Required+fields+missing");
            return;
        }
        
        // Check if email already exists
        User existingUser = userDAO.findByEmail(email);
        if (existingUser != null) {
            response.sendRedirect(request.getContextPath() + "/admin/accounts?error=Email+already+exists");
            return;
        }
        
        User user = new User();
        user.setEmail(email);
        user.setFullName(fullName);
        user.setPhone(phone != null ? phone : "");
        user.setRole(role != null ? role : "STAFF");
        user.setActive(true);
        user.setPasswordHash(PasswordUtil.hashPassword(password));
        
        if (userDAO.create(user)) {
            response.sendRedirect(request.getContextPath() + "/admin/accounts?success=User+created+successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/accounts?error=Failed+to+create+user");
        }
    }
    
    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userIdParam = request.getParameter("userId");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");
        String password = request.getParameter("password");
        
        if (userIdParam == null || userIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/accounts?error=User+ID+required");
            return;
        }
        
        try {
            Long userId = Long.parseLong(userIdParam);
            User user = userDAO.findById(userId);
            
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/admin/accounts?error=User+not+found");
                return;
            }
            
            user.setEmail(email != null ? email : user.getEmail());
            user.setFullName(fullName != null ? fullName : user.getFullName());
            user.setPhone(phone != null ? phone : user.getPhone());
            user.setRole(role != null ? role : user.getRole());
            
            // Only update password if provided
            if (password != null && !password.trim().isEmpty()) {
                user.setPasswordHash(PasswordUtil.hashPassword(password));
            }
            
            if (userDAO.update(user)) {
                response.sendRedirect(request.getContextPath() + "/admin/accounts?success=User+updated+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/accounts?error=Failed+to+update+user");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/accounts?error=Invalid+user+ID");
        }
    }
    
    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userIdParam = request.getParameter("userId");
        
        if (userIdParam == null || userIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/accounts?error=User+ID+required");
            return;
        }
        
        try {
            Long userId = Long.parseLong(userIdParam);
            
            // Don't allow admin to delete themselves
            HttpSession session = request.getSession();
            Long currentUserId = (Long) session.getAttribute("userId");
            if (userId.equals(currentUserId)) {
                response.sendRedirect(request.getContextPath() + "/admin/accounts?error=Cannot+delete+your+own+account");
                return;
            }
            
            // For now, we'll just deactivate the user instead of deleting
            User user = userDAO.findById(userId);
            if (user != null) {
                user.setActive(false);
                if (userDAO.update(user)) {
                    response.sendRedirect(request.getContextPath() + "/admin/accounts?success=User+deactivated+successfully");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/accounts?error=Failed+to+deactivate+user");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/accounts?error=User+not+found");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/accounts?error=Invalid+user+ID");
        }
    }
    
    private void toggleUserStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userIdParam = request.getParameter("userId");
        
        if (userIdParam == null || userIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/accounts?error=User+ID+required");
            return;
        }
        
        try {
            Long userId = Long.parseLong(userIdParam);
            
            // Don't allow admin to deactivate themselves
            HttpSession session = request.getSession();
            Long currentUserId = (Long) session.getAttribute("userId");
            if (userId.equals(currentUserId)) {
                response.sendRedirect(request.getContextPath() + "/admin/accounts?error=Cannot+deactivate+your+own+account");
                return;
            }
            
            User user = userDAO.findById(userId);
            if (user != null) {
                user.setActive(!user.isActive());
                String status = user.isActive() ? "activated" : "deactivated";
                
                if (userDAO.update(user)) {
                    response.sendRedirect(request.getContextPath() + "/admin/accounts?success=User+" + status + "+successfully");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/accounts?error=Failed+to+update+user+status");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/accounts?error=User+not+found");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/accounts?error=Invalid+user+ID");
        }
    }
    
    private void permanentDeleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userIdParam = request.getParameter("userId");
        
        if (userIdParam == null || userIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/accounts?error=User+ID+required");
            return;
        }
        
        try {
            Long userId = Long.parseLong(userIdParam);
            
            // Don't allow admin to delete themselves
            HttpSession session = request.getSession();
            Long currentUserId = (Long) session.getAttribute("userId");
            if (userId.equals(currentUserId)) {
                response.sendRedirect(request.getContextPath() + "/admin/accounts?error=Cannot+delete+your+own+account");
                return;
            }
            
            User user = userDAO.findById(userId);
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/admin/accounts?error=User+not+found");
                return;
            }
            
            // Only allow permanent deletion of inactive accounts
            if (user.isActive()) {
                response.sendRedirect(request.getContextPath() + "/admin/accounts?error=Account+must+be+deactivated+before+permanent+deletion");
                return;
            }
            
            // Perform permanent deletion
            if (userDAO.delete(userId)) {
                response.sendRedirect(request.getContextPath() + "/admin/accounts?success=User+permanently+deleted+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/accounts?error=Failed+to+delete+user");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/accounts?error=Invalid+user+ID");
        }
    }
}
