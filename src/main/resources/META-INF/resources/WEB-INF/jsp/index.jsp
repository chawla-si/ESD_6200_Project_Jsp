<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library - Books</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
        }
        th {
            background-color: #f2f2f2;
        }
        img {
            max-height: 100px;
        }
    </style>
</head>
<body>

<h2>Book List</h2>

<a href="/books/new">Add New Book</a>

<c:if test="${param.success == 'true'}">
    <p style="color:green;">Book added successfully!</p>
</c:if>

<c:if test="${param.deleted == 'true'}">
    <p style="color: red;">Book deleted successfully!</p>
</c:if>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Description</th>
            <th>Copies</th>
            <th>Copies Available</th>
            <th>Category</th>
            <th>Image</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="book" items="${books}">
            <tr>
                <td>${book.id}</td>
                <td>${book.title}</td>
                <td>${book.author}</td>
                <td>${book.description}</td>
                <td>${book.copies}</td>
                <td>${book.copiesAvailable}</td>
                <td>${book.category}</td>
                <td>
                    <c:if test="${not empty book.img}">
                        <img src="${book.img}" alt="Book Image"/>
                    </c:if>
                </td>
                <td>
                    <a href="/books/edit/${book.id}">Edit</a> |
                    <a href="/books/delete/${book.id}" onclick="return confirm('Are you sure?')">Delete</a> |
					<!-- Form to Increase Quantity -->
					<form action="/books/increase/${book.id}" method="post" style="display:inline;">
					    <input type="hidden" name="_method" value="put"/>
					    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
					    <button type="submit">Increase</button>
					</form> |
					   
					   <!-- Form to Decrease Quantity -->
					   <form action="/books/decrease/${book.id}" method="post" style="display:inline;">
					       <input type="hidden" name="_method" value="put"/>
					       <button type="submit">Decrease</button>
					   </form>
					                
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<!-- Pagination controls (optional) -->
<!--
<c:if test="${totalPages > 1}">
    <div>
        <c:forEach begin="0" end="${totalPages - 1}" var="i">
            <a href="/?page=${i}&size=5&sortBy=${sortBy}&direction=${direction}">${i + 1}</a>
        </c:forEach>
    </div>
</c:if>
-->

</body>

</html>
