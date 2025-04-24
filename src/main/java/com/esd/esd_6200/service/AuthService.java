package com.esd.esd_6200.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

@Service
public class AuthService {
    
    public boolean isAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Check if user is authenticated in session
            Boolean isAuthenticated = (Boolean) session.getAttribute("isAuthenticated");
            return isAuthenticated != null && isAuthenticated;
        }
        
        return false;
    }
}