<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Library System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card border-danger shadow">
                    <div class="card-header bg-danger text-white">
                        <h4 class="mb-0">Error</h4>
                    </div>
                    <div class="card-body">
                        <p class="fs-5 mb-4">Sorry, an error occurred while processing your request.</p>
                        
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger">
                                ${errorMessage}
                            </div>
                        </c:if>
                        
                        <div class="d-grid gap-2 d-md-flex justify-content-md-center mt-4">
                            <a href="${pageContext.request.contextPath}/books" class="btn btn-outline-primary me-md-2">Return to Book List</a>
                            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">Return to Home</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>