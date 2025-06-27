<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Project Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../Header/header.jsp"/>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Project Management</h2>
            <a href="create-project.jsp" class="btn btn-primary">+ New Project</a>
        </div>

        <div class="card">
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Project Name</th>
                            <th>Team</th>
                            <th>Start Date</th>
                            <th>Deadline</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${projects}" var="project">
                            <tr>
                               <td>${project.projectName}</td>
                               <td>${project.teamId}</td>
                               <td><fmt:formatDate value="${project.createdAt}" pattern="yyyy-MM-dd"/></td>                                 <td><fmt:formatDate value="${project.deadline}" pattern="yyyy-MM-dd"/></td>
                                <td>
                                    <span class="badge bg-${project.status == 'Active' ? 'success' : project.status == 'Pending' ? 'warning' : 'secondary'}">
                                        ${project.status}
                                    </span>
                                </td>
                                <td>
                                    <a href="edit-project.jsp?id=${project.id}" class="btn btn-sm btn-outline-primary">Edit</a>
                                    <a href="delete-project?id=${project.id}" class="btn btn-sm btn-outline-danger">Delete</a>
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