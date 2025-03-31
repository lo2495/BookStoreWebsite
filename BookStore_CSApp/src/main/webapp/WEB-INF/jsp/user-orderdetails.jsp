<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body{
            background-color: #F5F5F5 !important;
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
        h1 {
            margin-bottom: 20px;
            text-align: center;
        }
        .order-info {
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            background-color: #f5f5f5;
        }
        .order-info p {
            margin: 0;
        }
        .order-items {
            width: 100%;
            margin-bottom: 20px;
        }
        .order-items th,
        .order-items td {
            text-align: left;
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }
        .order-items thead th {
            border-bottom: 2px solid #ddd;
        }
        .order-items tbody tr:last-child td {
            border-bottom: none;
        }
        .book-cover {
            max-height: 200px;
            max-width: 100px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 10px;
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
    <jsp:include page="/WEB-INF/fragments/user-header.jsp" />
</head>
<body>
<div class="container">
    <div class="title-wrapper">
        <div class="line"></div>
        <h2 class="title">Order Details</h2>
        <div class="line"></div>
    </div>
    <br>

    <div class="order-info">
        <p>Order Number: ${order.id}</p>
        <p>Username: ${order.username}</p>
        <p>Order Date: ${order.orderDateTime}</p>
    </div>
    <div class="title-wrapper">
    <h2>Order Items</h2> <div class="line"></div>
    </div>
    <table class="order-items">
        <thead>
        <tr>
            <th></th>
            <th>Book Name</th>
            <th>Author</th>
            <th>Quantity</th>
            <th>Price</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${order.items}">
            <tr>
                <td>
                    <img src="${pageContext.request.contextPath}/coverPhoto/${coverPhotos[item.key.book_id].id}" alt="Cover Photo" class="book-cover">
                </td>
                <td>${item.key.bookname}</td>
                <td>${item.key.author}</td>
                <td>${item.value}</td>
                <td>$${item.value * item.key.price}</td>
            </tr>
        </c:forEach>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="3"></td>
            <td colspan="2"><strong>Total Price: $${order.totalPrice}</strong></td>
        </tr>
        </tfoot>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
<footer>
    <jsp:include page="/WEB-INF/fragments/footer.jsp" />
</footer>
</html>