<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order History</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
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
        .order-table {
            width: 100%;
            margin-bottom: 20px;
        }
        .order-table th,
        .order-table td {
            text-align: left;
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }
        .order-table thead th {
            border-bottom: 2px solid #ddd;
        }
        .order-table tbody tr:last-child td {
            border-bottom: none;
        }
        .order-details-btn {
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
        .order-details-btn:hover {
            background-color: #FFAD33;
            border-color: #FFAD33;
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
        <h2 class="title">Order History</h2>
        <div class="line"></div>
    </div>
    <br>
    <table class="order-table">
        <thead>
        <tr>
            <th>Order No</th>
            <th>Order Date</th>
            <th>Payment Method</th>
            <th>Total Price</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${orders}">
            <tr>
                <td>${order.id}</td>
                <td>${order.orderDateTime}</td>
                <td>Cash</td>
                <td>$${order.totalPrice}</td>
                <td><a href="/user/${username}/orderdetails/${order.id}" class="order-details-btn"></i>Details</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
<footer>
    <jsp:include page="/WEB-INF/fragments/footer.jsp" />
</footer>
</html>