<!DOCTYPE html>
<html>
<head>
    <title>Personal Information</title>
    <jsp:include page="/WEB-INF/fragments/user-header.jsp" />

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
            margin-top: 40px;
            text-align: center;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: #333;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 3px;
            border: 1px solid #ccc;
        }

        button[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
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
        .btn-update{
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
        .btn-update:hover {
            background-color: #FFAD33;
            border-color: #FFAD33;
        }
    </style>
</head>
<body>
<div class="title-wrapper">
    <div class="line"></div>
    <h2 class="title">Personal Information</h2>
    <div class="line"></div>
</div>
<br>
<form action="${pageContext.request.contextPath}/user/${appuser.username}/personalinformation/updateInfo" method="POST" modelAttribute="appuser">
    <label for="username">Username:</label>
    <input type="text" id="username" name="username" value="${appuser.username}" readonly>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" value="${appuser.password}">

    <label for="fullname">Full Name:</label>
    <input type="text" id="fullname" name="fullname" value="${appuser.fullname}">

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" value="${appuser.email}">

    <label for="deliveryaddress">Delivery Address:</label>
    <input type="text" id="deliveryaddress" name="deliveryaddress" value="${appuser.deliveryaddress}">

    <button type="submit" class="btn-update">Save Changes</button>
</form>
<br>
<br>
</body>
<footer>
    <jsp:include page="/WEB-INF/fragments/footer.jsp" />
</footer>
</html>