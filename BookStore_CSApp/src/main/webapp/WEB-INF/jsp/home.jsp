<!DOCTYPE html>
<html>
<head>
    <title>Online Shop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
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
    <jsp:include page="/WEB-INF/fragments/header.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/fragments/list.jsp" />
<script>
    var systemMessage = "${systemMessage}";
    if (systemMessage === "true") {
        var successMessage = "${successMessage}";
        alert(successMessage);
    }
</script>
<footer>
    <jsp:include page="/WEB-INF/fragments/footer.jsp" />
</footer>
</body>
</html>