<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users</title>
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

        /* Responsive */
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
            <h2>Manage Users</h2>
            <div class="date-display">
                <span class="date-badge">
                    <i class="fas fa-calendar me-2"></i>
                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE, MMMM d, yyyy" />
                </span>
            </div>
        </div>

        <!-- Users Table Card -->
        <div class="card">
            <div class="card-header">
                <h3 class="card-title"><i class="fas fa-users me-2"></i>User List</h3>
            </div>

            <div class="table-container">
                <c:choose>
                    <c:when test="${not empty userList && userList.size() > 0}">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Full Name</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${userList}">
                                    <tr>
                                        <td>${user.userId}</td>
                                        <td>${user.fullName}</td>
                                        <td>${user.email}</td>
                                        <td>${user.role}</td>
                                        <td class="action-buttons">
                                            <a href="EditEntityServlet?type=user&id=${user.userId}" class="btn btn-sm btn-warning action-btn">
                                                <i class="fas fa-edit me-1"></i> Edit
                                            </a>
                                            <a href="DeleteEntityServlet?type=user&id=${user.userId}" class="btn btn-sm btn-danger action-btn"
                                               onclick="return confirm('Are you sure you want to delete this user?');">
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
                            <i class="fas fa-user-friends"></i>
                            <p>No users found. Add your first user to get started!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>