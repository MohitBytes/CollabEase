<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

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
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/AdminDashboardServlet">Dashboard</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="reportsDropdown" role="button"
                               data-bs-toggle="dropdown" aria-expanded="false">
                                Reports
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="reportsDropdown">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/ReportServlet?type=projects">Projects Report</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/ReportServlet?type=tasks">Tasks Report</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/ReportServlet?type=users">Users Report</a></li>
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
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="notificationDropdown" id="notificationList">
                        <li><span class="dropdown-item-text text-muted">No notifications</span></li>
                    </ul>
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

<div class="modal fade" id="notificationModal" tabindex="-1" aria-labelledby="notificationModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="notificationModalLabel">Notification Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="notificationModalBody">

      </div>
      <div class="modal-footer">
        <a href="${pageContext.request.contextPath}/AllNotificationServlet" class="btn btn-primary">See All Notifications <i class="fa fa-angle-right"></i></a>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    fetch("${pageContext.request.contextPath}/NotificationServlet")
        .then(response => response.json())
        .then(data => {
            const badge = document.getElementById('notificationCount');
            const list = document.getElementById('notificationList');

            if (data.length > 0) {
                badge.textContent = data.length;
                badge.style.display = 'inline';
                list.innerHTML = "";

                data.forEach(notification => {
                    const listItem = document.createElement("li");
                    const link = document.createElement("a");
                    link.href = "#";
                    link.className = "dropdown-item notification-item";
                    link.dataset.id = notification.notificationId;
                    link.dataset.message = notification.message;
                    link.dataset.time = notification.createdAt;
                    link.textContent = notification.message;
                    listItem.appendChild(link);
                    list.appendChild(listItem);
                });

                // See all notifications option
                const divider = document.createElement("li");
                divider.innerHTML = '<hr class="dropdown-divider">';
                list.appendChild(divider);

                const seeAll = document.createElement("li");
                seeAll.innerHTML = `<a class="dropdown-item text-center" href="${pageContext.request.contextPath}/AllNotificationServlet">See all notifications <i class="fa fa-angle-right"></i></a>`;
                list.appendChild(seeAll);

                attachNotificationClickHandlers();
            } else {
                badge.style.display = 'none';
                list.innerHTML = `<li><span class="dropdown-item-text text-muted">No notifications</span></li>`;
            }
        })
        .catch(error => {
            console.error("Notification fetch error:", error);
        });
});

function attachNotificationClickHandlers() {
    document.querySelectorAll('.notification-item').forEach(item => {
        item.addEventListener("click", function (e) {
            e.preventDefault();
            const msg = this.dataset.message;
            const rawTime = this.dataset.time;
            const time = formatRelativeTime(rawTime);
            const id = this.dataset.id;

            document.getElementById('notificationModalBody').innerHTML = `
                <p><strong>Message:</strong> ${msg}</p>
                <p><strong>Time:</strong> ${time}</p>
            `;

            const modal = new bootstrap.Modal(document.getElementById('notificationModal'));
            modal.show();

            fetch("${pageContext.request.contextPath}/NotificationServlet", {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `notificationId=${id}`
            });
        });
    });
}

function formatRelativeTime(dateString) {
    const now = new Date();
    const date = new Date(dateString);
    const diff = Math.floor((now - date) / 1000); // seconds

    if (diff < 60) return `${diff} seconds ago`;
    if (diff < 3600) return `${Math.floor(diff / 60)} minutes ago`;
    if (diff < 86400) return `${Math.floor(diff / 3600)} hours ago`;
    return date.toLocaleString();
}

// Mark all as read option
const markAll = document.createElement("li");
markAll.innerHTML = `<a class="dropdown-item text-center text-danger" href="#" id="markAllRead"><i class="fa fa-check-circle me-1"></i>Mark all as read</a>`;
list.appendChild(markAll);

// Attach handler
document.getElementById("markAllRead").addEventListener("click", function (e) {
    e.preventDefault();

    fetch("${pageContext.request.contextPath}/NotificationServlet", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "action=markAllRead"
    })
    .then(res => {
        if (res.ok) {
            // Refresh the notification list or just reload
            location.reload(); // quick way to update everything
        } else {
            alert("Failed to mark all as read.");
        }
    })
    .catch(err => console.error("Error marking all as read:", err));
});

</script>
