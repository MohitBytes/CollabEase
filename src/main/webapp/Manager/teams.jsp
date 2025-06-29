<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Teams</title>
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
            color: white;
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

        .team-list {
            background: white;
            border-radius: 18px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
        }

        .team-item {
            display: flex;
            align-items: center;
            padding: 20px 25px;
            border-bottom: 1px solid var(--border);
            transition: all 0.3s ease;
        }

        .team-item:last-child {
            border-bottom: none;
        }

        .team-item:hover {
            background-color: rgba(94, 114, 228, 0.05);
            transform: translateX(5px);
        }

        .team-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            color: white;
            font-size: 1.2rem;
        }

        .team-name {
            font-weight: 500;
            font-size: 1.1rem;
            flex-grow: 1;
        }

        .team-actions {
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .team-item:hover .team-actions {
            opacity: 1;
        }

        .btn-icon {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0;
            margin-left: 8px;
        }

        @media (max-width: 768px) {
            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .team-item {
                flex-direction: column;
                text-align: center;
                padding: 25px;
            }

            .team-icon {
                margin-right: 0;
                margin-bottom: 15px;
            }

            .team-name {
                margin-bottom: 15px;
            }

            .team-actions {
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../Header/header.jsp"/>

    <div class="container mt-4">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <h2>Manage Teams</h2>
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
                        <a href="TeamServlet" class="list-group-item list-group-item-action active">
                            <i class="fas fa-users me-2"></i>Manage Teams
                        </a>
                        <a href="ProjectServlet" class="list-group-item list-group-item-action">
                            <i class="fas fa-project-diagram me-2"></i>Manage Projects
                        </a>
                        <a href="TaskServlet" class="list-group-item list-group-item-action">
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

                <!-- Create Team Card -->
                <div class="card">
                    <div class="card-header">Create New Team</div>
                    <div class="card-body">
                        <form action="TeamServlet" method="POST">
                            <div class="mb-4">
                                <label class="form-label">Team Name</label>
                                <input type="text" name="teamName" class="form-control" required placeholder="Enter team name">
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-plus-circle me-2"></i>Create Team
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Teams List -->
                <div class="card">
                    <div class="card-header">Your Teams</div>
                    <div class="card-body p-0">
                        <div class="team-list">
                            <c:forEach items="${teams}" var="team">
                                <div class="team-item">
                                    <div class="team-icon">
                                        <i class="fas fa-users"></i>
                                    </div>
                                    <div class="team-name">${team.teamName}</div>
                                    <div class="team-actions">
                                        <button class="btn btn-icon" style="background-color: rgba(94, 114, 228, 0.1);">
                                            <i class="fas fa-edit text-primary"></i>
                                        </button>
                                        <button class="btn btn-icon" style="background-color: rgba(245, 54, 92, 0.1);">
                                            <i class="fas fa-trash-alt text-danger"></i>
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>

                            <c:if test="${empty teams}">
                                <div class="text-center p-5">
                                    <i class="fas fa-users fa-3x text-muted mb-3"></i>
                                    <p class="text-muted">No teams created yet. Start by creating your first team!</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>