package hrc.controller;

import hrc.dao.PromoCodeDAO;
import hrc.entity.PromoCode;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "AdminPromoCodeController", urlPatterns = {"/admin/promo-codes"})
public class AdminPromoCodeController extends HttpServlet {
    private final PromoCodeDAO promoCodeDAO;
    
    public AdminPromoCodeController() {
        this.promoCodeDAO = new PromoCodeDAO();
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
        
        // List all promo codes
        List<PromoCode> promoCodes = promoCodeDAO.list();
        request.setAttribute("promoCodes", promoCodes);
        
        // Pass through any success/error messages
        String success = request.getParameter("success");
        String error = request.getParameter("error");
        if (success != null) {
            request.setAttribute("success", success);
        }
        if (error != null) {
            request.setAttribute("error", error);
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin/promo-codes.jsp").forward(request, response);
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
            createPromoCode(request, response);
        } else if ("update".equals(action)) {
            updatePromoCode(request, response);
        } else if ("delete".equals(action)) {
            deletePromoCode(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    private void createPromoCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String code = request.getParameter("code");
        String discountType = request.getParameter("discountType");
        String discountValueParam = request.getParameter("discountValue");
        String maxUsesParam = request.getParameter("maxUses");
        String perCustomerLimitParam = request.getParameter("perCustomerLimit");
        String startAtParam = request.getParameter("startAt");
        String endAtParam = request.getParameter("endAt");
        String minOrderAmountParam = request.getParameter("minOrderAmount");
        
        if (code == null || code.trim().isEmpty() ||
            discountType == null || discountType.trim().isEmpty() ||
            discountValueParam == null || discountValueParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/promo-codes?error=Required+fields+missing");
            return;
        }
        
        try {
            PromoCode promoCode = new PromoCode();
            promoCode.setCode(code.trim().toUpperCase());
            promoCode.setDiscountType(discountType.trim());
            promoCode.setDiscountValue(new BigDecimal(discountValueParam.trim()));
            
            if (maxUsesParam != null && !maxUsesParam.trim().isEmpty()) {
                promoCode.setMaxUses(Integer.parseInt(maxUsesParam.trim()));
            }
            
            if (perCustomerLimitParam != null && !perCustomerLimitParam.trim().isEmpty()) {
                promoCode.setPerCustomerLimit(Integer.parseInt(perCustomerLimitParam.trim()));
            }
            
            if (startAtParam != null && !startAtParam.trim().isEmpty()) {
                promoCode.setStartAt(parseDateTime(startAtParam.trim()));
            }
            
            if (endAtParam != null && !endAtParam.trim().isEmpty()) {
                promoCode.setEndAt(parseDateTime(endAtParam.trim()));
            }
            
            if (minOrderAmountParam != null && !minOrderAmountParam.trim().isEmpty()) {
                promoCode.setMinOrderAmount(new BigDecimal(minOrderAmountParam.trim()));
            }
            
            if (promoCodeDAO.create(promoCode)) {
                response.sendRedirect(request.getContextPath() + "/admin/promo-codes?success=Promo+code+created+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/promo-codes?error=Failed+to+create+promo+code");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/promo-codes?error=Invalid+number+format");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/promo-codes?error=Unexpected+error");
        }
    }
    
    private void updatePromoCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String promoCodeIdParam = request.getParameter("promoCodeId");
        String code = request.getParameter("code");
        String discountType = request.getParameter("discountType");
        String discountValueParam = request.getParameter("discountValue");
        String maxUsesParam = request.getParameter("maxUses");
        String perCustomerLimitParam = request.getParameter("perCustomerLimit");
        String startAtParam = request.getParameter("startAt");
        String endAtParam = request.getParameter("endAt");
        String minOrderAmountParam = request.getParameter("minOrderAmount");
        
        if (promoCodeIdParam == null || promoCodeIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/promo-codes?error=Promo+code+ID+required");
            return;
        }
        
        try {
            Long promoCodeId = Long.parseLong(promoCodeIdParam);
            PromoCode promoCode = promoCodeDAO.findById(promoCodeId);
            
            if (promoCode == null) {
                response.sendRedirect(request.getContextPath() + "/admin/promo-codes?error=Promo+code+not+found");
                return;
            }
            
            if (code != null && !code.trim().isEmpty()) {
                promoCode.setCode(code.trim().toUpperCase());
            }
            if (discountType != null && !discountType.trim().isEmpty()) {
                promoCode.setDiscountType(discountType.trim());
            }
            if (discountValueParam != null && !discountValueParam.trim().isEmpty()) {
                promoCode.setDiscountValue(new BigDecimal(discountValueParam.trim()));
            }
            if (maxUsesParam != null && !maxUsesParam.trim().isEmpty()) {
                promoCode.setMaxUses(Integer.parseInt(maxUsesParam.trim()));
            }
            if (perCustomerLimitParam != null && !perCustomerLimitParam.trim().isEmpty()) {
                promoCode.setPerCustomerLimit(Integer.parseInt(perCustomerLimitParam.trim()));
            }
            if (startAtParam != null && !startAtParam.trim().isEmpty()) {
                promoCode.setStartAt(parseDateTime(startAtParam.trim()));
            }
            if (endAtParam != null && !endAtParam.trim().isEmpty()) {
                promoCode.setEndAt(parseDateTime(endAtParam.trim()));
            }
            if (minOrderAmountParam != null && !minOrderAmountParam.trim().isEmpty()) {
                promoCode.setMinOrderAmount(new BigDecimal(minOrderAmountParam.trim()));
            }
            
            if (promoCodeDAO.update(promoCode)) {
                response.sendRedirect(request.getContextPath() + "/admin/promo-codes?success=Promo+code+updated+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/promo-codes?error=Failed+to+update+promo+code");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/promo-codes?error=Invalid+number+format");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/promo-codes?error=Unexpected+error");
        }
    }
    
    private void deletePromoCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String promoCodeIdParam = request.getParameter("promoCodeId");
        
        if (promoCodeIdParam == null || promoCodeIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/promo-codes?error=Promo+code+ID+required");
            return;
        }
        
        try {
            Long promoCodeId = Long.parseLong(promoCodeIdParam);
            
            if (promoCodeDAO.delete(promoCodeId)) {
                response.sendRedirect(request.getContextPath() + "/admin/promo-codes?success=Promo+code+deleted+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/promo-codes?error=Failed+to+delete+promo+code");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/promo-codes?error=Invalid+promo+code+ID");
        }
    }
    
    private LocalDateTime parseDateTime(String dateTimeStr) {
        // Handle both "yyyy-MM-dd'T'HH:mm" and "yyyy-MM-dd'T'HH:mm:ss" formats
        DateTimeFormatter[] formatters = {
            DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"),
            DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss")
        };
        
        for (DateTimeFormatter formatter : formatters) {
            try {
                return LocalDateTime.parse(dateTimeStr, formatter);
            } catch (Exception e) {
                // Continue to next formatter
            }
        }
        
        // If none work, try replacing 'T' with space and parsing
        try {
            String formattedStr = dateTimeStr.replace('T', ' ');
            return LocalDateTime.parse(formattedStr, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
        } catch (Exception e) {
            throw new IllegalArgumentException("Invalid date format: " + dateTimeStr);
        }
    }
}
