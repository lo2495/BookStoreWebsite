<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart</title>
    <jsp:include page="/WEB-INF/fragments/user-header.jsp" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #F5F5F5 !important;
            padding: 20px;
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

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        h1 {
            margin-top: 40px;
            text-align: center;
        }

        hr {
            margin-top: 20px;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .card {
            width: 100%;
            margin-bottom: 20px;
        }

        .card-title {
            font-size: 24px;
            margin-bottom: 5px;
        }

        .card-text {
            color: #666;
        }

        .card-img-top {
            max-height: 200px;
            max-width: 100px;
            margin-left: 40px;
            margin-right: 40px;
            object-fit: contain;
        }
        .card-body {
             display: flex;
             align-items: center;
         }
        .remove-checkbox {
            margin-right: 10px;
            margin-left: 10px;
            transform: scale(1.5);
        }

        .price {
            font-weight: bold;
            margin-right: 20px;
            color:red;
        }

        .quantity {
            margin-right: 20px;
        }
        .quantity input[type="number"] {
            max-width: 100px;
        }
        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
            margin-top: 10px;
        }

        .btn-checkout{
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
            margin-left: auto;
        }
        .btn-checkout:hover {
            background-color: #FFAD33;
            border-color: #FFAD33;
        }
        .card-text-wrapper {
            flex-grow: 1;
            margin-left: 20px;
        }
        .totalPrice{
            margin-left: auto;
            display: flex;
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
    <div class="title-wrapper">
        <div class="line"></div>
        <h2 class="title">Shopping Cart</h2>
        <div class="line"></div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <c:if test="${not empty outOfStockMessage}">
                <div class="alert alert-danger" role="alert">
                        ${outOfStockMessage}
                </div>
            </c:if>
            <form action="/shoppingCart/removeProducts" method="post" onsubmit="return validateForm()">
                <div class="card-container">
                    <c:forEach var="entry" items="${books}">
                        <div class="card">
                            <div class="card-body">
                                <input type="checkbox" name="selectedBooks" id="selectedBooks" value="${entry.key.book_id}" class="remove-checkbox">
                                <img src="${pageContext.request.contextPath}/coverPhoto/${coverPhoto[entry.key.book_id].id}" alt="Cover Photo" class="card-img-top">
                                <div class="card-text-wrapper">
                                    <h5 class="card-title"><a href="/user/${username}/bookdetails/${entry.key.book_id}">${entry.key.bookname}</a></h5>
                                    <p class="card-text">${entry.key.author}</p>
                                    <p class="card-text">In stock: ${entry.key.quantity}</p>
                                </div>
                                <div class="quantity">
                                    <input type="hidden" name="bookId" value="${entry.key.book_id}">
                                    <input type="number" name="quantity" value="${entry.value}" min="1" onchange="updateQuantity(this)">
                                </div>
                                <p class="price">Price: $${entry.value * entry.key.price}</p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="card">
                    <div class="card-body">
                        <button type="submit" class="btn btn-danger">Remove Selected</button>
                        <h3 class="totalPrice">Total: $<span id="totalPrice">${total}</span></h3>
                        <a href="/shoppingCart/checkout/${username}" class="btn-checkout">Checkout</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
    function validateForm() {
        const checkboxes = document.querySelectorAll('input[name="selectedBooks"]');
        let checked = false;
        checkboxes.forEach(checkbox => {
            if (checkbox.checked) {
                checked = true;
            }
        });
        if (!checked) {
            alert('Please select at least one book to remove.');
            return false;
        }
        return true;
    }

    function updateQuantity(input) {
        const quantity = parseInt(input.value);
        const bookId = input.closest('.quantity').querySelector('input[name="bookId"]').value;
        axios.post('/shoppingCart/updateQuantity', {bookId, quantity })
            .then(response => {
                console.log(response.data);
                const totalPriceElement = document.getElementById('totalPrice');
                totalPriceElement.textContent = response.data;
            })
            .catch(error => {
                console.error(error);
            });
        return false;
    }
</script>
<footer>
    <jsp:include page="/WEB-INF/fragments/footer.jsp" />
</footer>
</body>