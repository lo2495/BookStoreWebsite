<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
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

        .add-user-button {
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

        .add-user-button:hover {
            background-color: #45a049;
        }
    </style>
    <script>
        function showAddUserDialog() {
            document.getElementById("dialogContainer").style.display = "block";
        }

        function closeDialog() {
            document.getElementById("dialogContainer").style.display = "none";
        }

        function editUser(editusername,editpassword,editfullname,editemail,editdelivery) {
            document.getElementById("editUsername").value = editusername;
            document.getElementById("editPassword").value = editpassword;
            document.getElementById("editFullName").value = editfullname;
            document.getElementById("editEmail").value = editemail;
            document.getElementById("editDeliveryAddress").value = editdelivery;
            document.getElementById("editForm").action = "${pageContext.request.contextPath}/admin/${username} /usermanagement/edit/" + document.getElementById("editUsername").value;
            document.getElementById("editDialogContainer").style.display = "block";
        }

        function closeEditDialog() {
            document.getElementById("editDialogContainer").style.display = "none";
        }

        function deleteUser(username) {
            if (confirm('Are you sure you want to delete this user?')) {
                fetch(`/admin/${username}/usermanagement/delete/`+username, {
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
            table = document.getElementById("user-table");
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
<h1>User Management</h1>
    <button class="add-user-button" onclick="showAddUserDialog()">Add New User</button>
<div id="dialogContainer" class="dialog-container">
    <div class="dialog-box">
        <h2>Add New User</h2>
        <form action="${pageContext.request.contextPath}/admin/${username}/usermanagement/adduser" method="POST">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required="required"/><br>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required="required"/><br>

            <label for="fullname">Full Name:</label>
            <input type="text" id="fullname" name="fullname" required="required"/><br>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required="required"/><br>

            <label for="deliveryaddress">Delivery Address:</label>
            <input type="text" id="deliveryaddress" name="deliveryaddress" required="required"/><br>

            <label for="userrole">User Role:</label>
            <select id="userrole" name="userrole">
                <option value="ROLE_USER">User</option>
                <option value="ROLE_ADMIN">Admin</option>
            </select><br>
            <button type="submit">Add User</button>
            <button type="button" onclick="closeDialog()">Cancel</button>
        </form>
    </div>
</div>
<div id="editDialogContainer" class="dialog-container">
    <div class="dialog-box">
        <h2>Edit User</h2>
        <form id="editForm" method="POST">
            <label for="editUsername">Username:</label>
            <input type="text" id="editUsername" name="username" readonly="readonly" /><br>
            <label for="editPassword">Password:</label>
            <input type="password" id="editPassword" name="password" required="required"/><br>

            <label for="editFullName">Full Name:</label>
            <input type="text" id="editFullName" name="fullname" required="required"/><br>

            <label for="editEmail">Email:</label>
            <input type="email" id="editEmail" name="email" required="required"/><br>

            <label for="editDeliveryAddress">Delivery Address:</label>
            <input type="text" id="editDeliveryAddress" name="deliveryaddress" required="required"/><br>

            <button type="submit">Save</button>
            <button type="button" onclick="closeEditDialog()">Cancel</button>
        </form>
    </div>
</div>
    <div class ="table-container">
<table id="user-table">
    <thead>
    <tr>
        <th class="sortable" id="header-0" onclick="sortTable(0)">UserName</th>
        <th class="sortable" id="header-1" onclick="sortTable(0)">Password</th>
        <th class="sortable" id="header-2" onclick="sortTable(0)">Full Name</th>
        <th class="sortable" id="header-3" onclick="sortTable(0)">Email</th>
        <th class="sortable" id="header-4" onclick="sortTable(0)">Delivery Address</th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${userList}" var="user">
        <tr>
            <td>${user.username}</td>
            <td>${user.password}</td>
            <td>${user.fullname}</td>
            <td>${user.email}</td>
            <td>${user.deliveryaddress}</td>
            <td>
                <button onclick="editUser('${user.username}','${user.password}','${user.fullname}','${user.email}','${user.deliveryaddress}')">Edit</button>
                <button onclick="deleteUser('${user.username}')">Delete</button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
    </div>
</div>
</body>
</html>