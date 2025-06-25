<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
    <c:if test="${not empty user}">
        <h1>Welcome, <c:out value="${user.fullName}" /></h1>
    </c:if>
    <c:if test="${empty user}">
        <h1>Welcome, Guest</h1>
    </c:if>
    <a href="LogoutServlet">Logout</a>
</body>
</html>