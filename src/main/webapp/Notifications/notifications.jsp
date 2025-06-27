<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>All Notifications</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container mt-4">
    <h3 class="mb-3">All Notifications</h3>

    <div class="d-flex justify-content-between mb-3">
        <div>
            <button id="markAllRead" class="btn btn-outline-success btn-sm">✔ Mark All as Read</button>
            <button id="clearAll" class="btn btn-outline-danger btn-sm">🗑 Clear All</button>
        </div>

        <div>
            <select id="typeFilter" class="form-select form-select-sm" style="width: 200px;">
                <option value="all">All Types</option>
                <option value="STATUS_UPDATE">Status Update</option>
                <option value="DEADLINE_REMINDER">Deadline Reminder</option>
                <option value="TASK_ASSIGNED">Task Assigned</option>
                <option value="NEW_COMMENT">New Comment</option>
            </select>
        </div>
    </div>

    <ul class="list-group" id="notificationList">
        <c:forEach var="n" items="${notifications}">
            <li class="list-group-item d-flex justify-content-between align-items-center notification-item" data-type="${fn:toLowerCase(n.type)}">
                <div>
                    <strong>${n.message}</strong>
                    <small class="text-muted ms-2">${n.createdAt}</small>
                </div>
                <span class="badge ${n.read ? 'bg-secondary' : 'bg-primary'}">${n.read ? 'Read' : 'Unread'}</span>
            </li>
        </c:forEach>
    </ul>
</div>

<script>
    document.getElementById('typeFilter').addEventListener('change', function () {
        const selectedType = this.value.toLowerCase();

        document.querySelectorAll('.notification-item').forEach(item => {
            const itemType = item.dataset.type?.toLowerCase() || "";

            if (selectedType === 'all' || itemType === selectedType) {
                item.style.display = '';
            } else {
                item.style.display = 'none';
            }
        });
    });


    document.getElementById('markAllRead').addEventListener('click', function () {
        if (confirm("Mark all notifications as read?")) {
            fetch("NotificationBulkServlet?action=markAll", { method: "POST" })
                .then(() => location.reload());
        }
    });

    document.getElementById('clearAll').addEventListener('click', function () {
        if (confirm("Clear all notifications?")) {
            fetch("NotificationBulkServlet?action=clearAll", { method: "POST" })
                .then(() => location.reload());
        }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
