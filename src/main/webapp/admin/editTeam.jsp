<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../Header/header.jsp" />

<div class="container mt-4">
    <h3>Edit Team</h3>
    <form method="post" action="../EditEntityServlet">
        <input type="hidden" name="type" value="team">
        <input type="hidden" name="id" value="${team.teamId}">

        <div class="mb-3">
            <label for="name" class="form-label">Team Name</label>
            <input type="text" class="form-control" name="name" id="name" value="${team.teamName}" required>
        </div>

        <button type="submit" class="btn btn-success">Update Team</button>
    </form>
</div>
