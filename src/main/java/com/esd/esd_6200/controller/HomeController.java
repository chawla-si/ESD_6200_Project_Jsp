package com.esd.esd_6200.controller;


import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import com.esd.esd_6200.pojo.Book;
import com.esd.esd_6200.service.AuthService;


@Controller
public class HomeController {
    
    @Autowired
    private RestTemplate restTemplate;
    
    @Autowired
    private AuthService authService;
    
    @GetMapping("/")
    public String homePage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        
        // Check authentication status
        boolean isAuthenticated = authService.isAuthenticated(request);
        model.addAttribute("isAuthenticated", isAuthenticated);
        
        // Fetch books for carousel
        List<Book> books = new ArrayList<>();
        boolean isLoading = true;
        String httpError = null;
        
        try {
            String baseUrl = "http://localhost:8080/api/books";
            String url = baseUrl + "?page=0&size=9";
            
            // Using RestTemplate to fetch the books from API
            BookResponse response = restTemplate.getForObject(url, BookResponse.class);
            
            if (response != null && response.getBooks() != null) {
                books = response.getBooks();
            }
            
            isLoading = false;
        } catch (Exception e) {
            isLoading = false;
            httpError = "Something went wrong!";
        }
        
        model.addAttribute("books", books);
        model.addAttribute("isLoading", isLoading);
        model.addAttribute("httpError", httpError);
        
        return "HomePage";
    }
}

// Helper class to map API response
class BookResponse {
    private List<Book> books;
    
    public List<Book> getBooks() {
        return books;
    }
    
    public void setBooks(List<Book> books) {
        this.books = books;
    }
}