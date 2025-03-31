<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin-Header</title>
    <style>
        header {
            position: relative;
            z-index: 2;
            background-color: #333 !important;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .nav-menu {
            position: fixed;
            height: 100%;
            left: 0;
            width: 250px;
            background-color: #333;
            color: #fff;
            padding: 20px;
            overflow-y: auto;
            transform: translateX(-100%);
            transition: transform 0.3s ease-out;
            z-index: 1;
        }

        .nav-menu.open {
            transform: translateX(0);
            width: 250px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }

        .nav-toggle {
            background-color: #333;
            color: #fff;
            border: none;
            padding: 10px;
            cursor: pointer;
            transition: transform 0.3s ease-out;
        }

        h1 {
            margin-right: auto;
        }

        .nav-toggle.open {
            z-index: 2;
        }

        .nav-toggle::before {
            content: "\2630";
            font-size: 24px;
        }

        .nav-menu ul {
            list-style-type: none; /* Remove the list points */
            padding: 0;
            margin: 0;
        }

        .nav-menu ul li {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .nav-menu ul li a {
            color: #fff;
            text-decoration: none;
            margin-left: 10px;
        }
    </style>
</head>
<body>
<header>
    <button class="nav-toggle" onclick="toggleNav()"></button>
    <h1>Welcome to My Website</h1>
</header>
<nav class="nav-menu">
    <ul>
        <li><a href="/admin/${username}"><i class="fas fa-home"></i> Home</a></li>
        <li><a href="/admin/${username}/usermanagement"><i class="fas fa-users"></i> User Management</a></li>
        <li><a href="/admin/${username}/inventorymanagement"><i class="fas fa-boxes"></i> Inventory Management</a></li>
        <li><a href="/user/${username}"><i class="fas fa-shopping-cart"></i> User Shopping Page</a></li>
        <li><a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
    </ul>
</nav>
<script>
    function toggleNav() {
        const navMenu = document.querySelector('.nav-menu');
        const navToggle = document.querySelector('.nav-toggle');
        const contentContainer = document.querySelector('.content-container');
        navMenu.classList.toggle('open');
        navToggle.classList.toggle('open');
        contentContainer.classList.toggle('menu-open');
    }
</script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
</body>
</html>