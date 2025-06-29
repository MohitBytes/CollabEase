<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Notifications</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            max-width: 1200px;
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

        .card {
            background: white;
            border-radius: 18px;
            padding: 25px;
            box-shadow: var(--card-shadow);
            border: none;
            margin-bottom: 30px;
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(94, 114, 228, 0.2);
        }

        .card-header {
            background: white;
            border: none;
            padding: 0;
            margin-bottom: 20px;
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--primary);
            position: relative;
        }

        .card-header::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 60px;
            height: 3px;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            border-radius: 3px;
        }

        .form-label {
            font-weight: 500;
            color: var(--text);
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            border: 2px solid var(--border);
            border-radius: 12px;
            padding: 12px 15px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 0.25rem rgba(94, 114, 228, 0.15);
        }

        .btn {
            border-radius: 12px;
            padding: 12px 25px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            font-size: 1rem;
        }

        .btn-outline-success {
            background: white;
            border: 2px solid #2dce89;
            color: #2dce89;
        }

        .btn-outline-success:hover {
            background: linear-gradient(to right, #2dce89, #1aae6f);
            color: white;
        }

        .btn-outline-danger {
            background: white;
            border: 2px solid #f5365c;
            color: #f5365c;
        }

        .btn-outline-danger:hover {
            background: linear-gradient(to right, #f5365c, #f56036);
            color: white;
        }

        .date-display {
            background: white;
            border-radius: 12px;
            padding: 8px 15px;
            box-shadow: var(--card-shadow);
            font-weight: 500;
            display: inline-flex;
            align-items: center;
        }

        .date-display i {
            margin-right: 8px;
            color: var(--primary);
        }

        .notification-list {
            border-radius: 18px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
        }

        .notification-item {
            background: white;
            border: none;
            border-bottom: 1px solid var(--border);
            padding: 20px;
            transition: all 0.3s ease;
        }

        .notification-item:last-child {
            border-bottom: none;
        }

        .notification-item:hover {
            background: rgba(94, 114, 228, 0.05);
            transform: translateX(5px);
        }

        .notification-item.unread {
            background: rgba(94, 114, 228, 0.05);
        }

        .notification-item .badge {
            border-radius: 12px;
            padding: 8px 15px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge.bg-primary {
            background: linear-gradient(to right, var(--primary), var(--secondary)) !important;
        }

        .badge.bg-secondary {
            background: linear-gradient(to right, #8392ab, #a0aec0) !important;
        }

        .action-bar {
            display: flex;
            justify-content: space-between;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .controls {
            display: flex;
            gap: 15px;
        }

        .filter-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .filter-label {
            font-weight: 500;
            color: var(--text);
            white-space: nowrap;
        }

        @media (max-width: 768px) {
            .action-bar {
                flex-direction: column;
                align-items: flex-start;
            }

            .controls {
                width: 100%;
                justify-content: space-between;
            }

            .filter-container {
                width: 100%;
            }

            #typeFilter {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../Header/header.jsp"/>

    <div class="container mt-4">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <h2>Notifications</h2>
            <div class="date-display">
                <i class="fas fa-calendar"></i>
                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE, MMMM d, yyyy" />
            </div>
        </div>

        <div class="card">
            <div class="card-header">Your Notifications</div>
            <div class="card-body">
                <div class="action-bar">
                    <div class="controls">
                        <button id="markAllRead" class="btn btn-outline-success">
                            <i class="fas fa-check-circle me-2"></i>Mark All as Read
                        </button>
                        <button id="clearAll" class="btn btn-outline-danger">
                            <i class="fas fa-trash-alt me-2"></i>Clear All
                        </button>
                    </div>

                    <div class="filter-container">
                        <span class="filter-label">Filter by:</span>
                        <select id="typeFilter" class="form-select">
                            <option value="all">All Types</option>
                            <option value="STATUS_UPDATE">Status Update</option>
                            <option value="DEADLINE_REMINDER">Deadline Reminder</option>
                            <option value="TASK_ASSIGNED">Task Assigned</option>
                            <option value="NEW_COMMENT">New Comment</option>
                        </select>
                    </div>
                </div>

                <div class="notification-list">
                    <ul class="list-group" id="notificationList">
                        <c:forEach var="n" items="${notifications}">
                            <li class="list-group-item notification-item ${n.read ? '' : 'unread'}"
                                data-type="${fn:toLowerCase(n.type)}">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <strong>${n.message}</strong>
                                        <div class="text-muted mt-2">
                                            <i class="fas fa-clock me-1"></i>
                                            <small>${n.createdAt}</small>
                                        </div>
                                    </div>
                                    <span class="badge ${n.read ? 'bg-secondary' : 'bg-primary'}">
                                        ${n.read ? 'Read' : 'Unread'}
                                    </span>
                                </div>
                            </li>
                        </c:forEach>

                        <c:if test="${empty notifications}">
                            <li class="list-group-item notification-item text-center py-5">
                                <i class="fas fa-bell-slash fa-3x mb-3" style="color: #8a9eff;"></i>
                                <h5 class="mb-2">No notifications yet</h5>
                                <p class="text-muted">You'll see important updates here</p>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('typeFilter').addEventListener('change', function () {
            const selectedType = this.value.toLowerCase();

            document.querySelectorAll('.notification-item').forEach(item => {
                const itemType = item.dataset.type?.toLowerCase() || "";

                if (selectedType === 'all' || itemType === selectedType) {
                    item.style.display = '';
                } else {
                    item.style.display = 'none';
                }
            });
        });

        document.getElementById('markAllRead').addEventListener('click', function () {
            if (confirm("Mark all notifications as read?")) {
                fetch("NotificationBulkServlet?action=markAll", { method: "POST" })
                    .then(() => location.reload());
            }
        });

        document.getElementById('clearAll').addEventListener('click', function () {
            if (confirm("Clear all notifications?")) {
                fetch("NotificationBulkServlet?action=clearAll", { method: "POST" })
                    .then(() => location.reload());
            }
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>