<!DOCTYPE html>
<html>
<head>
    <title>Book Details</Title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            overflow: hidden;
        }
        .book-details {
            background-color: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 5px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
        }
        .book-details label {
            display: inline-block;
            width: 150px;
            font-weight: bold;
        }
        .book-details input[type="text"], .book-details input[type="checkbox"] {
            width: 300px;
            padding: 5px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .book-details button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
        }
        .book-details button:hover {
            background-color: #45a049;
        }
        .comments {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
        }
        .comments li {
            list-style: none;
            margin-bottom: 20px;
        }
        .comment-username {
            font-weight: bold;
        }
        .comment-timestamp {
            font-size: 0.8em;
            color: #666;
            margin-left: 10px;
        }
        .comment-content {
            margin-top: 10px;
        }
        .comments form {
            margin-top: 20px;
        }
        .comments textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 10px;
        }
        .comments button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
        }
        .comments button:hover {
            background-color: #45a049;
        }
        .content-container {
            transition: transform 0.3s ease-out;
        }

        .nav-menu.open ~ .content-container {
            transform: translateX(300px);
        }

        .content-container.menu-open {
            transform: translateX(300px);
        }
    </style>
    <jsp:include page="/WEB-INF/fragments/admin-header.jsp" />
</head>
<body>
<div class ="content-container">
<div class="container">
    <div class="book-details">
        <h1>Book Details</h1>
        <form:form action="${pageContext.request.contextPath}/admin/${username}/inventorymanagement/savebook" method="POST" modelAttribute="book" enctype="multipart/form-data">
            <label for="book_id">Book Id:</label>
            <input type="text" id="book_id" name="book_id" value="${book.book_id}"><br>

            <label for="bookname">Book Name:</label>
            <input type="text" id="bookname" name="bookname" value="${book.bookname}"><br>

            <label for="author">Author:</label>
            <input type="text" id="author" name="author" value="${book.author}"><br>

            <label for="price">Price:</label>
            <input type="text" id="price" name="price" value="${book.price}"><br>

            <label for="description">Description:</label>
            <input type="text" id="description" name="description" value="${book.description}"><br>

            <label for="availability">Availability:</label>
            <input type="checkbox" id="availability" name="availability" checked><br>

            <label for="quantity">Quantity:</label>
            <input type="text" id="quantity" name="quantity" value="${book.quantity}"><br>

            <c:if test="${not empty coverPhoto}">
                <h2>Cover Photo</h2>
                <img src="${pageContext.request.contextPath}/admin/{username}/inventorymanagement/coverPhoto/${coverPhoto.id}" alt="Cover Photo">
            </c:if>
            <button type="submit">Save Changes</button>
        </form:form>
    </div>
    <div class="comments">
        <h2>Comments</h2>

        <form action="${pageContext.request.contextPath}/admin/${username}/inventorymanagement/addComment/${bookId}" method="POST">
            <input type="hidden" name="bookId" value="${bookId}">
            <textarea name="content" placeholder="Add a comment"></textarea>
            <button type="submit">Add Comment</button>
        </form>

        <c:forEach items="${comments}" var="comment">
            <li>
                <span class="comment-username">${comment.username}</span>
                <span class="comment-timestamp">
                        <fmt:formatDate value="${comment.timestamp}" pattern="yyyy/MM/dd HH:mm"/>
                    </span>
                <p class="comment-content">${comment.content}</p>
            </li>
            <button onclick="deleteComment('${comment.id}')">delete </button>
        </c:forEach>
    </div>
</div>
</div>
</body>
</html>
<script>
    function deleteComment(commentid) {
        if (confirm('Are you sure you want to delete this comment?')) {
            fetch(`/admin/${username}/inventorymanagement/${bookId}/deleteComment/`+commentid, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
                .then(response => {
                    if (response.ok) {
                        location.reload();
                    } else {
                        throw new Error('Error deleting user');
                    }
                })
                .catch(error => {
                    alert('Error deleting user: ' + error.message);
                });
        }
    }
</script>
</html>