<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <jsp:include page="/WEB-INF/fragments/user-header.jsp" />

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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

        .form-row {
            margin-bottom: 20px;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
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
        <h2 class="title">Check Out</h2>
        <div class="line"></div>
    </div>
    <br>
    <form action="/shoppingCart/processPayment" method="post">
        <div class="form-row">
            <label for="total">Total Price:</label>
            <input type="text" id="total" name="total" value="${total}" readonly>
        </div>
        <div class="form-row">
            <label for="paymentMethod">Payment Method:</label>
            <select id="paymentMethod" name="paymentMethod">
                <option value="creditCard">Credit Card</option>
                <option value="paypal">PayPal</option>
                <option value="bankTransfer">Bank Transfer</option>
            </select>
        </div>
        <div class="form-row">
            <input type="submit" value="Proceed to Payment" class="btn btn-primary">
        </div>
    </form>
</div>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
<footer>
    <jsp:include page="/WEB-INF/fragments/footer.jsp" />
</footer>
</html>