<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

    <jsp:include page="../Header/header.jsp"/>

    <div class="container mt-4">
        <h2 class="mb-4">Admin Dashboard</h2>

        <!-- Stats Cards -->
        <div class="row mb-4">
            <!-- Projects -->
            <div class="col-md-3">
                <div class="card text-white bg-primary">
                    <div class="card-body">
                        <h5 class="card-title">Projects</h5>
                        <p class="card-text display-4">${totalProjects}</p>
                        <p>${activeProjects} active</p>
                    </div>
                </div>
            </div>
            <!-- Teams -->
            <div class="col-md-3">
                <div class="card text-white bg-success">
                    <div class="card-body">
                        <h5 class="card-title">Teams</h5>
                        <p class="card-text display-4">${totalTeams}</p>
                    </div>
                </div>
            </div>
            <!-- Users -->
            <div class="col-md-3">
                <div class="card text-white bg-info">
                    <div class="card-body">
                        <h5 class="card-title">Users</h5>
                        <p class="card-text display-4">${totalUsers}</p>
                    </div>
                </div>
            </div>
            <!-- Tasks -->
            <div class="col-md-3">
                <div class="card text-white bg-warning">
                    <div class="card-body">
                        <h5 class="card-title">Tasks</h5>
                        <p class="card-text display-4">
                            <c:set var="totalTasks" value="0" />
                            <c:if test="${not empty taskDistribution}">
                                <c:forEach items="${taskDistribution}" var="entry">
                                    <c:set var="totalTasks" value="${totalTasks + entry.value}" />
                                </c:forEach>
                            </c:if>
                            ${totalTasks}
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts Row -->
        <div class="row mb-4">
            <!-- Task Status Chart -->
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">Task Status Distribution</div>
                    <div class="card-body">
                        <canvas id="taskStatusChart"></canvas>
                    </div>
                </div>
            </div>
            <!-- Recent Activity -->
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">Recent Activity</div>
                    <div class="card-body">
                        <ul class="list-group">
                            <c:if test="${not empty recentProjects}">
                                <c:forEach items="${recentProjects}" var="project">
                                    <li class="list-group-item">
                                        New project: ${project.projectName}
                                        <span class="badge bg-info float-end">
                                            <fmt:formatDate value="${project.createdAt}" pattern="MMM dd" />
                                        </span>
                                    </li>
                                </c:forEach>
                            </c:if>
                            <c:if test="${not empty recentTasks}">
                                <c:forEach items="${recentTasks}" var="task">
                                    <li class="list-group-item">
                                        Task created: ${task.title}
                                        <span class="badge bg-info float-end">
                                            <fmt:formatDate value="${task.createdAt}" pattern="MMM dd" />
                                        </span>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- Reports Section -->
        <div class="card mb-4">
            <div class="card-header">Reports</div>
            <div class="card-body d-grid gap-2 d-md-block">
                <a href="ReportServlet?type=projects" class="btn btn-primary">Export Projects</a>
                <a href="ReportServlet?type=tasks" class="btn btn-success ms-2">Export Tasks</a>
                <a href="ReportServlet?type=users" class="btn btn-info ms-2">Export Users</a>
            </div>
        </div>
    </div>

    <!-- Task Status Chart JS -->
    <script>
        const statusCtx = document.getElementById('taskStatusChart').getContext('2d');
        const statusChart = new Chart(statusCtx, {
            type: 'pie',
            data: {
                labels: [<c:forEach items="${taskDistribution}" var="entry">'${entry.key}', </c:forEach>],
                datasets: [{
                    data: [<c:forEach items="${taskDistribution}" var="entry">${entry.value}, </c:forEach>],
                    backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF']
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'right' } }
            }
        });
    </script>

    <!-- Notifications JS -->
    <script>
        $(document).ready(function() {
            loadNotifications();
            setInterval(loadNotifications, 30000); // every 30 seconds

            function loadNotifications() {
                $.get('${pageContext.request.contextPath}/NotificationServlet', function(notifications) {
                    $('#notificationCount').text(notifications.length);
                    if (notifications.length > 0) {
                        let html = '';
                        notifications.forEach(notif => {
                            html += `
                                <li>
                                    <a class="dropdown-item notification-item" href="#" data-id="\${notif.notificationId}">
                                        <div class="small text-muted">\${formatTime(notif.createdAt)}</div>
                                        \${notif.message}
                                    </a>
                                </li>
                            `;
                        });
                        html += `
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-center" href="#">Mark all as read</a></li>
                        `;
                        $('#notificationList').html(html);
                    } else {
                        $('#notificationList').html('<li><a class="dropdown-item" href="#">No notifications</a></li>');
                    }

                    $('.notification-item').click(function() {
                        const notificationId = $(this).data('id');
                        $.post('${pageContext.request.contextPath}/notifications', { notificationId: notificationId });
                        $(this).closest('li').remove();
                    });
                });
            }

            function formatTime(timestamp) {
                const date = new Date(timestamp);
                return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
            }
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>