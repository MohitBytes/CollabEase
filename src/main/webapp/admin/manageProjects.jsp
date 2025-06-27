<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<jsp:include page="../Header/header.jsp"/>

<head>
<style>
    .action-btn {
        margin-right: 5px;
    }
</style>
</head>

<div class="container mt-4">
    <h3 class="mb-4">Manage Projects</h3>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Created At</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="project" items="${projectList}">
                <tr>
                    <td>${project.projectId}</td>
                    <td>${project.projectName}</td>
                    <td><fmt:formatDate value="${project.createdAt}" pattern="dd MMM yyyy" /></td>
                    <td>
                        <a href="EditEntityServlet?id=${project.projectId}" class="btn btn-sm btn-warning action-btn">Edit</a>
                        <a href="DeleteEntityServlet?id=${project.projectId}" class="btn btn-sm btn-danger"
                           onclick="return confirm('Are you sure you want to delete this project?');">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>