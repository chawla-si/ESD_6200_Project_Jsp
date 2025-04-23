<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${book.title} - Library Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container py-5">
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/books">Books</a></li>
                <li class="breadcrumb-item active" aria-current="page">Book Details</li>
            </ol>
        </nav>
        
        <div class="card shadow">
            <div class="card-body">
                <div class="row">
                    <!-- Book Image -->
                    <div class="col-md-4 mb-4 mb-md-0">
                        <c:choose>
                            <c:when test="${not empty book.img}">
                                <img src="${book.img}" class="img-fluid rounded" alt="${book.title}">
                            </c:when>
                            <c:otherwise>
                                <div class="bg-light rounded d-flex align-items-center justify-content-center" style="height: 400px;">
                                    <span class="text-muted">No image available</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <!-- Book Details -->
                    <div class="col-md-8">
                        <h1 class="mb-3">${book.title}</h1>
                        <p class="fs-5 mb-3">By <strong>${book.author}</strong></p>
                        <p class="mb-3"><span class="badge bg-secondary">${book.category}</span></p>
                        
                        <hr>
                        
                        <h5>Description</h5>
                        <p>${not empty book.description ? book.description : 'No description available.'}</p>
                        
                        <div class="d-flex align-items-center justify-content-between mt-4">
                            <p class="mb-0">
                                <strong>Copies Available:</strong> ${book.copiesAvailable} / ${book.copies}
                            </p>
                            
                            <c:if test="${not empty userEmail}">
                                <c:choose>
                                    <c:when test="${isCheckedOut}">
                                        <button class="btn btn-secondary" disabled>Already Checked Out</button>
                                    </c:when>
                                    <c:when test="${book.copiesAvailable < 1}">
                                        <button class="btn btn-secondary" disabled>Not Available</button>
                                    </c:when>
                                    <c:otherwise>
                                        <form action="${pageContext.request.contextPath}/books/checkout" method="post">
                                            <input type="hidden" name="bookId" value="${book.id}">
                                            <button type="submit" class="btn btn-success">Checkout</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Return to List Button -->
        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/books" class="btn btn-outline-primary">Return to Book List</a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>