<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Book</title>
</head>
<body>

<h2>Add New Book</h2>

<form method="post" action="/books/add" enctype="multipart/form-data">
    <label>Title: <input type="text" name="title" required></label><br><br>
    <label>Author: <input type="text" name="author" required></label><br><br>
    <label>Description: <textarea name="description" required></textarea></label><br><br>
    <label>Copies: <input type="number" name="copies" min="1" required></label><br><br>
    <label>Category: <input type="text" name="category" required></label><br><br>
    
    <label>Upload Image: <input type="file" name="imageFile" accept="image/*"></label><br><br>

    <!-- Hardcoded token for test purpose, should be replaced by real auth in prod -->
    <input type="hidden" name="token" value="Bearer dummy-admin-token">

    <button type="submit">Submit</button>
</form>

</body>
</html>
