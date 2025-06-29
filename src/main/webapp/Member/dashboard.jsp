<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Member Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary: #5e72e4;
            --primary-light: #8a9eff;
            --secondary: #6a11cb;
            --light: #f8f9fe;
            --accent: #ff6b6b;
            --text: #344767;
            --border: #e0e7ff;
            --card-shadow: 0 10px 25px rgba(94, 114, 228, 0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edff 100%);
            color: var(--text);
            min-height: 100vh;
            padding-top: 80px;
        }

        .container {
            max-width: 1400px;
            padding: 20px;
        }

        .dashboard-header {
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .dashboard-header h2 {
            font-weight: 600;
            font-size: 1.8rem;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0;
        }

        .welcome-message {
            font-size: 1.2rem;
            color: var(--text);
            margin-bottom: 0;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 18px;
            padding: 25px;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            border: none;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(94, 114, 228, 0.2);
        }

        .stat-card.projects::before { background: linear-gradient(to right, var(--primary), var(--secondary)); }
        .stat-card.teams::before { background: linear-gradient(to right, #2dce89, #1aae6f); }
        .stat-card.users::before { background: linear-gradient(to right, #11cdef, #1171ef); }
        .stat-card.tasks::before { background: linear-gradient(to right, #fb6340, #fbb140); }

        .stat-card h5 {
            font-size: 1.1rem;
            margin-bottom: 15px;
            color: #718096;
        }

        .stat-value {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-meta {
            color: #718096;
            font-size: 0.95rem;
        }

        .charts-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .chart-container {
            background: white;
            border-radius: 18px;
            padding: 25px;
            box-shadow: var(--card-shadow);
        }

        .chart-header {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--text);
        }

        .activity-card {
            background: white;
            border-radius: 18px;
            padding: 25px;
            box-shadow: var(--card-shadow);
            height: 100%;
        }

        .activity-list {
            list-style: none;
            padding: 0;
            max-height: 400px;
            overflow-y: auto;
        }

        .activity-item {
            padding: 15px 0;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-content {
            flex: 1;
        }

        .activity-time {
            background: rgba(94, 114, 228, 0.1);
            color: var(--primary);
            padding: 5px 12px;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .performance-card {
            background: white;
            border-radius: 18px;
            padding: 25px;
            box-shadow: var(--card-shadow);
            margin-bottom: 30px;
        }

        .performance-header {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--text);
        }

        .table-container {
            overflow-x: auto;
        }

        .table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        .table thead th {
            background-color: rgba(94, 114, 228, 0.1);
            color: var(--primary);
            border-bottom: 2px solid var(--border);
            padding: 15px;
            text-align: left;
        }

        .table tbody tr {
            transition: all 0.2s ease;
        }

        .table tbody tr:hover {
            background-color: rgba(94, 114, 228, 0.05);
        }

        .table tbody td {
            padding: 15px;
            border-bottom: 1px solid var(--border);
        }

        .progress {
            height: 10px;
            border-radius: 5px;
            background-color: var(--border);
            overflow: visible;
        }

        .progress-bar {
            border-radius: 5px;
            position: relative;
        }

        .progress-value {
            position: absolute;
            right: 5px;
            top: -25px;
            font-size: 0.8rem;
            color: var(--text);
            font-weight: 500;
        }

        .badge {
            padding: 6px 12px;
            border-radius: 12px;
            font-weight: 500;
        }

        .badge-danger { background: linear-gradient(to right, #f5365c, #f56036); }
        .badge-warning { background: linear-gradient(to right, #fb6340, #fbb140); }
        .badge-primary { background: linear-gradient(to right, #11cdef, #1171ef); }
        .badge-success { background: linear-gradient(to right, #2dce89, #1aae6f); }

        .sidebar-container {
            background: white;
            border-radius: 18px;
            padding: 25px;
            box-shadow: var(--card-shadow);
            margin-bottom: 30px;
        }

        .sidebar-header {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--text);
            border-bottom: 1px solid var(--border);
            padding-bottom: 10px;
        }

        .list-group-item {
            border: none;
            padding: 12px 15px;
            border-radius: 12px !important;
            margin-bottom: 8px;
            transition: all 0.3s ease;
            color: var(--text);
            font-weight: 500;
        }

        .list-group-item:hover {
            background: rgba(94, 114, 228, 0.1);
            color: var(--primary);
        }

        .list-group-item.active {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            border: none;
        }

        .quick-actions-card {
            background: white;
            border-radius: 18px;
            padding: 25px;
            box-shadow: var(--card-shadow);
        }

        .btn {
            border-radius: 12px;
            padding: 12px 20px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
        }

        .btn-primary {
            background: linear-gradient(to right, var(--primary), var(--secondary));
        }

        .btn-success {
            background: linear-gradient(to right, #2dce89, #1aae6f);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 14px rgba(50, 50, 93, 0.1), 0 3px 6px rgba(0, 0, 0, 0.08);
        }

        /* New styles for member dashboard */
        .task-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .task-card {
            background: white;
            border-radius: 18px;
            padding: 25px;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            border: none;
        }

        .task-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
        }

        .task-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(94, 114, 228, 0.2);
        }

        .priority-high::before { background: linear-gradient(to bottom, #f5365c, #f56036); }
        .priority-medium::before { background: linear-gradient(to bottom, #fb6340, #fbb140); }
        .priority-low::before { background: linear-gradient(to bottom, #2dce89, #1aae6f); }

        .task-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .task-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--text);
        }

        .task-content {
            margin-bottom: 20px;
        }

        .task-meta {
            color: #718096;
            font-size: 0.95rem;
            margin-bottom: 15px;
        }

        .task-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .performance-chart-container {
            background: white;
            border-radius: 18px;
            padding: 25px;
            box-shadow: var(--card-shadow);
        }

        .performance-stats {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }

        .stat-badge {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .stat-count {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 0.9rem;
            color: #718096;
        }

        .project-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid var(--border);
        }

        .project-item:last-child {
            border-bottom: none;
        }

        .project-info {
            flex: 1;
        }

        .project-name {
            font-weight: 500;
            margin-bottom: 5px;
        }

        .progress-container {
            display: flex;
            align-items: center;
            width: 150px;
        }

        .progress {
            flex-grow: 1;
            margin-right: 10px;
        }

        .project-count {
            background: rgba(94, 114, 228, 0.1);
            color: var(--primary);
            padding: 5px 12px;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .date-display {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
        }

        @media (max-width: 992px) {
            .charts-row {
                grid-template-columns: 1fr;
            }

            .task-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<jsp:include page="../Header/header.jsp"/>

<div class="container mt-4">
    <!-- Dashboard Header -->
    <div class="dashboard-header">
        <div>
            <h2>Member Dashboard</h2>
            <p class="welcome-message">Welcome, ${user.fullName}!</p>
        </div>
        <div class="date-display">
            <span class="badge bg-light text-dark">
                <i class="fas fa-calendar me-2"></i>
                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE, MMMM d, yyyy" />
            </span>
        </div>
    </div>

    <div class="row">
        <!-- Sidebar Navigation -->
        <div class="col-lg-3">
            <div class="sidebar-container">
                <div class="sidebar-header">Navigation</div>
                <div class="list-group">
                    <a href="dashboard" class="list-group-item list-group-item-action active">
                        <i class="fas fa-tasks me-2"></i>My Tasks
                    </a>
                </div>
            </div>

            <!-- Project Progress Card -->
            <div class="performance-card">
                <div class="performance-header">Project Progress</div>
                <ul class="activity-list">
                    <c:forEach items="${projectProgress}" var="progress">
                        <li class="project-item">
                            <div class="project-info">
                                <div class="project-name">${progress.projectName}</div>
                                <div class="text-muted small">${progress.completedTasks}/${progress.totalTasks} tasks</div>
                            </div>
                            <div class="progress-container">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar"
                                         style="width: ${progress.percentage}%; background: linear-gradient(to right, var(--primary), var(--secondary));">
                                        <span class="progress-value">${progress.percentage}%</span>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                    <c:if test="${empty projectProgress}">
                        <li class="project-item">
                            <div class="project-info text-center text-muted py-4">
                                No projects in progress
                            </div>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>

        <!-- Main Content Area -->
        <div class="col-lg-9">
            <div class="performance-card">
                <div class="performance-header">Your Assigned Tasks</div>

                <div class="task-grid">
                    <c:forEach items="${tasks}" var="task">
                        <div class="task-card priority-${task.priority.toLowerCase()}">
                            <div class="task-header">
                                <div class="task-title">${task.title}</div>
                                <span class="badge badge-${task.priority == 'URGENT' ? 'danger' :
                                                     task.priority == 'HIGH' ? 'warning' : 'success'}">
                                    ${task.priority}
                                </span>
                            </div>

                            <div class="task-content">
                                <p class="task-meta">${task.description}</p>
                                <div class="task-meta">
                                    <i class="fas fa-calendar-day me-2"></i>
                                    <strong>Deadline:</strong>
                                    <fmt:formatDate value="${task.deadline}" pattern="MMM dd, yyyy"/>
                                </div>
                            </div>

                            <div class="mb-3">
                                <c:set var="progress" value="${task.status == 'COMPLETED' ? 100 :
                                                      task.status == 'IN_PROGRESS' ? 50 : 25}"/>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar"
                                         style="width: ${progress}%; background: linear-gradient(to right, var(--primary), var(--secondary));">
                                        <span class="progress-value">${progress}%</span>
                                    </div>
                                </div>
                            </div>

                            <div class="task-footer">
                                <select class="form-select status-select"
                                        data-task-id="${task.taskId}" style="border-radius: 12px;">
                                    <option value="TODO" ${task.status == 'TODO' ? 'selected' : ''}>To Do</option>
                                    <option value="IN_PROGRESS" ${task.status == 'IN_PROGRESS' ? 'selected' : ''}>In Progress</option>
                                    <option value="BLOCKED" ${task.status == 'BLOCKED' ? 'selected' : ''}>Blocked</option>
                                    <option value="COMPLETED" ${task.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                                </select>
                                <button class="btn btn-sm btn-outline-primary" style="border-radius: 12px;">
                                    <a href = "Tasks/task-details.jsp"><i class="fas fa-info-circle me-1"></i>Details</a>
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty tasks}">
                        <div class="task-card">
                            <div class="text-center text-muted py-5">
                                <i class="fas fa-check-circle fa-3x mb-3"></i>
                                <h5>No tasks assigned</h5>
                                <p class="mb-0">You're all caught up!</p>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Performance Summary Card -->
            <div class="performance-card">
                <div class="performance-header">Your Performance Summary</div>
                <div class="row">
                    <div class="col-md-8">
                        <canvas id="performanceChart" height="250"></canvas>
                    </div>
                    <div class="col-md-4">
                        <div class="performance-stats">
                            <div class="stat-badge">
                                <div class="stat-count text-success">${completedCount}</div>
                                <div class="stat-label">Completed</div>
                            </div>
                            <div class="stat-badge">
                                <div class="stat-count text-warning">${inProgressCount}</div>
                                <div class="stat-label">In Progress</div>
                            </div>
                            <div class="stat-badge">
                                <div class="stat-count text-danger">${overdueCount}</div>
                                <div class="stat-label">Overdue</div>
                            </div>
                        </div>
                    </div>
                </div>
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
                backgroundColor: [
                    'rgba(45, 206, 137, 0.8)',
                    'rgba(251, 177, 64, 0.8)',
                    'rgba(245, 54, 92, 0.8)'
                ],
                borderColor: [
                    'rgba(45, 206, 137, 1)',
                    'rgba(251, 177, 64, 1)',
                    'rgba(245, 54, 92, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        padding: 20,
                        usePointStyle: true,
                        pointStyle: 'circle'
                    }
                },
                tooltip: {
                    backgroundColor: 'rgba(255, 255, 255, 0.9)',
                    titleColor: '#333',
                    bodyColor: '#666',
                    borderColor: 'rgba(0, 0, 0, 0.1)',
                    borderWidth: 1,
                    padding: 12,
                    cornerRadius: 12
                }
            },
            cutout: '70%'
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
                    // Create a notification element
                    const notification = $('<div class="alert alert-success alert-dismissible fade show" role="alert" style="position: fixed; top: 20px; right: 20px; z-index: 1000;">' +
                        '<i class="fas fa-check-circle me-2"></i> Status updated successfully!' +
                        '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
                        '</div>');

                    // Add to the body and auto remove after 3 seconds
                    $('body').append(notification);
                    setTimeout(() => {
                        notification.alert('close');
                    }, 3000);
                } else {
                    alert('Error updating status');
                }
            });
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>