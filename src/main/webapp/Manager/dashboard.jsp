<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manager Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <jsp:include page="../Header/header.jsp"/>

    <div class="container mt-4">
        <h2 class="mb-4">Manager Dashboard</h2>
        <h2>Welcome, Manager ${user.fullName}!</h2>
        <!-- Project Summary -->
        <div class="row mb-4">
            <c:forEach items="${myProjects}" var="project">
                <div class="col-md-4 mb-3">
                    <div class="card h-100">
                        <div class="card-header bg-info text-white">
                            ${project.projectName}
                        </div>
                        <div class="card-body">
                            <p>${project.description}</p>
                            <div class="mb-2">
                                <strong>Deadline:</strong>
                                <fmt:formatDate value="${project.deadline}" pattern="MMM dd, yyyy"/>
                            </div>
                            <div class="progress">
                                <c:set var="progress" value="${project.status == 'COMPLETED' ? 100 :
                                                             project.status == 'IN_PROGRESS' ? 50 : 25}"/>
                                <div class="progress-bar" role="progressbar"
                                     style="width: ${progress}%">${progress}%</div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Charts Row -->
        <div class="row mb-4">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        Task Distribution by Team Member
                    </div>
                    <div class="card-body">
                        <canvas id="taskDistributionChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        Upcoming Deadlines (Next 7 Days)
                    </div>
                    <div class="card-body">
                        <ul class="list-group">
                            <c:forEach items="${upcomingDeadlines}" var="task">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    ${task.title}
                                    <span class="badge bg-${task.priority == 'URGENT' ? 'danger' :
                                                          task.priority == 'HIGH' ? 'warning' : 'primary'}">
                                        <fmt:formatDate value="${task.deadline}" pattern="MMM dd"/>
                                    </span>
                                </li>
                            </c:forEach>
                            <c:if test="${empty upcomingDeadlines}">
                                <li class="list-group-item">No upcoming deadlines</li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- Team Performance -->
        <div class="card mb-4">
            <div class="card-header">
                Team Performance
            </div>
            <div class="card-body">
                <table class="table table-striped">
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
                                    <div class="progress" style="height: 20px;">
                                        <div class="progress-bar" role="progressbar"
                                             style="width: ${perf.value.completionRate * 100}%">
                                            <fmt:formatNumber value="${perf.value.completionRate * 100}" maxFractionDigits="1"/>%
                                        </div>
                                    </div>
                                </td>
                                <td>${perf.value.avgDuration}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${perf.value.completionRate > 0.8}">
                                            <span class="badge bg-success">Excellent</span>
                                        </c:when>
                                        <c:when test="${perf.value.completionRate > 0.6}">
                                            <span class="badge bg-primary">Good</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning">Needs Improvement</span>
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
            <div class="col-md-3">
                <div class="list-group">
                    <a href="dashboard.jsp" class="list-group-item list-group-item-action">Dashboard</a>
                    <a href="teams.jsp" class="list-group-item list-group-item-action">Manage Teams</a>
                    <a href="projects.jsp" class="list-group-item list-group-item-action active">Manage Projects</a>
                </div>
            </div>

            <div class="col-md-9">
                <div class="card mt-4">
                    <div class="card-header">
                        Quick Actions
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <a href="teams.jsp" class="btn btn-primary">Create New Team</a>
                            <a href="ProjectServlet" class="btn btn-success mt-2">Create New Project</a>
                        </div>
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
                    backgroundColor: 'rgba(54, 162, 235, 0.5)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</body>
</html>