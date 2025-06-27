<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../Header/header.jsp" />

<div class="container mt-4">
    <h3>Edit User</h3>
    <form method="post" action="../EditEntityServlet">
        <input type="hidden" name="type" value="user">
        <input type="hidden" name="id" value="${user.userId}">

        <div class="mb-3">
            <label for="fullName" class="form-label">Full Name</label>
            <input type="text" class="form-control" name="fullName" id="fullName" value="${user.fullName}" required>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" name="email" id="email" value="${user.email}" required>
        </div>

        <div class="mb-3">
            <label for="role" class="form-label">Role</label>
            <select class="form-select" name="role" id="role">
                <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>Admin</option>
                <option value="member" ${user.role == 'member' ? 'selected' : ''}>Member</option>
            </select>
        </div>

        <button type="submit" class="btn btn-info">Update User</button>
    </form>
</div>
