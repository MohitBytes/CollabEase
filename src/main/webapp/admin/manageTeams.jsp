<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<jsp:include page="../Header/header.jsp"/>

<head>
<style>
    .action-btn {
        margin-right: 5px;
    }
</style>
</head>

<div class="container mt-4">
    <h3 class="mb-4">Manage Teams</h3>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Created By</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="team" items="${teamList}">
                <tr>
                    <td>${team.teamId}</td>
                    <td>${team.teamName}</td>
                    <td>${team.managerId}</td>
                    <td>
                        <a href="EditTeamServlet?id=${team.teamId}" class="btn btn-sm btn-warning action-btn">Edit</a>
                        <a href="DeleteTeamServlet?id=${team.teamId}" class="btn btn-sm btn-danger"
                           onclick="return confirm('Delete this team?');">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty teamList}">
                            <tr>
                                <td colspan="3">No teams found or data not loaded.</td>
                            </tr>
                        </c:if>
        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>