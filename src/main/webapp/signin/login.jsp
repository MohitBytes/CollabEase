<%@ page contentType="text/html;charset=UTF-8" %>

<% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger">${error}</div>
<% } %>

<% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success"><%= request.getParameter("success") %></div>
<% } %>


<!DOCTYPE html>
<html>
<head>
    <title>CollabEase - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">CollabEase Login</h4>
                    </div>
                    <div class="card-body">
                        <form action="LoginServlet" method="POST">
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" name="email" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" name="password" class="form-control" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Login</button>
                        </form>
                        <hr>
                        <p class="text-center mb-0">
                            <a href="register.jsp">Create new account</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>