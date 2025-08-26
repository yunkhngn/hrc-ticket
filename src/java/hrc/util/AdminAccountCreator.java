package hrc.util;

import hrc.dao.UserDAO;
import hrc.entity.User;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AdminAccountCreator {
    private static final Logger LOGGER = Logger.getLogger(AdminAccountCreator.class.getName());
    
    public static void main(String[] args) {
        createAdminAccount();
    }
    
    public static void createAdminAccount() {
        UserDAO userDAO = new UserDAO();
        
        // Check if admin already exists
        User existingAdmin = userDAO.findByEmail("admin@hrc.com");
        if (existingAdmin != null) {
            // Check if password hash is NULL
            if (existingAdmin.getPasswordHash() == null) {
                System.out.println("Admin account exists but has no password. Setting password...");
                
                // Update the existing admin with a password
                existingAdmin.setPasswordHash(PasswordUtil.hashPassword("admin123"));
                
                if (userDAO.update(existingAdmin)) {
                    System.out.println("Admin account password set successfully!");
                    System.out.println("Email: admin@hrc.com");
                    System.out.println("Password: admin123");
                    System.out.println("You can now login to access the admin panel.");
                } else {
                    System.out.println("Failed to set admin password!");
                }
            } else {
                System.out.println("Admin account already exists with password!");
                System.out.println("Email: admin@hrc.com");
                System.out.println("Password: admin123");
            }
            return;
        }
        
        // Create new admin user
        User admin = new User();
        admin.setEmail("admin@hrc.com");
        admin.setFullName("HRC Administrator");
        admin.setPhone("0123456789");
        admin.setRole("ADMIN");
        admin.setActive(true);
        admin.setPasswordHash(PasswordUtil.hashPassword("admin123"));
        
        if (userDAO.create(admin)) {
            System.out.println("Admin account created successfully!");
            System.out.println("Email: admin@hrc.com");
            System.out.println("Password: admin123");
            System.out.println("You can now login to access the admin panel.");
        } else {
            System.out.println("Failed to create admin account!");
        }
    }
}
