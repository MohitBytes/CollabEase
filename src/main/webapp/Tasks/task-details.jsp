<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .comment-card {
            border-left: 3px solid #0d6efd;
            padding-left: 15px;
            margin-bottom: 15px;
        }
        .comment-author {
            font-weight: bold;
            color: #0d6efd;
        }
        .comment-time {
            font-size: 0.8rem;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>${task.title}</h2>
            <a href="${pageContext.request.contextPath}/Member/dashboard" class="btn btn-outline-secondary">Back to Dashboard</a>
        </div>

        <div class="card mb-4">
            <div class="card-body">
                <div class="d-flex justify-content-between mb-3">
                    <div>
                        <span class="badge bg-${task.priority == 'URGENT' ? 'danger' :
                                             task.priority == 'HIGH' ? 'warning' : 'success'}">
                            ${task.priority}
                        </span>
                        <span class="badge bg-info">${task.status}</span>
                    </div>
                    <div>
                        <strong>Deadline:</strong>
                        <fmt:formatDate value="${task.deadline}" pattern="MMM dd, yyyy hh:mm a"/>
                    </div>
                </div>

                <p class="card-text">${task.description}</p>

                <div class="mt-4">
                    <h5>Status</h5>
                    <select class="form-select status-select"
                            data-task-id="${task.taskId}"
                            style="width: auto;">
                        <option value="TODO" ${task.status == 'TODO' ? 'selected' : ''}>To Do</option>
                        <option value="IN_PROGRESS" ${task.status == 'IN_PROGRESS' ? 'selected' : ''}>In Progress</option>
                        <option value="BLOCKED" ${task.status == 'BLOCKED' ? 'selected' : ''}>Blocked</option>
                        <option value="COMPLETED" ${task.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-header">
                <h5 class="mb-0">Comments</h5>
            </div>
            <div class="card-body">
                <div id="commentsContainer">
                    <c:forEach items="${comments}" var="comment">
                        <div class="comment-card">
                            <div class="comment-author">${comment.userFullName}</div>
                            <div class="comment-time">
                                <fmt:formatDate value="${comment.createdAt}" pattern="MMM dd, yyyy hh:mm a"/>
                            </div>
                            <p>${comment.content}</p>
                        </div>
                    </c:forEach>
                </div>

                <form action="CommentServlet" method="POST" class="mt-4">
                    <input type="hidden" name="taskId" value="${task.taskId}">
                    <div class="mb-3">
                        <textarea name="content" class="form-control" placeholder="Add a comment..." required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Post Comment</button>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // Status update
            $('.status-select').change(function() {
                const taskId = $(this).data('task-id');
                const newStatus = $(this).val();

                $.post('${pageContext.request.contextPath}/update-task-status', {
                    taskId: taskId,
                    status: newStatus
                }, function(response) {
                    if (response === 'success') {
                        alert('Status updated successfully!');
                    } else {
                        alert('Error updating status');
                    }
                });
            });
        });
    </script>
    <script>
        $(document).ready(function() {
            // Load notifications on page load
            loadNotifications();

            // Poll for new notifications every 30 seconds
            setInterval(loadNotifications, 30000);

            function loadNotifications() {
                $.get('${pageContext.request.contextPath}/notifications', function(notifications) {
                    $('#notificationCount').text(notifications.length);

                    if (notifications.length > 0) {
                        let html = '';
                        notifications.forEach(notif => {
                            html += `
                                <li>
                                    <a class="dropdown-item notification-item" href="#"
                                       data-id="\${notif.notificationId}">
                                        <div class="small text-muted">\${formatTime(notif.createdAt)}</div>
                                        \${notif.message}
                                    </a>
                                </li>`;
                        });
                        html += `<li><hr class="dropdown-divider"></li>
                                 <li><a class="dropdown-item text-center" href="#">Mark all as read</a></li>`;
                        $('#notificationList').html(html);
                    } else {
                        $('#notificationList').html('<li><a class="dropdown-item" href="#">No notifications</a></li>');
                    }

                    // Handle notification click
                    $('.notification-item').click(function() {
                        const notificationId = $(this).data('id');
                        $.post('${pageContext.request.contextPath}/notifications', {
                            notificationId: notificationId
                        });
                        $(this).closest('li').remove();
                        // TODO: Redirect to relevant page
                    });
                });
            }

            function formatTime(timestamp) {
                const date = new Date(timestamp);
                return date.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
            }
        });
    </script>
</body>
</html>