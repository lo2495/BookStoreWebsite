<!DOCTYPE html>
<html>
<head>
    <title>Inventory Management</title>
    <style>
        .dialog-container {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 2;
        }

        .dialog-box {
            position: relative;
            margin: 10% auto;
            padding: 20px;
            width: 50%;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }

        .dialog-box h2 {
            margin-top: 0;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
            text-align: center;
        }

        .dialog-box label {
            display: block;
            margin-bottom: 5px;
            font-size: 16px;
            font-weight: bold;
        }

        .dialog-box input,
        .dialog-box select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .dialog-box button {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            color: #fff;
            background-color: #4CAF50;
            cursor: pointer;
        }

        .dialog-box button:hover {
            background-color: #45a049;
        }

        .dialog-box .close-button {
            position: absolute;
            top: 0;
            right: 0;
            padding: 10px;
            font-size: 24px;
            color: #ccc;
            cursor: pointer;
        }

        .dialog-box .close-button:hover {
            color: #aaa;
        }
        .table-container {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 20px;
            margin: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th,
        td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        th.action {
            width: 150px;
        }

        tr:hover {
            background-color: #f5f5f5;
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
        .sortable {
            cursor: pointer;
        }

        .sortable:hover {
            background-color: #f2f2f2;
        }

        .sorted-asc:after {
            content: " ▲";
        }

        .sorted-desc:after {
            content: " ▼";
        }
        .add-book-button {
            display: inline-block;
            padding: 10px 20px;
            margin-bottom: 15px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            color: #fff;
            background-color: #4CAF50;
            cursor: pointer;
        }

        .add-book-button:hover {
            background-color: #45a049;
        }
    </style>
    <script>
        function showAddBookDialog() {
            document.getElementById("dialogContainer").style.display = "block";
        }

        function closeDialog() {
            document.getElementById("dialogContainer").style.display = "none";
        }
        function deleteBook(bookid) {
            if (confirm('Are you sure you want to delete this book?')) {
                fetch(`/admin/${username}/inventorymanagement/delete/`+bookid, {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                    .then(response => {
                        if (response.ok) {
                            location.reload();
                        } else {
                            throw new Error('Error deleting user');
                        }
                    })
                    .catch(error => {
                        alert('Error deleting user: ' + error.message);
                    });
            }
        }
        function sortTable(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("bookTable");
            switching = true;
            dir = "asc";
            while (switching) {
                switching = false;
                rows = table.rows;
                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    var cmpX, cmpY;
                    if (isNaN(x.innerHTML) || isNaN(y.innerHTML)) {
                        cmpX = x.innerHTML.toLowerCase();
                        cmpY = y.innerHTML.toLowerCase();
                    } else {
                        cmpX = parseInt(x.innerHTML);
                        cmpY = parseInt(y.innerHTML);
                    }
                    if ((dir === "asc" && cmpX > cmpY) || (dir === "desc" && cmpX < cmpY)) {
                        shouldSwitch = true;
                        break;
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount++;
                } else {
                    if (switchcount === 0 && dir === "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
            var headers = document.querySelectorAll("#bookTable th");
            for (var j = 0; j < headers.length; j++) {
                headers[j].classList.remove("sorted-asc");
                headers[j].classList.remove("sorted-desc");
            }
            var currentHeader = document.getElementById("header-" + n);
            if (dir === "asc") {
                currentHeader.classList.add("sorted-asc");
            } else {
                currentHeader.classList.add("sorted-desc");
            }
        }
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/fragments/admin-header.jsp" />
<div class="content-container">
    <h1>Inventory Management</h1>
    <a class="add-book-button" onclick="showAddBookDialog()">Add Book</a>
    <div id="dialogContainer" class="dialog-container">
        <div class="dialog-box">
            <h2>Add New Book</h2>
            <form action="/admin/${username}/inventorymanagement/addbook" method="POST" modelAttribute="BookForm" enctype="multipart/form-data">
                <label for="bookname">Book Name:</label>
                <input type="text" id="bookname" name="bookname" required="required" /><br>

                <label for="author">Author:</label>
                <input type="text" id="author" name="author" required="required" /><br>

                <label for="price">Price:</label>
                <input type="number" id="price" name="price" step="0.01" required="required" /><br>

                <label for="description">Description:</label>
                <input type="text" id="description" name="description" required="required" /><br>

                <label for="availability">Availability:</label>
                <select id="availability" name="availability" required="required">
                    <option value="TRUE">Available</option>
                    <option value="FALSE">Unavailable</option>
                </select><br>

                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" min="0" required="required" /><br>

                <label for="coverphoto">Cover Photo:</label>
                <input type="file" id="coverphoto" name="coverphoto" required="required" /><br>

                <button type="submit">Add Book</button>
                <button type="button" onclick="closeDialog()">Cancel</button>
            </form>
        </div>
    </div>
    <c:choose>
        <c:when test="${fn:length(bookDatabase) == 0}">
            <i>There are no books in the system.</i>
        </c:when>
        <c:otherwise>
            <div class="table-container">
                <table id="bookTable">
                    <thead>
                    <tr>
                        <th class="sortable" id="header-0" onclick="sortTable(0)">Book ID</th>
                        <th class="sortable" id="header-1" onclick="sortTable(1)">Book Name</th>
                        <th class="sortable" id="header-2" onclick="sortTable(2)">Author</th>
                        <th class="sortable" id="header-3" onclick="sortTable(3)">Price</th>
                        <th class="sortable" id="header-4" onclick="sortTable(4)">Availability</th>
                        <th class="sortable" id="header-5" onclick="sortTable(5)">Quantity</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${bookDatabase}" var="entry">
                        <tr>
                            <td>${entry.book_id}</td>
                            <td>${entry.bookname}</td>
                            <td>${entry.author}</td>
                            <td>${entry.price}</td>
                            <td>${entry.availability}</td>
                            <td>${entry.quantity}</td>
                            <td>
                                <a href="/admin/${username}/inventorymanagement/book/view/${entry.book_id}">
                                    <i class="fas fa-pencil-square"></i> <!-- Replace with appropriate icon class -->
                                </a>
                                <button onclick="deleteBook('${entry.book_id}')">
                                    <i class="fas fa-trash"></i> <!-- Replace with appropriate icon class -->
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
</c:choose>
</div>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
</html>