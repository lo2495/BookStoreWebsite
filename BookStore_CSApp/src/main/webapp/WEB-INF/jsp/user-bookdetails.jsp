<!DOCTYPE html>
<html>
<head>
    <title>Book Details</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            padding: 20px;
            background-color: #F5F5F5 !important;
            font-family: Arial, sans-serif;
        }

        h1 {
            margin-bottom: 30px;
            color: #333333;
        }

        .book-details {
            width: 80%;
            margin: 0 auto;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            border: 1px solid #e7e7e7;
            border-radius: 5px;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
            padding: 30px;
        }

        .book-image {
            flex-basis: 30%;
            text-align: center;
            padding: 10px;
        }

        .book-image img {
            width: 100%;
            max-width: 300px;
            height: auto;
            border-radius: 5px;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .book-info {
            flex-basis: 70%;
            padding: 10px;
        }

        .book-info h2 {
            font-size: 24px;
            font-weight: bold;
            color: #333333;
            margin-bottom: 15px;
        }

        .book-info p {
            margin-bottom: 10px;
            color: #555555;
        }

        .description, .comments{
            width: 80%;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            text-align: left;
            position: relative;
            background-color: #ffffff;
        }

        .comment-list {
            list-style-type: none;
            padding: 0;
        }

        .comment-list li {
            margin-bottom: 20px;
            border-bottom: 1px solid #e7e7e7;
            padding-bottom: 10px;
        }

        .comment-list li:last-child {
            border-bottom: none;
        }

        .comment-username {
            font-weight: bold;
            color: #333333;
        }

        .comment-timestamp {
            color: #777777;
        }

        .comment-content {
            margin-top: 5px;
            color: #555555;
        }

        .comment-form {
            margin-top: 30px;
        }

        .comment-form textarea {
            width: 100%;
            height: 100px;
            resize: vertical;
            padding: 10px;
        }

        .comment-form button {
            margin-top: 10px;
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
        .price {
            font-size: 28px;
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
            width: 250px;
            height: 60px;
            font-size: 28px;
            text-decoration: none;
        }
        .btn-add-comment{
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #E1D5C5;
            color: black;
            border: none;
            border-radius: 5%;
            cursor: pointer;
            width: 300px;
            height: 45px;
            font-size: 28px;
            text-decoration: none;
        }
        .btn-add-to-cart:hover, .btn-add-comment:hover {
            background-color: #FFAD33;
            border-color: #FFAD33;
        }
        .title-line {
            bottom: 0;
            left: 0;
            width: 100%;
            height: 2px;
            background-color: #C3B2A2;
        }
        footer {
            width: 100%;
            text-align: center;
        }

        footer p {
            margin-bottom: 0;
        }

        header {
            width: 100%;
            text-align: center;
        }

        header h1 {
            margin-bottom: 0;
        }

    </style>
    <jsp:include page="/WEB-INF/fragments/user-header.jsp" />
</head>
<body>
<div class="title-wrapper">
    <div class="line"></div>
    <h2 class="title">Book Details</h2>
    <div class="line"></div>
</div>
<br>
<div class="book-details">
    <div class="book-image">
        <img src="${pageContext.request.contextPath}/user/${username}/bookdetails/coverPhoto/${coverPhoto.id}" alt="Cover Photo">
    </div>
    <div class="book-info">
        <h1 class="book-title">${book.bookname}</h1>
        <p><strong>Author:</strong> ${book.author}</p>
        <p><strong>In stock:</strong> ${book.quantity}</p>
        <h4 class = "price"><strong>Price:$</strong> ${book.price}</h4>
        <br><br>
        <a href="/shoppingCart/addProduct/${book.book_id}" class="btn-add-to-cart"><i class="fas fa-shopping-cart fa-sm"></i> Add to Cart</a>
    </div>
</div>
<br>
<div class="description">
    <h2><i class="fas fa-book fa-sm"></i> Summary</h2>
    <div class="title-line"></div><br>
    <p>${book.description}</p>
</div>
<br>
<div class="comments">
    <h2><i class="fas fa-comment fa-sm"></i> Comments</h2>
    <div class="title-line"></div><br>
    <ul class="comment-list">
        <c:forEach var="comment" items="${comments}">
            <li>
                <span class="comment-username">${comment.username}</span>
                <span class="comment-timestamp">
                    <fmt:formatDate value="${comment.timestamp}" pattern="yyyy/MM/dd HH:mm"/>
                </span>
                <p class="comment-content">${comment.content}</p>
            </li>
        </c:forEach>
    </ul>
    <div class="comment-form">
        <form action="${pageContext.request.contextPath}/user/${username}/bookdetails/${bookId}/addComment" method="post">
            <div class="form-group">
                <textarea class="form-control" name="content" rows="4" placeholder="Write your comment..." required></textarea>
            </div>
            <button type="submit" class="btn-add-comment"><i class="fas fa-pencil-alt fa-xs"></i>Write a Comment</button>
        </form>
    </div>
</div>
<br>
<br>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
<footer>
    <jsp:include page="/WEB-INF/fragments/footer.jsp" />
</footer>
</body>
</html>