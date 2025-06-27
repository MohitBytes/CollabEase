<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../Header/header.jsp"/>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Task Management</h2>
            <a href="create-task.jsp" class="btn btn-primary">+ New Task</a>
        </div>

        <div class="card">
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Task Name</th>
                            <th>Project</th>
                            <th>Assigned To</th>
                            <th>Priority</th>
                            <th>Due Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${tasks}" var="task">
                            <tr>
                                <td>${task.name}</td>
                                <td>${task.project}</td>
                                <td>${task.assignedTo}</td>
                                <td>
                                    <span class="badge bg-${task.priority == 'High' ? 'danger' : task.priority == 'Medium' ? 'warning' : 'info'}">
                                        ${task.priority}
                                    </span>
                                </td>
                                <td>${task.dueDate}</td>
                                <td>
                                    <span class="badge bg-${task.status == 'Completed' ? 'success' : task.status == 'In Progress' ? 'primary' : 'secondary'}">
                                        ${task.status}
                                    </span>
                                </td>
                                <td>
                                    <a href="edit-task.jsp?id=${task.id}" class="btn btn-sm btn-outline-primary">Edit</a>
                                    <a href="delete-task?id=${task.id}" class="btn btn-sm btn-outline-danger">Delete</a>
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