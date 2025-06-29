<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<jsp:include page="../Header/header.jsp" />

<div class="container mt-4">
    <h3>Edit Project</h3>
    <form method="post" action="EditEntityServlet">
        <input type="hidden" name="type" value="project">
        <input type="hidden" name="id" value="${project.projectId}">

        <div class="mb-3">
            <label for="name" class="form-label">Project Name</label>
            <input type="text" class="form-control" name="name" id="name" value="${project.projectName}" required>
        </div>

        <button type="submit" class="btn btn-primary">Update Project</button>
    </form>
</div>