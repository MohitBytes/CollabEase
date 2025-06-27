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
    <h3 class="mb-4">Manage Users</h3>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
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
                    <td>
                        <a href="EditUserServlet?id=${user.userId}" class="btn btn-sm btn-warning action-btn">Edit</a>
                        <a href="DeleteUserServlet?id=${user.userId}" class="btn btn-sm btn-danger"
                           onclick="return confirm('Delete this user?');">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>