<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet" />

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}">CollabEase</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">

            <!-- Role-specific navbar items -->
            <c:choose>
                <c:when test="${user.role eq 'ADMIN'}">
                    <ul class="navbar-nav me-auto">
                        <!-- Dashboard link -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/AdminDashboardServlet">Dashboard</a>
                        </li>
                          <!-- Dropdown for Reports -->
                                                <li class="nav-item dropdown">
                                                    <a class="nav-link dropdown-toggle" href="#" id="reportsDropdown" role="button"
                                                       data-bs-toggle="dropdown" aria-expanded="false">
                                                        Reports
                                                    </a>
                                                    <ul class="dropdown-menu" aria-labelledby="reportsDropdown">
                                                        <li>
                                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/ReportServlet?type=projects">Projects Report</a>
                                                        </li>
                                                        <li>
                                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/ReportServlet?type=tasks">Tasks Report</a>
                                                        </li>
                                                        <li>
                                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/ReportServlet?type=users">Users Report</a>
                                                        </li>
                                                    </ul>
                                                </li>
                                            </ul>
                                        </c:when>

                <c:when test="${user.role eq 'MANAGER'}">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/Manager/dashboard.jsp">Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/teams">Teams</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/projects">Projects</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/tasks">Tasks</a></li>
                    </ul>
                </c:when>

                <c:when test="${user.role eq 'MEMBER'}">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/Member/dashboard.jsp">Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/projects">Projects</a></li>
                    </ul>
                </c:when>
            </c:choose>

            <!-- Right-side (notifications & profile) -->
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link position-relative" href="#" id="notificationDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-bell-fill"></i>
                        <span id="notificationCount" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                            0
                        </span>
                    </a>
                    <!-- Notification dropdown can go here -->
                </li>
                <li class="nav-item">
                    <span class="navbar-text me-3">Welcome, ${user.fullName}</span>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/signin/LogoutServlet">Logout</a>
                </li>
            </ul>

        </div>
    </div>
</nav>
