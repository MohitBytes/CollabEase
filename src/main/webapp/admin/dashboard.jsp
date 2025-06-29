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

        /* Reports Section */
        .reports-card {
            background: white;
            border-radius: 18px;
            padding: 25px;
            box-shadow: var(--card-shadow);
            margin-bottom: 30px;
        }

        .reports-header {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--text);
        }

        .reports-buttons {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .report-btn {
            background: white;
            border: 2px solid var(--border);
            color: var(--text);
            padding: 10px 20px;
            border-radius: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
        }

        .report-btn i {
            margin-right: 8px;
            transition: all 0.3s ease;
        }

        .report-btn:hover {
            background: rgba(94, 114, 228, 0.1);
            border-color: var(--primary-light);
            color: var(--primary);
            transform: translateY(-2px);
        }

        .report-btn:hover i {
            transform: translateX(3px);
        }

        /* Notification Modal */
        .modal-content {
            border-radius: 18px;
            overflow: hidden;
            border: none;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.2);
        }

        .modal-header {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            border: none;
        }

        .modal-body {
            padding: 25px;
        }

        .notification-content {
            padding: 15px 0;
        }

        .notification-time {
            color: #718096;
            font-size: 0.9rem;
            margin-top: 10px;
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

            .reports-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../Header/header.jsp"/>
    <div class="container mt-4">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <h2>Admin Dashboard</h2>
            <div class="date-display">
                <span class="badge bg-light text-dark">
                    <i class="fas fa-calendar me-2"></i>
                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE, MMMM d, yyyy" />
                </span>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <!-- Projects -->
            <a href="ManageSection?type=projects" class="text-decoration-none">
                <div class="stat-card projects">
                    <h5>Projects</h5>
                    <div class="stat-value">${totalProjects}</div>
                    <div class="stat-meta">${activeProjects} active projects</div>
                </div>
            </a>

            <!-- Teams -->
            <a href="ManageSection?type=teams" class="text-decoration-none">
                <div class="stat-card teams">
                    <h5>Teams</h5>
                    <div class="stat-value">${totalTeams}</div>
                    <div class="stat-meta">Collaborative teams</div>
                </div>
            </a>

            <!-- Users -->
            <a href="ManageSection?type=users" class="text-decoration-none">
                <div class="stat-card users">
                    <h5>Users</h5>
                    <div class="stat-value">${totalUsers}</div>
                    <div class="stat-meta">Registered users</div>
                </div>
            </a>

            <!-- Tasks -->
            <a href="ManageSection?type=tasks" class="text-decoration-none">
                <div class="stat-card tasks">
                    <h5>Tasks</h5>
                    <div class="stat-value">
                        <c:set var="totalTasks" value="0" />
                        <c:if test="${not empty taskDistribution}">
                            <c:forEach items="${taskDistribution}" var="entry">
                                <c:set var="totalTasks" value="${totalTasks + entry.value}" />
                            </c:forEach>
                        </c:if>
                        ${totalTasks}
                    </div>
                    <div class="stat-meta">Tasks across all projects</div>
                </div>
            </a>
        </div>

        <!-- Charts and Activity -->
        <div class="charts-row">
            <!-- Task Status Chart -->
            <div class="chart-container">
                <div class="chart-header">Task Status Distribution</div>
                <canvas id="taskStatusChart" height="300"></canvas>
            </div>

            <!-- Recent Activity -->
            <div class="activity-card">
                <div class="chart-header">Recent Activity</div>
                <ul class="activity-list">
                    <c:if test="${not empty recentProjects}">
                        <c:forEach items="${recentProjects}" var="project">
                            <li class="activity-item">
                                <div class="activity-content">
                                    <div class="fw-medium">New project created</div>
                                    <div>${project.projectName}</div>
                                </div>
                                <div class="activity-time">
                                    <fmt:formatDate value="${project.createdAt}" pattern="MMM dd" />
                                </div>
                            </li>
                        </c:forEach>
                    </c:if>
                    <c:if test="${not empty recentTasks}">
                        <c:forEach items="${recentTasks}" var="task">
                            <li class="activity-item">
                                <div class="activity-content">
                                    <div class="fw-medium">Task created</div>
                                    <div>${task.title}</div>
                                </div>
                                <div class="activity-time">
                                    <fmt:formatDate value="${task.createdAt}" pattern="MMM dd" />
                                </div>
                            </li>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty recentProjects && empty recentTasks}">
                        <li class="activity-item">
                            <div class="activity-content text-center text-muted py-4">
                                No recent activity
                            </div>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>

        <!-- Reports Section -->
        <div class="reports-card">
            <div class="reports-header">Generate Reports</div>
            <div class="reports-buttons">
                <a href="ReportServlet?type=projects" class="report-btn">
                    <i class="fas fa-file-export"></i> Export Projects
                </a>
                <a href="ReportServlet?type=tasks" class="report-btn">
                    <i class="fas fa-file-export"></i> Export Tasks
                </a>
                <a href="ReportServlet?type=users" class="report-btn">
                    <i class="fas fa-file-export"></i> Export Users
                </a>
            </div>
        </div>
    </div>

    <!-- Notification Modal -->
    <div class="modal fade" id="notificationModal" tabindex="-1" aria-labelledby="notificationModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="notificationModalLabel">Notification</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body" id="notificationModalBody">
            <!-- JS will inject notification content -->
          </div>
          <div class="modal-footer">
            <a href="${pageContext.request.contextPath}/AllNotificationServlet" class="btn btn-primary">See All Notifications <i class="fa fa-angle-right"></i></a>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Task Status Chart JS -->
    <script>
        const statusCtx = document.getElementById('taskStatusChart').getContext('2d');
        const statusChart = new Chart(statusCtx, {
            type: 'doughnut',
            data: {
                labels: [<c:forEach items="${taskDistribution}" var="entry">'${entry.key}', </c:forEach>],
                datasets: [{
                    data: [<c:forEach items="${taskDistribution}" var="entry">${entry.value}, </c:forEach>],
                    backgroundColor: [
                        'rgba(94, 114, 228, 0.8)',
                        'rgba(43, 203, 186, 0.8)',
                        'rgba(253, 126, 20, 0.8)',
                        'rgba(58, 83, 155, 0.8)',
                        'rgba(82, 95, 225, 0.8)'
                    ],
                    borderColor: 'rgba(255, 255, 255, 0.8)',
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'right',
                        labels: {
                            padding: 20,
                            usePointStyle: true,
                            pointStyle: 'circle'
                        }
                    }
                },
                cutout: '65%'
            }
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Notification Script -->
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        fetch("${pageContext.request.contextPath}/NotificationServlet")
            .then(response => response.json())
            .then(data => {
                const badge = document.getElementById('notificationCount');
                const list = document.getElementById('notificationList');

                if (data.length > 0) {
                    badge.textContent = data.length;
                    badge.style.display = 'inline';
                    list.innerHTML = "";

                    data.forEach(notification => {
                        const listItem = document.createElement("li");
                        const link = document.createElement("a");
                        link.href = "#";
                        link.className = "dropdown-item notification-item";
                        link.dataset.id = notification.notificationId;
                        link.dataset.message = notification.message;
                        link.dataset.time = notification.createdAt;
                        link.textContent = notification.message;
                        listItem.appendChild(link);
                        list.appendChild(listItem);
                    });

                    // See all notifications option
                    const divider = document.createElement("li");
                    divider.innerHTML = '<hr class="dropdown-divider">';
                    list.appendChild(divider);

                    const seeAll = document.createElement("li");
                    seeAll.innerHTML = `<a class="dropdown-item text-center" href="${pageContext.request.contextPath}/AllNotificationServlet">See all notifications <i class="fa fa-angle-right"></i></a>`;
                    list.appendChild(seeAll);

                    attachNotificationClickHandlers();
                } else {
                    badge.style.display = 'none';
                    list.innerHTML = `<li><span class="dropdown-item-text text-muted">No notifications</span></li>`;
                }
            })
            .catch(error => {
                console.error("Notification fetch error:", error);
            });
    });

    function attachNotificationClickHandlers() {
        document.querySelectorAll('.notification-item').forEach(item => {
            item.addEventListener("click", function (e) {
                e.preventDefault();
                const msg = this.dataset.message;
                const rawTime = this.dataset.time;
                const time = formatRelativeTime(rawTime);
                const id = this.dataset.id;

                document.getElementById('notificationModalBody').innerHTML = `
                    <div class="notification-content">
                        <p class="mb-0"><strong>Message:</strong> ${msg}</p>
                        <p class="notification-time"><i class="fas fa-clock me-2"></i>${time}</p>
                    </div>
                `;

                const modal = new bootstrap.Modal(document.getElementById('notificationModal'));
                modal.show();

                fetch("${pageContext.request.contextPath}/NotificationServlet", {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: `notificationId=${id}`
                });
            });
        });
    }

    function formatRelativeTime(dateString) {
        const now = new Date();
        const date = new Date(dateString);
        const diff = Math.floor((now - date) / 1000); // seconds

        if (diff < 60) return `${diff} seconds ago`;
        if (diff < 3600) return `${Math.floor(diff / 60)} minutes ago`;
        if (diff < 86400) return `${Math.floor(diff / 3600)} hours ago`;
        return date.toLocaleString();
    }
    </script>
</body>
</html>