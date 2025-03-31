<!DOCTYPE html>
<html>
<head>
  <title>Customer Support Login</title>
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

    .login-form {
      max-width: 400px;
      margin: 0 auto;
      background-color: #ffffff;
      padding: 30px;
      border-radius: 5px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    }

    .login-form h2 {
      text-align: center;
      margin-bottom: 30px;
    }

    .form-control {
      margin-bottom: 20px;
    }

    .remember-me-label {
      font-weight: normal;
    }

    .signup-link {
      text-align: center;
      margin-top: 20px;
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

    .btn-login{
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
  <div class="login-form">
    <h2>Login</h2>
    <form action="login" method="POST">
      <div class="mb-3">
        <label for="username" class="form-label">Username:</label>
        <input type="text" id="username" name="username" class="form-control" required>
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">Password:</label>
        <input type="password" id="password" name="password" class="form-control" required>
      </div>
      <div class="mb-3 form-check">
        <input type="checkbox" id="remember-me" name="remember-me" class="form-check-input">
        <label for="remember-me" class="form-check-label remember-me-label">Remember me</label>
      </div>
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
      <div class="d-grid">
        <button type="submit" class="btn-login">Log In</button>
      </div>
    </form>
    <div class="signup-link">
      <p>Don't have an account?</p>
      <a href="registration">Sign up now!</a>
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