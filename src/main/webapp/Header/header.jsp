<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Fonts and Icons -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<style>
    body, html {
        margin: 0;
        padding: 0;
    }

    :root {
        --primary: #5e72e4;
        --background: #ffffff;
        --text: #344767;
        --light-hover: rgba(94, 114, 228, 0.1);
        --danger: #ff6b6b;
    }

    .navbar {
        position: static;
        font-family: 'Poppins', sans-serif;
        background: var(--background);
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        padding: 12px 24px;
        z-index: 999;
    }

    .navbar-brand {
        display: flex;
        align-items: center;
        font-size: 1.5rem;
        font-weight: 600;
        color: var(--primary);
        text-decoration: none;
        gap: 8px;
    }

    .navbar-brand i {
        font-size: 1.7rem;
    }

    .nav-link {
        font-weight: 500;
        color: var(--text);
        padding: 8px 16px;
        border-radius: 6px;
        transition: 0.3s ease;
    }

    .nav-link:hover, .nav-link.active {
        background: var(--light-hover);
        color: var(--primary);
    }

    .dropdown-menu {
        border-radius: 10px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        border: none;
    }

    .dropdown-item {
        font-size: 0.95rem;
        padding: 10px 16px;
        transition: 0.3s;
    }

    .dropdown-item:hover {
        background-color: var(--light-hover);
        color: var(--primary);
    }

    .notification-icon {
        position: relative;
        font-size: 1.3rem;
        cursor: pointer;
        color: var(--text);
        margin-right: 20px;
    }

    .notification-badge {
        position: absolute;
        top: -6px;
        right: -6px;
        background: var(--danger);
        color: #fff;
        font-size: 0.7rem;
        width: 18px;
        height: 18px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .user-greeting {
        font-weight: 500;
        font-size: 0.95rem;
        color: var(--primary);
        background-color: var(--light-hover);
        padding: 6px 14px;
        border-radius: 50px;
    }

    .logout-btn {
        color: var(--danger);
        background-color: rgba(255, 107, 107, 0.1);
        padding: 6px 14px;
        border-radius: 50px;
        font-weight: 500;
        text-decoration: none;
    }

    .logout-btn:hover {
        background-color: rgba(255, 107, 107, 0.2);
    }

    @media (max-width: 991px) {
        .user-info {
            flex-direction: column;
            align-items: flex-start;
            gap: 10px;
            margin-top: 10px;
        }
    }
</style>

<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}">
            <i class="fas fa-users"></i> CollabEase
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <i class="bi bi-list"></i>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <c:choose>
                <c:when test="${user.role eq 'ADMIN'}">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/AdminDashboardServlet">Dashboard</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="reportsDropdown" role="button" data-bs-toggle="dropdown">
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
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/ManagerDashboardServlet">Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/TeamServlet">Teams</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/ProjectServlet">Projects</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/TaskServlet">Tasks</a></li>
                    </ul>
                </c:when>

                <c:when test="${user.role eq 'MEMBER'}">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/MemberDashboardServlet">Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/projects">Projects</a></li>
                    </ul>
                </c:when>
            </c:choose>

            <!-- Right Section -->
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
                <li class="nav-item dropdown">
                    <a class="nav-link" href="#" id="notificationDropdown" role="button" data-bs-toggle="dropdown">
                        <div class="notification-icon">
                            <i class="bi bi-bell-fill"></i>
                            <span id="notificationCount" class="notification-badge" style="display: none;">0</span>
                        </div>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" id="notificationList">
                        <li class="px-3 py-2 text-muted small">Notifications</li>
                        <li class="text-center py-3 text-muted" id="noNotifications">No notifications</li>
                    </ul>
                </li>
                <li class="nav-item user-info">
                    <span class="user-greeting">
                        <i class="bi bi-person-fill me-1"></i>${user.fullName}
                    </span>
                    <a class="logout-btn" href="${pageContext.request.contextPath}/signin/LogoutServlet">
                        <i class="bi bi-box-arrow-right me-1"></i>Logout
                    </a>
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
