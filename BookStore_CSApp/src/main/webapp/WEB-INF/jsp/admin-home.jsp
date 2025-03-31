<!DOCTYPE html>
<html>
<head>
    <title>Admin Home</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #dddddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
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
</head>
<body>
<jsp:include page="/WEB-INF/fragments/admin-header.jsp" />
<div class="content-container">
    <h1>Welcome, ${username}!</h1>
    <c:choose>
        <c:when test="${fn:length(bookDatabase) == 0}">
            <i>There are no books in the system.</i>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                <tr>
                    <th>Book ID</th>
                    <th>Book Name</th>
                    <th>Author</th>
                    <th>Price</th>
                    <th>Description</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${bookDatabase}" var="entry">
                    <tr>
                        <td>${entry.book_id}</td>
                        <td>${entry.bookname}</td>
                        <td>${entry.author}</td>
                        <td>$${entry.price}</td>
                        <td>${entry.description}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>