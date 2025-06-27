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
    <h3 class="mb-4">Manage Tasks</h3>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Assigned To</th>
                <th>Status</th>
                <th>Due Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="task" items="${taskList}">
                <tr>
                    <td>${task.taskId}</td>
                    <td>${task.title}</td>
                    <td>${task.assignedTo}</td>
                    <td>${task.status}</td>
                    <td><fmt:formatDate value="${task.deadline}" pattern="dd MMM yyyy" /></td>
                    <td>
                        <a href="EditTaskServlet?id=${task.taskId}" class="btn btn-sm btn-warning action-btn">Edit</a>
                        <a href="DeleteTaskServlet?id=${task.taskId}" class="btn btn-sm btn-danger"
                           onclick="return confirm('Delete this task?');">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>