<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../Header/header.jsp" />

<div class="container mt-4">
    <h3>Edit Task</h3>
    <form method="post" action="../EditEntityServlet">
        <input type="hidden" name="type" value="task">
        <input type="hidden" name="id" value="${task.taskId}">

        <div class="mb-3">
            <label for="title" class="form-label">Task Title</label>
            <input type="text" class="form-control" name="title" id="title" value="${task.title}" required>
        </div>

        <div class="mb-3">
            <label for="assignedTo" class="form-label">Assigned To</label>
            <input type="text" class="form-control" name="assignedTo" id="assignedTo" value="${task.assignedTo}" required>
        </div>

        <div class="mb-3">
            <label for="status" class="form-label">Status</label>
            <select class="form-select" name="status" id="status">
                <option value="Pending" ${task.status == 'Pending' ? 'selected' : ''}>Pending</option>
                <option value="In Progress" ${task.status == 'In Progress' ? 'selected' : ''}>In Progress</option>
                <option value="Completed" ${task.status == 'Completed' ? 'selected' : ''}>Completed</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="deadline" class="form-label">Deadline</label>
            <input type="date" class="form-control" name="deadline" id="deadline" value="<fmt:formatDate value='${task.deadline}' pattern='yyyy-MM-dd'/>">
        </div>

        <button type="submit" class="btn btn-warning">Update Task</button>
    </form>
</div>
