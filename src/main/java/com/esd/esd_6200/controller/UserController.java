package com.esd.esd_6200.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.*;


import com.esd.esd_6200.pojo.Book;
import com.esd.esd_6200.requestModels.AddBookRequest;
import com.esd.esd_6200.service.AdminService;
import com.esd.esd_6200.service.BookService;
import com.esd.esd_6200.utils.ExtractJWT;


@Controller
@RequestMapping("/books")
public class UserController {
	
	 @Autowired
	    private BookService bookService;
	
	 @Autowired
	    private AdminService adminService;

//	 @GetMapping("/")
//	    public String home(@RequestParam(defaultValue = "0") int page,
//	                       @RequestParam(defaultValue = "15") int size,
//	                       @RequestParam(defaultValue = "id") String sortBy,
//	                       @RequestParam(defaultValue = "ASC") String direction,
//	                       Model model) {
//
//	        Page<Book> bookPage = bookService.getPaginatedBooks(page, size, sortBy, direction);
//
//	        model.addAttribute("books", bookPage.getContent());
//	        model.addAttribute("currentPage", page);
//	        model.addAttribute("totalPages", bookPage.getTotalPages());
//	        model.addAttribute("sortBy", sortBy);
//	        model.addAttribute("direction", direction);
//
//	        return "index";
//	    }
	 
	 @GetMapping("/")
	 public String getAllBooks(Model model) {
	     List<Book> books = bookService.getAllBooks();
	     model.addAttribute("books", books);
	     return "index"; // This will render index.jsp with all books
	 }
	 
	 @GetMapping("/new")
	 public String showAddBookPage() {
	     return "addBook"; // resolve to addBook.jsp
	 }
	 
	 @PostMapping("/add")
	 public String postBook(@RequestParam("title") String title,
	                        @RequestParam("author") String author,
	                        @RequestParam("description") String description,
	                        @RequestParam("copies") int copies,
	                        @RequestParam("category") String category,
	                        @RequestParam("imageFile") MultipartFile imageFile
//	                        @RequestParam("token") String token
	                        ) throws Exception {

//	     String admin = ExtractJWT.payloadJWTExtraction(token, "\"userType\"");
//	     if (admin == null || !admin.equals("admin")) {
//	         throw new Exception("Administration page only");
//	     }

	     // Save the image file
		 String uploadDir = "uploads/";
	     String fileName = UUID.randomUUID() + "_" + imageFile.getOriginalFilename();
	     Path imagePath = Paths.get(uploadDir + fileName);
	     Files.createDirectories(imagePath.getParent());
	     Files.write(imagePath, imageFile.getBytes());

	     // Create and save book
	     AddBookRequest addBookRequest = new AddBookRequest();
	     addBookRequest.setTitle(title);
	     addBookRequest.setAuthor(author);
	     addBookRequest.setDescription(description);
	     addBookRequest.setCopies(copies);
	     addBookRequest.setCategory(category);
	     addBookRequest.setImg("/uploads/" + fileName);// relative path to be used in HTML

	     adminService.postBook(addBookRequest);

	     return "redirect:/books/?success=true";
	 }
	 
	 @GetMapping("/delete/{bookId}")
	 public String deleteBook(@PathVariable Long bookId) throws Exception {
	     adminService.deleteBook(bookId);
	     return "redirect:/books/?deleted=true";
	 }
	 
	 @PutMapping("/increase/{bookId}")
	 public String increaseBookQuantity(@PathVariable Long bookId, RedirectAttributes redirectAttributes) {
	     try {
	         adminService.increaseBookQuantity(bookId);
	         redirectAttributes.addAttribute("updated", "true");
	     } catch (Exception e) {
	         redirectAttributes.addAttribute("error", "true");
	     }
	     return "redirect:/books/";
	 }

	 @PutMapping("/decrease/{bookId}")
	 public String decreaseBookQuantity(@PathVariable Long bookId, RedirectAttributes redirectAttributes) {
	     try {
	         adminService.decreaseBookQuantity(bookId);
	         redirectAttributes.addAttribute("updated", "true");
	     } catch (Exception e) {
	         redirectAttributes.addAttribute("error", "true");
	     }
	     return "redirect:/books/";
	 }
}
