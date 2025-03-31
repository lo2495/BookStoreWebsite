<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        body {
            padding: 20px;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 1200px;
        }
        .card {
            margin-bottom: 20px;
            border: none;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
        }
        .card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .card-img-top {
            max-height: 250px;
            object-fit: contain;
            border-top-left-radius: 4px;
            border-top-right-radius: 4px;
        }
        .card-body {
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        .card-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .card-text {
            margin-bottom: 10px;
            font-size: 12px;
        }
        .card-price {
            font-size: 20px;
            font-weight: bold;
            color: #B12704;
            margin-top: 10px;
        }
        .btn-add-to-cart {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #E1D5C5;
            color: black;
            border: none;
            border-radius: 5%;
            cursor: pointer;
            width: 150px;
            height: 40px;
            font-size: 0.8rem;
            text-decoration: none;
        }
        .btn-add-to-cart:hover {
            background-color: #FFAD33;
            border-color: #FFAD33;
        }
        .banner-img {
            width: 100%;
            max-height: 550px;
        }
        .title-wrapper {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 20px;
        }

        .line {
            flex: 1;
            height: 3px;
            background-color: #C3B2A2;
            margin: 0 10px;
        }

        .title {
            margin: 0;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="banner-image">
        <img src="https://as2.ftcdn.net/v2/jpg/04/32/48/41/1000_F_432484156_zwHX2X7Vc7KR2LIlp5cgsCc2achOBtl0.jpg" alt="Banner Image" class="banner-img">
    </div>
    <div class="title-wrapper">
        <div class="line"></div>
        <h2 class="title">Today's Feature Books</h2>
        <div class="line"></div>
    </div>
    <br>
    <c:choose>
        <c:when test="${fn:length(bookDatabase) == 0}">
            <div class="text-center mt-5">
                <h3>There are no books in the system.</h3>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <c:forEach items="${bookDatabase}" var="entry">
                    <c:if test="${entry.availability && entry.quantity > 0}">
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="card">
                                <img src="${pageContext.request.contextPath}/coverPhoto/${coverPhoto[entry.book_id].id}" alt="Cover Photo" class="card-img-top">
                                <div class="card-body">
                                    <h5 class="card-title">
                                        <c:if test="${not empty username}">
                                            <a href="/user/${username}/bookdetails/${entry.book_id}">${entry.bookname}</a>
                                        </c:if>
                                        <c:if test="${empty username}">
                                            ${entry.bookname}
                                        </c:if>
                                    </h5>
                                    <p class="card-text">Author: ${entry.author}</p>
                                    <h6 class="card-price">$${entry.price}</h6>
                                    <security:authorize access="hasRole('USER')">
                                        <a href="/shoppingCart/addProduct/${entry.book_id}" class="btn-add-to-cart"><i class="fas fa-shopping-cart fa-sm"></i> Add to Cart</a>
                                    </security:authorize>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
<script>
</script>
</body>
</html>