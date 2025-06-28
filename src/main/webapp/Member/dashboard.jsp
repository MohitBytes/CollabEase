<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Member Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .task-card { transition: transform 0.2s; }
        .task-card:hover { transform: translateY(-5px); }
        .priority-high { border-left: 4px solid #dc3545; }
        .priority-medium { border-left: 4px solid #ffc107; }
        .priority-low { border-left: 4px solid #198754; }
    </style>
</head>
<body>

<jsp:include page="../Header/header.jsp"/>

<div class="container mt-4">
    <div class="row">
        <div class="col-md-3">
            <div class="list-group">
                <a href="dashboard" class="list-group-item list-group-item-action active">My Tasks</a>
                <a href="projects" class="list-group-item list-group-item-action">Projects</a>
            </div>
        </div>

        <div class="col-md-9">
            <h2>Welcome, ${user.fullName}</h2>
            <p class="text-muted">Your assigned tasks</p>

            <div class="row">
                <c:forEach items="${tasks}" var="task">
                    <div class="col-md-6 mb-4">
                        <div class="card task-card h-100 priority-${task.priority.toLowerCase()}">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <h5 class="card-title">${task.title}</h5>
                                    <span class="badge bg-${task.priority == 'URGENT' ? 'danger' :
                                                         task.priority == 'HIGH' ? 'warning' : 'success'}">
                                        ${task.priority}
                                    </span>
                                </div>
                                <p class="card-text">${task.description}</p>
                                <div class="mb-2">
                                    <strong>Deadline:</strong>
                                    <fmt:formatDate value="${task.deadline}" pattern="MMM dd, yyyy"/>
                                </div>
                                <div class="progress mb-3" style="height: 10px;">
                                    <div class="progress-bar" role="progressbar"
                                         style="width: ${task.status == 'COMPLETED' ? 100 :
                                                      task.status == 'IN_PROGRESS' ? 50 : 25}%;"></div>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <select class="form-select status-select"
                                            data-task-id="${task.taskId}" style="width: auto;">
                                        <option value="TODO" ${task.status == 'TODO' ? 'selected' : ''}>To Do</option>
                                        <option value="IN_PROGRESS" ${task.status == 'IN_PROGRESS' ? 'selected' : ''}>In Progress</option>
                                        <option value="BLOCKED" ${task.status == 'BLOCKED' ? 'selected' : ''}>Blocked</option>
                                        <option value="COMPLETED" ${task.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                                    </select>
                                    <button class="btn btn-sm btn-outline-primary">Details</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<!-- Right column widgets -->
<div class="row">
    <div class="col-md-8"></div>
    <div class="col-md-4">
        <div class="card mb-4">
            <div class="card-header">Project Progress</div>
            <div class="card-body">
                <ul class="list-group">
                    <c:forEach items="${projectProgress}" var="progress">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            ${progress.projectName}
                            <div>
                                <span class="badge bg-primary rounded-pill">
                                    ${progress.completedTasks}/${progress.totalTasks}
                                </span>
                                <div class="progress" style="width: 100px; height: 10px; display: inline-block;">
                                    <div class="progress-bar" role="progressbar"
                                         style="width: ${progress.percentage}%"></div>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <div class="card">
            <div class="card-header">Performance Summary</div>
            <div class="card-body">
                <canvas id="performanceChart"></canvas>
                <p class="mt-3 text-center">
                    <span class="badge bg-success">Completed: ${completedCount}</span>
                    <span class="badge bg-warning">In Progress: ${inProgressCount}</span>
                    <span class="badge bg-danger">Overdue: ${overdueCount}</span>
                </p>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const perfCtx = document.getElementById('performanceChart').getContext('2d');
    const perfChart = new Chart(perfCtx, {
        type: 'doughnut',
        data: {
            labels: ['Completed', 'In Progress', 'Overdue'],
            datasets: [{
                data: [
                    ${completedCount != null ? completedCount : 0},
                    ${inProgressCount != null ? inProgressCount : 0},
                    ${overdueCount != null ? overdueCount : 0}
                ],
                backgroundColor: ['#4CAF50', '#FFC107', '#F44336']
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom'
                }
            }
        }
    });
</script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $('.status-select').change(function() {
            const taskId = $(this).data('task-id');
            const newStatus = $(this).val();
            $.post('${pageContext.request.contextPath}/update-task-status', {
                taskId: taskId,
                status: newStatus
            }, function(response) {
                if (response === 'success') {
                    alert('Status updated successfully!');
                } else {
                    alert('Error updating status');
                }
            });
        });
    });
</script>

</body>
</html>