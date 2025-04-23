<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Book Search</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .book-card {
            height: 100%;
            transition: transform 0.3s;
        }
        .book-card:hover {
            transform: translateY(-5px);
        }
        .book-img {
            height: 250px;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <h1 class="mb-4">Library Book Search</h1>
        
        <!-- Search Form -->
        <div class="card mb-4">
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/books" method="get" id="searchForm">
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <select id="searchMode" class="form-select" onchange="updateSearchForm()">
                                <option value="all" ${param.searchMode == 'all' ? 'selected' : ''}>All Books</option>
                                <option value="title" ${param.searchMode == 'title' ? 'selected' : ''}>Search by Title</option>
                                <option value="category" ${param.searchMode == 'category' ? 'selected' : ''}>Search by Category</option>
                            </select>
                        </div>
                        
                        <div class="col-md-4" id="titleSearchDiv" style="display: none;">
                            <input type="text" name="title" class="form-control" placeholder="Enter book title..." value="${param.title}">
                        </div>
                        
                        <div class="col-md-4" id="categorySearchDiv" style="display: none;">
                            <select name="category" class="form-select">
                                <option value="">Select a category</option>
                                <option value="fiction" ${param.category == 'fiction' ? 'selected' : ''}>Fiction</option>
                                <option value="non-fiction" ${param.category == 'non-fiction' ? 'selected' : ''}>Non-Fiction</option>
                                <option value="fantasy" ${param.category == 'fantasy' ? 'selected' : ''}>Fantasy</option>
                                <option value="history" ${param.category == 'history' ? 'selected' : ''}>History</option>
                                <option value="science" ${param.category == 'science' ? 'selected' : ''}>Science</option>
                            </select>
                        </div>
                        
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-primary">Search</button>
                        </div>
                    </div>
                    
                    <!-- Sort Options -->
                    <div class="row">
                        <div class="col-md-4">
                            <div class="input-group">
                                <label class="input-group-text">Sort by:</label>
                                <select name="sortBy" class="form-select">
                                    <option value="id" ${param.sortBy == 'id' ? 'selected' : ''}>ID</option>
                                    <option value="title" ${param.sortBy == 'title' ? 'selected' : ''}>Title</option>
                                    <option value="author" ${param.sortBy == 'author' ? 'selected' : ''}>Author</option>
                                    <option value="category" ${param.sortBy == 'category' ? 'selected' : ''}>Category</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="input-group">
                                <label class="input-group-text">Direction:</label>
                                <select name="direction" class="form-select">
                                    <option value="asc" ${param.direction == 'asc' ? 'selected' : ''}>Ascending</option>
                                    <option value="desc" ${param.direction == 'desc' ? 'selected' : ''}>Descending</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Hidden inputs for pagination -->
                    <input type="hidden" name="page" id="pageInput" value="${empty param.page ? 0 : param.page}">
                    <input type="hidden" name="size" value="${empty param.size ? 9 : param.size}">
                    <input type="hidden" name="searchMode" id="searchModeInput" value="${empty param.searchMode ? 'all' : param.searchMode}">
                </form>
            </div>
        </div>
        
        <!-- User loan count display (if logged in) -->
        <c:if test="${not empty userEmail}">
            <div class="alert alert-info mb-4">
                <p class="mb-0">You currently have ${loanCount} book(s) checked out.</p>
            </div>
        </c:if>
        
        <!-- Book Grid -->
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 mb-4">
            <c:choose>
                <c:when test="${not empty books}">
                    <c:forEach var="book" items="${books}">
                        <div class="col">
                            <div class="card book-card h-100 shadow">
                                <c:choose>
                                    <c:when test="${not empty book.img}">
                                        <img src="${book.img}" class="card-img-top book-img" alt="${book.title}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="card-img-top book-img bg-light d-flex align-items-center justify-content-center">
                                            <span class="text-muted">No image available</span>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                
                                <div class="card-body">
                                    <h5 class="card-title">${book.title}</h5>
                                    <p class="card-text">By ${book.author}</p>
                                    <p class="card-text"><small class="text-muted">Category: ${book.category}</small></p>
                                </div>
                                
                                <div class="card-footer bg-transparent d-flex justify-content-between">
                                    <a href="${pageContext.request.contextPath}/books/${book.id}" class="btn btn-outline-secondary">Details</a>
                                    
                                    <c:if test="${not empty userEmail}">
                                        <c:choose>
                                            <c:when test="${book.copiesAvailable > 0}">
                                                <form action="${pageContext.request.contextPath}/books/checkout" method="post">
                                                    <input type="hidden" name="bookId" value="${book.id}">
                                                    <button type="submit" class="btn btn-success">Checkout</button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-secondary" disabled>Not Available</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <div class="alert alert-secondary text-center p-5">
                            <p class="h4">No books found matching your criteria.</p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Pagination -->
        <c:if test="${totalPages > 0}">
            <nav>
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                        <a class="page-link" href="#" onclick="changePage(${currentPage - 1}); return false;">Previous</a>
                    </li>
                    
                    <c:forEach begin="0" end="${totalPages - 1}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="#" onclick="changePage(${i}); return false;">${i + 1}</a>
                        </li>
                    </c:forEach>
                    
                    <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                        <a class="page-link" href="#" onclick="changePage(${currentPage + 1}); return false;">Next</a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>
    
    <script>
        // Initialize form based on current search mode
        window.onload = function() {
            updateSearchForm();
        };
        
        function updateSearchForm() {
            const searchMode = document.getElementById('searchMode').value;
            document.getElementById('searchModeInput').value = searchMode;
            
            // Show/hide appropriate search fields
            const titleSearchDiv = document.getElementById('titleSearchDiv');
            const categorySearchDiv = document.getElementById('categorySearchDiv');
            
            titleSearchDiv.style.display = 'none';
            categorySearchDiv.style.display = 'none';
            
            if (searchMode === 'title') {
                titleSearchDiv.style.display = 'block';
            } else if (searchMode === 'category') {
                categorySearchDiv.style.display = 'block';
            }
        }
        
        function changePage(pageNum) {
            document.getElementById('pageInput').value = pageNum;
            document.getElementById('searchForm').submit();
        }
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>