<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Teams</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Your Teams</h2>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="card mb-4">
            <div class="card-header">
                Create New Team
            </div>
            <div class="card-body">
                <form action="TeamServlet" method="POST">
                    <div class="mb-3">
                        <label class="form-label">Team Name</label>
                        <input type="text" name="teamName" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Create Team</button>
                </form>
            </div>
        </div>

        <div class="list-group">
            <c:forEach items="${teams}" var="team">
                <a href="#" class="list-group-item list-group-item-action">
                    ${team.teamName}
                </a>
            </c:forEach>
        </div>
    </div>
</body>
</html>