<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Tasks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
            --completed: #2dce89;
            --pending: #fb6340;
            --in-progress: #11cdef;
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
        }

        /* Card styling */
        .card {
            background: white;
            border-radius: 18px;
            padding: 25px;
            box-shadow: var(--card-shadow);
            border: none;
            margin-bottom: 30px;
        }

        .card-header {
            background: none;
            border: none;
            padding: 0;
            margin-bottom: 20px;
        }

        .card-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--text);
        }

        /* Table styling */
        .table-container {
            background: white;
            border-radius: 18px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
            border-collapse: separate;
            border-spacing: 0;
        }

        .table thead {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
        }

        .table thead th {
            padding: 15px 20px;
            border: none;
            font-weight: 500;
            font-size: 0.95rem;
        }

        .table tbody tr {
            transition: all 0.2s ease;
        }

        .table tbody tr:hover {
            background-color: rgba(94, 114, 228, 0.05);
            transform: translateY(-1px);
        }

        .table tbody td {
            padding: 15px 20px;
            vertical-align: middle;
            border-top: 1px solid var(--border);
            border-bottom: 1px solid var(--border);
        }

        .table tbody tr:first-child td {
            border-top: none;
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Status badges */
        .status-badge {
            padding: 6px 14px;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 500;
            display: inline-block;
            text-align: center;
            min-width: 100px;
        }

        .status-completed {
            background: rgba(45, 206, 137, 0.15);
            color: var(--completed);
        }

        .status-pending {
            background: rgba(251, 99, 64, 0.15);
            color: var(--pending);
        }

        .status-in-progress {
            background: rgba(17, 205, 239, 0.15);
            color: var(--in-progress);
        }

        /* Button styling */
        .action-btn {
            margin-right: 8px;
            border-radius: 12px;
            padding: 6px 14px;
            font-size: 0.85rem;
            font-weight: 500;
            box-shadow: 0 4px 10px rgba(94, 114, 228, 0.15);
            transition: all 0.3s ease;
            border: none;
        }

        .btn-warning {
            background: linear-gradient(to right, #fb6340, #fbb140);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(to right, #f5365c, #f56036);
            color: white;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(94, 114, 228, 0.25);
        }

        /* Date badge */
        .date-badge {
            background: white;
            border: 1px solid var(--border);
            color: var(--text);
            padding: 8px 15px;
            border-radius: 12px;
            font-weight: 500;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #718096;
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 15px;
            color: #e0e7ff;
        }

        .empty-state p {
            margin-bottom: 0;
            font-size: 1.1rem;
        }

        /* Due date styling */
        .due-date {
            font-weight: 500;
            padding: 5px 12px;
            border-radius: 12px;
            display: inline-block;
        }

        .date-urgent {
            background: rgba(251, 99, 64, 0.15);
            color: var(--pending);
        }

        .date-normal {
            background: rgba(17, 205, 239, 0.15);
            color: var(--in-progress);
        }

        /* Responsive */
        @media (max-width: 992px) {
            .table-container {
                overflow-x: auto;
            }
        }

        @media (max-width: 768px) {
            .action-buttons {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

            .action-btn {
                margin-right: 0;
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
            <h2>Manage Tasks</h2>
            <div class="date-display">
                <span class="date-badge">
                    <i class="fas fa-calendar me-2"></i>
                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE, MMMM d, yyyy" />
                </span>
            </div>
        </div>

        <!-- Tasks Table Card -->
        <div class="card">
            <div class="card-header">
                <h3 class="card-title"><i class="fas fa-tasks me-2"></i>Task List</h3>
            </div>

            <div class="table-container">
                <c:choose>
                    <c:when test="${not empty taskList && taskList.size() > 0}">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Title</th>
                                    <th>Assigned To</th>
                                    <th>Status</th>
                                    <th>Due Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="task" items="${taskList}">
                                    <tr>
                                        <td>${task.taskId}</td>
                                        <td>${task.title}</td>
                                        <td>${task.assignedTo}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${task.status eq 'Completed'}">
                                                    <span class="status-badge status-completed">
                                                        <i class="fas fa-check-circle me-1"></i> Completed
                                                    </span>
                                                </c:when>
                                                <c:when test="${task.status eq 'Pending'}">
                                                    <span class="status-badge status-pending">
                                                        <i class="fas fa-clock me-1"></i> Pending
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge status-in-progress">
                                                        <i class="fas fa-sync-alt me-1"></i> In Progress
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:set var="today" value="<%= new java.util.Date() %>" />
                                            <c:set var="daysDiff" value="${(task.deadline.time - today.time) / (1000 * 60 * 60 * 24)}" />
                                            <c:choose>
                                                <c:when test="${daysDiff < 2}">
                                                    <span class="due-date date-urgent">
                                                        <i class="fas fa-exclamation-circle me-1"></i>
                                                        <fmt:formatDate value="${task.deadline}" pattern="dd MMM yyyy" />
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="due-date date-normal">
                                                        <i class="fas fa-calendar-day me-1"></i>
                                                        <fmt:formatDate value="${task.deadline}" pattern="dd MMM yyyy" />
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="action-buttons">
                                            <a href="EditEntityServlet?type=task&id=${task.taskId}" class="btn btn-sm btn-warning action-btn">
                                                <i class="fas fa-edit me-1"></i> Edit
                                            </a>
                                            <a href="DeleteEntityServlet?type=task&id=${task.taskId}" class="btn btn-sm btn-danger action-btn"
                                               onclick="return confirm('Are you sure you want to delete this task?');">
                                                <i class="fas fa-trash me-1"></i> Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-clipboard-list"></i>
                            <p>No tasks found. Create your first task to get started!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>