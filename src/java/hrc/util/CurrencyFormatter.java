package hrc.util;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

/**
 * Utility class for formatting currency values
 */
public class CurrencyFormatter {
    
    /**
     * Format currency with thousands separator
     * @param amount the amount to format
     * @param currency the currency code (e.g., "VND", "USD")
     * @return formatted currency string (e.g., "500.000 VND")
     */
    public static String formatCurrency(double amount, String currency) {
        if (currency == null || currency.trim().isEmpty()) {
            currency = "VND";
        }
        
        // Create a decimal format with thousands separator
        DecimalFormat formatter = new DecimalFormat("#,###");
        String formattedAmount = formatter.format(amount);
        
        // Remove decimal part if it's .00
        if (formattedAmount.contains(".")) {
            String[] parts = formattedAmount.split("\\.");
            if (parts.length > 1 && parts[1].equals("00")) {
                formattedAmount = parts[0];
            }
        }
        
        return formattedAmount + " " + currency.toUpperCase();
    }
    
    /**
     * Format currency with thousands separator (overloaded for BigDecimal)
     * @param amount the amount to format
     * @param currency the currency code (e.g., "VND", "USD")
     * @return formatted currency string (e.g., "500.000 VND")
     */
    public static String formatCurrency(java.math.BigDecimal amount, String currency) {
        if (amount == null) {
            return "0 " + (currency != null ? currency.toUpperCase() : "VND");
        }
        return formatCurrency(amount.doubleValue(), currency);
    }
    
    /**
     * Format currency with thousands separator (overloaded for Long)
     * @param amount the amount to format
     * @param currency the currency code (e.g., "VND", "USD")
     * @return formatted currency string (e.g., "500.000 VND")
     */
    public static String formatCurrency(Long amount, String currency) {
        if (amount == null) {
            return "0 " + (currency != null ? currency.toUpperCase() : "VND");
        }
        return formatCurrency(amount.doubleValue(), currency);
    }
    
    /**
     * Format currency with thousands separator (overloaded for Integer)
     * @param amount the amount to format
     * @param currency the currency code (e.g., "VND", "USD")
     * @return formatted currency string (e.g., "500.000 VND")
     */
    public static String formatCurrency(Integer amount, String currency) {
        if (amount == null) {
            return "0 " + (currency != null ? currency.toUpperCase() : "VND");
        }
        return formatCurrency(amount.doubleValue(), currency);
    }
}
