<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Book Shop Footer</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css">
    <style>
        .footer {
            background-color: #E1D5C5;
            padding: 30px 0;
            color: #333;
        }

        .footer .footer-container {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .footer h5 {
            margin-bottom: 10px;
            font-weight: bold;
        }

        .footer ul {
            list-style-type: none;
            padding: 0;
        }

        .footer li {
            margin-bottom: 5px;
        }

        .footer a {
            color: #333;
            text-decoration: none;
        }

        .footer form {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
        }

        .footer input[type="email"] {
            width: 70%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-right: 10px;
        }

        .footer button[type="submit"] {
            background-color: #333;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .footer button[type="submit"]:hover {
            background-color: #444;
        }

        .footer hr {
            border: none;
            border-top: 1px solid #ccc;
            margin: 20px 0;
        }

        .footer p {
            margin: 10px 0;
        }

        .footer-section {
            flex: 1;
            padding: 0 20px;
        }

        .footer-section:first-child {
            flex: 2;
        }

        .footer-section:last-child {
            flex: 1;
        }

        @media (max-width: 768px) {
            .footer-container {
                flex-direction: column;
            }

            .footer-section {
                padding: 20px 0;
            }

            .footer-section:first-child {
                flex: 1;
            }

            .footer-section:last-child {
                flex: 1;
            }
        }
    </style>
</head>
<body>
<footer class="footer">
    <div class="container">
        <div class="footer-container">
            <div class="footer-section">
                <h5>Student Information</h5>
                <ul>
                    <li>Name: Lo Hi Yeung</li>
                    <li>Student Id: 13424079</li>
                    <li>Major: Computer Science</li>
                </ul>
            </div>
            <div class="footer-section">
                <h5>Project Information</h5>
                <ul>
                    <li>Course Title: COMP S380F Web Applications: Design And Development</li>
                    <li>Project Topic: Online Book Shop</li>
                    <li>Project Name: BookStore_CSApp</li>
                </ul>
            </div>
        </div>
        <hr>
        <p class="text-center">&copy; 2024 Book Shop. All rights reserved.</p>
    </div>
</footer>
</body>
</html>