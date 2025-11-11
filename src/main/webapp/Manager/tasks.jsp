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

        .btn-primary {
            background: linear-gradient(to right, var(--primary), var(--secondary));
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 14px rgba(94, 114, 228, 0.3);
        }

        .alert {
            border-radius: 12px;
            padding: 15px 20px;
            font-weight: 500;
            margin-bottom: 25px;
            box-shadow: var(--card-shadow);
            border: none;
        }

        .alert-success {
            background: linear-gradient(to right, #2dce89, #1aae6f);
            color: white;
        }

        .alert-danger {
            background: linear-gradient(to right, #f5365c, #f56036);
            color: white;
        }

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

        .card-body {
            padding: 25px 0 0 0;
        }

        @media (max-width: 768px) {
            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
        }

        .priority-indicator {
            display: inline-block;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            margin-right: 8px;
        }

        .priority-LOW { background-color: #6c757d; }
        .priority-MEDIUM { background-color: #17a2b8; }
        .priority-HIGH { background-color: #ffc107; }
        .priority-URGENT { background-color: #dc3545; }
    </style>
</head>
<body>
    <jsp:include page="../Header/header.jsp"/>

    <div class="container mt-4">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <h2>Manage Tasks</h2>
            <div class="date-display">
                <i class="fas fa-calendar"></i>
                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE, MMMM d, yyyy" />
            </div>
        </div>

        <div class="row">
            <!-- Sidebar Navigation -->
            <div class="col-lg-3">
                <div class="sidebar-container">
                    <div class="sidebar-header">Navigation</div>
                    <div class="list-group">
                        <a href="ManagerDashboardServlet" class="list-group-item list-group-item-action">
                            <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                        </a>
                        <a href="TeamServlet" class="list-group-item list-group-item-action">
                            <i class="fas fa-users me-2"></i>Manage Teams
                        </a>
                        <a href="ProjectServlet" class="list-group-item list-group-item-action">
                            <i class="fas fa-project-diagram me-2"></i>Manage Projects
                        </a>
                        <a href="TaskServlet" class="list-group-item list-group-item-action active">
                            <i class="fas fa-tasks me-2"></i>Manage Tasks
                        </a>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-lg-9">
                <!-- Alerts -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle me-2"></i>${success}
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                    </div>
                </c:if>

                <!-- Create Task Card -->
                <div class="card">
                    <div class="card-header">Create New Task</div>
                    <div class="card-body">
                        <form action="TaskServlet" method="POST" id="taskForm">
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label class="form-label">Task Title</label>
                                    <input type="text" name="title" class="form-control" required placeholder="Enter task title">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Project</label>
                                    <select name="projectId" class="form-select" required>
                                        <option value="" disabled selected>Select a project</option>
                                        <c:forEach items="${projects}" var="project">
                                            <option value="${project.projectId}">${project.projectName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Description</label>
                                <textarea name="description" class="form-control" rows="3" placeholder="Describe the task"></textarea>
                            </div>

                            <div class="row mb-4">
                                <div class="col-md-4">
                                    <label class="form-label">Priority</label>
                                    <select name="priority" class="form-select" required>
                                        <option value="LOW">
                                            <span class="priority-indicator priority-LOW"></span> Low
                                        </option>
                                        <option value="MEDIUM" selected>
                                            <span class="priority-indicator priority-MEDIUM"></span> Medium
                                        </option>
                                        <option value="HIGH">
                                            <span class="priority-indicator priority-HIGH"></span> High
                                        </option>
                                        <option value="URGENT">
                                            <span class="priority-indicator priority-URGENT"></span> Urgent
                                        </option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Deadline</label>
                                    <input type="date" name="deadline" class="form-control" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Assignment</label>
                                    <select name="assignment" id="assignmentType" class="form-select" required>
                                        <option value="auto">Auto-Assign</option>
                                        <option value="manual">Manual Assign</option>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-4" id="assigneeField" style="display: none;">
                                <label class="form-label">Assign To</label>
                                <select name="assignedTo" class="form-select">
                                    <option value="" disabled selected>Select a team member</option>
                                    <c:forEach items="${users}" var="user">
                                        <option value="${user.userId}">${user.fullName}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-plus-circle me-2"></i>Create Task
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Set minimum date to today for deadline
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.querySelector('input[type="date"]').min = today;

            // Initialize assignment type
            $('#assignmentType').trigger('change');
        });

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