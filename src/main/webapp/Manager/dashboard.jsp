<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manager Dashboard</title>
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

        /* Dashboard styling */
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

        /* Stats Cards */
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

        /* Charts Row */
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

        /* Activity Card */
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

        /* Team Performance */
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

        /* Progress Bar */
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

        /* Badges */
        .badge {
            padding: 6px 12px;
            border-radius: 12px;
            font-weight: 500;
        }

        .badge-danger { background: linear-gradient(to right, #f5365c, #f56036); }
        .badge-warning { background: linear-gradient(to right, #fb6340, #fbb140); }
        .badge-primary { background: linear-gradient(to right, #11cdef, #1171ef); }
        .badge-success { background: linear-gradient(to right, #2dce89, #1aae6f); }

        /* Sidebar */
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

        /* Responsive */
        @media (max-width: 992px) {
            .charts-row {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }

            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
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
                <h2>Manager Dashboard</h2>
                <p class="welcome-message">Welcome, Manager ${user.fullName}!</p>
            </div>
            <div class="date-display">
                <span class="badge bg-light text-dark">
                    <i class="fas fa-calendar me-2"></i>
                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE, MMMM d, yyyy" />
                </span>
            </div>
        </div>

        <!-- Project Summary -->
        <div class="stats-grid">
            <c:forEach items="${myProjects}" var="project">
                <a href="#" class="text-decoration-none">
                    <div class="stat-card projects">
                        <h5>${project.projectName}</h5>
                        <div class="stat-meta">${project.description}</div>
                        <div class="mt-3">
                            <div class="d-flex justify-content-between mb-2">
                                <div><strong>Deadline:</strong></div>
                                <div><fmt:formatDate value="${project.deadline}" pattern="MMM dd, yyyy"/></div>
                            </div>
                            <c:set var="progress" value="${project.status == 'COMPLETED' ? 100 :
                                                         project.status == 'IN_PROGRESS' ? 50 : 25}"/>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar"
                                     style="width: ${progress}%; background: linear-gradient(to right, var(--primary), var(--secondary));">
                                    <span class="progress-value">${progress}%</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>

        <!-- Charts Row -->
        <div class="charts-row">
            <div class="chart-container">
                <div class="chart-header">Task Distribution by Team Member</div>
                <canvas id="taskDistributionChart" height="300"></canvas>
            </div>

            <div class="activity-card">
                <div class="chart-header">Upcoming Deadlines (Next 7 Days)</div>
                <ul class="activity-list">
                    <c:forEach items="${upcomingDeadlines}" var="task">
                        <li class="activity-item">
                            <div class="activity-content">
                                <div class="fw-medium">${task.title}</div>
                                <div class="text-muted small">${task.projectName}</div>
                            </div>
                            <div class="activity-time badge badge-${task.priority == 'URGENT' ? 'danger' :
                                                      task.priority == 'HIGH' ? 'warning' : 'primary'}">
                                <fmt:formatDate value="${task.deadline}" pattern="MMM dd"/>
                            </div>
                        </li>
                    </c:forEach>
                    <c:if test="${empty upcomingDeadlines}">
                        <li class="activity-item">
                            <div class="activity-content text-center text-muted py-4">
                                No upcoming deadlines
                            </div>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>

        <!-- Team Performance -->
        <div class="performance-card">
            <div class="performance-header">Team Performance</div>
            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Team</th>
                            <th>Completion Rate</th>
                            <th>Avg. Duration (days)</th>
                            <th>Performance</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${teamPerformance}" var="perf">
                            <tr>
                                <td>${perf.key}</td>
                                <td>
                                    <div class="progress">
                                        <div class="progress-bar" role="progressbar"
                                             style="width: ${perf.value.completionRate * 100}%; background: linear-gradient(to right, var(--primary), var(--secondary));">
                                            <span class="progress-value">
                                                <fmt:formatNumber value="${perf.value.completionRate * 100}" maxFractionDigits="1"/>%
                                            </span>
                                        </div>
                                    </div>
                                </td>
                                <td>${perf.value.avgDuration}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${perf.value.completionRate > 0.8}">
                                            <span class="badge badge-success">Excellent</span>
                                        </c:when>
                                        <c:when test="${perf.value.completionRate > 0.6}">
                                            <span class="badge badge-primary">Good</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-warning">Needs Improvement</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="container mt-4">
        <div class="row">
            <div class="col-lg-3">
                <div class="sidebar-container">
                    <div class="sidebar-header">Navigation</div>
                    <div class="list-group">
                        <a href="index.jsp" class="list-group-item list-group-item-action">
                            <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                        </a>
                        <a href="TeamServlet" class="list-group-item list-group-item-action">
                            <i class="fas fa-users me-2"></i>Manage Teams
                        </a>
                        <a href="ProjectServlet" class="list-group-item list-group-item-action active">
                            <i class="fas fa-project-diagram me-2"></i>Manage Projects
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-lg-9">
                <div class="quick-actions-card">
                    <div class="chart-header">Quick Actions</div>
                    <div class="d-grid gap-3">
                        <a href="TeamServlet" class="btn btn-primary">
                            <i class="fas fa-plus-circle me-2"></i>Create New Team
                        </a>
                        <a href="ProjectServlet" class="btn btn-success">
                            <i class="fas fa-folder-plus me-2"></i>Create New Project
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Task Distribution Chart
        const distCtx = document.getElementById('taskDistributionChart').getContext('2d');
        const distChart = new Chart(distCtx, {
            type: 'bar',
            data: {
                labels: [<c:forEach items="${teamTaskDistribution}" var="entry">'${entry.key}', </c:forEach>],
                datasets: [{
                    label: 'Tasks Assigned',
                    data: [<c:forEach items="${teamTaskDistribution}" var="entry">${entry.value}, </c:forEach>],
                    backgroundColor: [
                        'rgba(94, 114, 228, 0.7)',
                        'rgba(43, 203, 186, 0.7)',
                        'rgba(253, 126, 20, 0.7)',
                        'rgba(58, 83, 155, 0.7)',
                        'rgba(82, 95, 225, 0.7)'
                    ],
                    borderColor: [
                        'rgba(94, 114, 228, 1)',
                        'rgba(43, 203, 186, 1)',
                        'rgba(253, 126, 20, 1)',
                        'rgba(58, 83, 155, 1)',
                        'rgba(82, 95, 225, 1)'
                    ],
                    borderWidth: 1,
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
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
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1,
                            color: '#718096'
                        },
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            color: '#718096'
                        }
                    }
                }
            }
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>