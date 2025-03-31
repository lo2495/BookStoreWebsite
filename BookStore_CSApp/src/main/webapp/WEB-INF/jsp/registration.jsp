<!DOCTYPE html>
<html>
<head>
    <title>Registration</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css">
    <style>
        body {
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #F5F5F5 !important;
        }

        .registration-form {
            max-width: 400px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        .registration-form h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-control {
            margin-bottom: 20px;
        }

        .submit-button {
            display: flex;
            justify-content: center;
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
        .btn-register{
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #E1D5C5;
            color: black;
            border: none;
            border-radius: 5%;
            cursor: pointer;
            width: 100%;
            height: 40px;
            font-size: 0.8rem;
        }
        .login-link {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<header>
    <jsp:include page="/WEB-INF/fragments/header.jsp" />
</header>
<br>
<br>
<br>
<br>
<br>
<br>
<div class="container">
    <div class="registration-form">
        <h2>Registration</h2>
        <form action="${pageContext.request.contextPath}/process_registration" method="POST">
            <div class="mb-3">
                <input type="text" id="username" name="username" class="form-control" placeholder="Enter your Username" required>
            </div>
            <br>
            <div class="mb-3">
                <input type="password" id="password" name="password" class="form-control" placeholder="Enter your Password" required>
            </div>
            <br>
            <div class="mb-3">
                <input type="text" id="fullname" name="fullname" class="form-control" placeholder="Enter your Full Name" required>
            </div>
            <br>
            <div class="mb-3">
                <input type="email" id="email" name="email" class="form-control" placeholder="Enter your Email" required>
            </div>
            <br>
            <div class="mb-3">
                <input type="text" id="deliveryaddress" name="deliveryaddress" class="form-control" placeholder="Enter your Delivery Address" required>
            </div>
            <br>
            <div class="submit-button">
                <button type="submit" class="btn-register">Register</button>
            </div>
        </form>
        <div class="login-link">
            <p>Already have an account?</p>
            <a href="login">Login Here!</a>
        </div>
    </div>
</div>
<br>
<br>
<br>
<br>
<br>
<br>
<footer>
    <jsp:include page="/WEB-INF/fragments/footer.jsp" />
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>