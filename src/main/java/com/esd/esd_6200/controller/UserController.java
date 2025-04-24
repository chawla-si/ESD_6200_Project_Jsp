package com.esd.esd_6200.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.*;


import com.esd.esd_6200.pojo.Book;
import com.esd.esd_6200.service.BookService;


@Controller
@RequestMapping("/books")
public class UserController {
	
	 @Autowired
	    private BookService bookService;

	 @GetMapping("/")
	    public String home(@RequestParam(defaultValue = "0") int page,
	                       @RequestParam(defaultValue = "15") int size,
	                       @RequestParam(defaultValue = "id") String sortBy,
	                       @RequestParam(defaultValue = "ASC") String direction,
	                       Model model) {

	        Page<Book> bookPage = bookService.getPaginatedBooks(page, size, sortBy, direction);

	        model.addAttribute("books", bookPage.getContent());
	        model.addAttribute("currentPage", page);
	        model.addAttribute("totalPages", bookPage.getTotalPages());
	        model.addAttribute("sortBy", sortBy);
	        model.addAttribute("direction", direction);

	        return "index";
	    }
}
