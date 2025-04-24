
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" 
          rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" 
          crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <!-- You would include your header/navbar here -->
    
    <jsp:include page="components/ExploreTopBooks.jsp" />
    
    <%-- Carousel component requires books data to be fetched by the controller --%>
    <jsp:include page="components/Carousel.jsp" />
    
    <jsp:include page="components/Heros.jsp" />
    
    <jsp:include page="components/LibraryServices.jsp" />
    
    <!-- You would include your footer here -->
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" 
            crossorigin="anonymous"></script>
</body>
</html>