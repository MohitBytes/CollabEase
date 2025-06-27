<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Team Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../Header/header.jsp"/>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Team Management</h2>
            <a href="create-team.jsp" class="btn btn-primary">+ New Team</a>
        </div>

        <div class="card">
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Team Name</th>
                            <th>Department</th>
                            <th>Team Lead</th>
                            <th>Members</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${teams}" var="team">
                            <tr>
                                <td>${team.name}</td>
                                <td>${team.department}</td>
                                <td>${team.lead}</td>
                                <td>${team.memberCount}</td>
                                <td>
                                    <a href="edit-team.jsp?id=${team.id}" class="btn btn-sm btn-outline-primary">Edit</a>
                                    <a href="delete-team?id=${team.id}" class="btn btn-sm btn-outline-danger">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>