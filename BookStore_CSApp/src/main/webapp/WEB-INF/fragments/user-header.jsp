<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css">
    <style>
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .nav-link {
            font-size: 1.2rem;
            margin-right: 20px;
        }
        .bg-custom {
            background-color: #E1D5C5;
        }
    </style>
</head>
<body>
<div class="header">
    <nav class="navbar navbar-expand-lg navbar-light bg-custom">
        <div class="container">
            <a class="navbar-brand" href="#">Welcome to My Website</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/user/${username}">Home</a>
                    </li>
                    <security:authorize access="hasRole('ADMIN')">
                        <li class="nav-item">
                            <a class="nav-link" href="/admin/${username}">Admin DashBoard</a>
                        </li>
                    </security:authorize>
                    <li class="nav-item">
                        <a class="nav-link" href="/shoppingCart">Cart</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/user/${username}/orderhistory">Order History</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/user/${username}/personalinformation">Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/logout">Log Out</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>