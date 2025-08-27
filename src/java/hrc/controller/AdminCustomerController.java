package hrc.controller;

import hrc.dao.CustomerDAO;
import hrc.entity.Customer;
import hrc.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminCustomerController", urlPatterns = {"/admin/customers"})
public class AdminCustomerController extends HttpServlet {
    private final CustomerDAO customerDAO;
    
    public AdminCustomerController() {
        this.customerDAO = new CustomerDAO();
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
        
        // List all customer accounts
        List<Customer> customers = customerDAO.list();
        request.setAttribute("customers", customers);
        
        // Pass through any success/error messages
        String success = request.getParameter("success");
        String error = request.getParameter("error");
        if (success != null) {
            request.setAttribute("success", success);
        }
        if (error != null) {
            request.setAttribute("error", error);
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin/customers.jsp").forward(request, response);
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
            createCustomer(request, response);
        } else if ("update".equals(action)) {
            updateCustomer(request, response);
        } else if ("delete".equals(action)) {
            deleteCustomer(request, response);
        } else if ("resetPassword".equals(action)) {
            resetCustomerPassword(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    private void createCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        
        if (email == null || email.trim().isEmpty() || 
            fullName == null || fullName.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=Required+fields+missing");
            return;
        }
        
        // Check if email already exists
        Customer existingCustomer = customerDAO.findByEmail(email);
        if (existingCustomer != null) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=Email+already+exists");
            return;
        }
        
        Customer customer = new Customer();
        customer.setEmail(email);
        customer.setFullName(fullName);
        customer.setPhone(phone != null ? phone : "");
        customer.setPasswordHash(PasswordUtil.hashPassword(password));
        
        if (customerDAO.create(customer)) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?success=Customer+created+successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=Failed+to+create+customer");
        }
    }
    
    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String customerIdParam = request.getParameter("customerId");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        
        if (customerIdParam == null || customerIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=Customer+ID+required");
            return;
        }
        
        try {
            Long customerId = Long.parseLong(customerIdParam);
            Customer customer = customerDAO.findById(customerId);
            
            if (customer == null) {
                response.sendRedirect(request.getContextPath() + "/admin/customers?error=Customer+not+found");
                return;
            }
            
            customer.setEmail(email != null ? email : customer.getEmail());
            customer.setFullName(fullName != null ? fullName : customer.getFullName());
            customer.setPhone(phone != null ? phone : customer.getPhone());
            
            // Only update password if provided
            if (password != null && !password.trim().isEmpty()) {
                customer.setPasswordHash(PasswordUtil.hashPassword(password));
            }
            
            if (customerDAO.update(customer)) {
                response.sendRedirect(request.getContextPath() + "/admin/customers?success=Customer+updated+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/customers?error=Failed+to+update+customer");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=Invalid+customer+ID");
        }
    }
    
    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String customerIdParam = request.getParameter("customerId");
        
        if (customerIdParam == null || customerIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=Customer+ID+required");
            return;
        }
        
        try {
            Long customerId = Long.parseLong(customerIdParam);
            
            // Check if customer has any orders before deleting
            // For now, we'll just delete the customer
            // In a real system, you might want to check for existing orders first
            
            if (customerDAO.delete(customerId)) {
                response.sendRedirect(request.getContextPath() + "/admin/customers?success=Customer+deleted+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/customers?error=Failed+to+delete+customer");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=Invalid+customer+ID");
        }
    }
    
    private void resetCustomerPassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String customerIdParam = request.getParameter("customerId");
        
        if (customerIdParam == null || customerIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=Customer+ID+required");
            return;
        }
        
        try {
            Long customerId = Long.parseLong(customerIdParam);
            Customer customer = customerDAO.findById(customerId);
            
            if (customer == null) {
                response.sendRedirect(request.getContextPath() + "/admin/customers?error=Customer+not+found");
                return;
            }
            
            // Reset to default password
            String defaultPassword = "customer123";
            customer.setPasswordHash(PasswordUtil.hashPassword(defaultPassword));
            
            if (customerDAO.update(customer)) {
                response.sendRedirect(request.getContextPath() + "/admin/customers?success=Password+reset+to:+customer123");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/customers?error=Failed+to+reset+password");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/customers?error=Invalid+customer+ID");
        }
    }
}
