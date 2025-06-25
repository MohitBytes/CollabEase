<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Tasks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container mt-4">
        <h2>Task Management</h2>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="card mb-4">
            <div class="card-header">
                Create New Task
            </div>
            <div class="card-body">
                <form action="TaskServlet" method="POST" id="taskForm">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Task Title</label>
                            <input type="text" name="title" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Project</label>
                            <select name="projectId" class="form-select" required>
                                <c:forEach items="${projects}" var="project">
                                    <option value="${project.projectId}">${project.projectName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <textarea name="description" class="form-control" rows="3"></textarea>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Priority</label>
                            <select name="priority" class="form-select" required>
                                <option value="LOW">Low</option>
                                <option value="MEDIUM" selected>Medium</option>
                                <option value="HIGH">High</option>
                                <option value="URGENT">Urgent</option>
                            </select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Deadline</label>
                            <input type="date" name="deadline" class="form-control" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Assignment</label>
                            <select name="assignment" id="assignmentType" class="form-select" required>
                                <option value="auto">Auto-Assign</option>
                                <option value="manual">Manual Assign</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-3" id="assigneeField" style="display: none;">
                        <label class="form-label">Assign To</label>
                        <select name="assignedTo" class="form-select">
                            <c:forEach items="${users}" var="user">
                                <option value="${user.userId}">${user.fullName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary">Create Task</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            $('#assignmentType').change(function() {
                if ($(this).val() === 'manual') {
                    $('#assigneeField').show();
                } else {
                    $('#assigneeField').hide();
                }
            });
        });
    </script>
</body>
</html>