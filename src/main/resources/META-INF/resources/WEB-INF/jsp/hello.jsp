<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library Management - Books</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .book-card {
            height: 100%;
            transition: transform 0.3s;
        }
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .book-image {
            height: 250px;
            object-fit: cover;
        }
        .pagination {
            justify-content: center;
            margin-top: 2rem;
        }
        .search-container {
            margin-bottom: 2rem;
        }
        .category-filter {
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Book Library</h1>
        
        <!-- Search and Filter Section -->
        <div class="row mb-4">
            <div class="col-md-6">
                <div class="search-container">
                    <form action="${pageContext.request.contextPath}/api/books/search/findByTitleContaining" method="get" class="d-flex">
                        <input type="text" name="title" class="form-control me-2" placeholder="Search by title...">
                        <button type="submit" class="btn btn-primary">Search</button>
                    </form>
                </div>
            </div>
            <div class="col-md-6">
                <div class="category-filter">
                    <form action="${pageContext.request.contextPath}/api/books/search/findByCategory" method="get" class="d-flex">
                        <select name="category" class="form-select me-2">
                            <option value="">Select Category</option>
                            <option value="fiction">Fiction</option>
                            <option value="non-fiction">Non-fiction</option>
                            <option value="programming">Programming</option>
                            <option value="history">History</option>
                            <option value="science">Science</option>
                            <!-- Add more categories as needed -->
                        </select>
                        <button type="submit" class="btn btn-primary">Filter</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Books Display Section -->
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <c:forEach var="book" items="${books}">
                <div class="col">
                    <div class="card book-card">
                        <img src="${book.img}" class="card-img-top book-image" alt="${book.title}">
                        <div class="card-body">
                            <h5 class="card-title">${book.title}</h5>
                            <h6 class="card-subtitle mb-2 text-muted">By ${book.author}</h6>
                            <p class="card-text text-truncate">${book.description}</p>
                            <p class="text-success">Available: ${book.copiesAvailable} / ${book.copies}</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="badge bg-secondary">${book.category}</span>
                                <a href="${pageContext.request.contextPath}/api/books/${book.id}" class="btn btn-sm btn-primary">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Pagination -->
        <nav aria-label="Page navigation" class="mt-4">
            <ul class="pagination">
                <c:if test="${currentPage > 0}">
                    <li class="page-item">
                        <a class="page-link" href="?page=0&size=${size}&sortBy=${sortBy}&direction=${direction}" aria-label="First">
                            <span aria-hidden="true">&laquo;&laquo;</span>
                        </a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="?page=${currentPage - 1}&size=${size}&sortBy=${sortBy}&direction=${direction}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                
                <c:forEach var="i" begin="0" end="${totalPages - 1}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <li class="page-item active"><a class="page-link" href="#">${i + 1}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="?page=${i}&size=${size}&sortBy=${sortBy}&direction=${direction}">${i + 1}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                <c:if test="${currentPage < totalPages - 1}">
                    <li class="page-item">
                        <a class="page-link" href="?page=${currentPage + 1}&size=${size}&sortBy=${sortBy}&direction=${direction}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="?page=${totalPages - 1}&size=${size}&sortBy=${sortBy}&direction=${direction}" aria-label="Last">
                            <span aria-hidden="true">&raquo;&raquo;</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>

        <!-- Sort Controls -->
        <div class="sort-controls text-end mb-4">
            <div class="btn-group">
                <button type="button" class="btn btn-outline-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                    Sort By
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="?page=${currentPage}&size=${size}&sortBy=title&direction=asc">Title (A-Z)</a></li>
                    <li><a class="dropdown-item" href="?page=${currentPage}&size=${size}&sortBy=title&direction=desc">Title (Z-A)</a></li>
                    <li><a class="dropdown-item" href="?page=${currentPage}&size=${size}&sortBy=author&direction=asc">Author (A-Z)</a></li>
                    <li><a class="dropdown-item" href="?page=${currentPage}&size=${size}&sortBy=author&direction=desc">Author (Z-A)</a></li>
                    <li><a class="dropdown-item" href="?page=${currentPage}&size=${size}&sortBy=category&direction=asc">Category</a></li>
                </ul>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>