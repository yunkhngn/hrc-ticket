package hrc.controller;

import hrc.util.AdminAccountCreator;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "SetupController", urlPatterns = {"/setup"})
public class SetupController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/WEB-INF/views/setup.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("createAdmin".equals(action)) {
            AdminAccountCreator.createAdminAccount();
            request.setAttribute("success", "Admin account setup completed! Email: admin@hrc.com, Password: admin123");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/setup.jsp").forward(request, response);
    }
}
