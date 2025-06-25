<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manager Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">CollabEase Manager</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-3">
                <div class="list-group">
                    <a href="dashboard" class="list-group-item list-group-item-action">Dashboard</a>
                    <a href="teams" class="list-group-item list-group-item-action">Manage Teams</a>
                    <a href="projects" class="list-group-item list-group-item-action active">Manage Projects</a>
                </div>
            </div>

            <div class="col-md-9">
                <h2>Welcome, Manager ${user.fullName}!</h2>
                <div class="card mt-4">
                    <div class="card-header">
                        Quick Actions
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <a href="teams.jsp" class="btn btn-primary">Create New Team</a>
                            <a href="ProjectServlet" class="btn btn-success mt-2">Create New Project</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>