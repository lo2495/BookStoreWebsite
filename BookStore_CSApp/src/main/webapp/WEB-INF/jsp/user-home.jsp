<!DOCTYPE html>
<html>
<head>
    <title>User Home</title>
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
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/fragments/list.jsp" />
</body>
<footer>
    <jsp:include page="/WEB-INF/fragments/footer.jsp" />
</footer>
</html>