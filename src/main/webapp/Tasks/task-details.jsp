<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary: #5e72e4;
            --primary-light: #8a9eff;
            --secondary: #6a11cb;
            --light: #f8f9fe;
            --accent: #ff6b6b;
            --text: #344767;
            --border: #e0e7ff;
            --card-shadow: 0 10px 25px rgba(94, 114, 228, 0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edff 100%);
            color: var(--text);
            min-height: 100vh;
            padding-top: 80px;
        }

        .container {
            max-width: 1200px;
            padding: 20px;
        }

        .dashboard-header {
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .dashboard-header h2 {
            font-weight: 600;
            font-size: 1.8rem;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0;
        }

        .card {
            background: white;
            border-radius: 18px;
            border: none;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            margin-bottom: 25px;
            position: relative;
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(94, 114, 228, 0.2);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, var(--primary), var(--secondary));
        }

        .card-header {
            background-color: white;
            border-bottom: 1px solid var(--border);
            padding: 20px 25px;
            font-weight: 600;
            font-size: 1.2rem;
            border-radius: 18px 18px 0 0 !important;
        }

        .card-body {
            padding: 25px;
        }

        .badge {
            padding: 6px 12px;
            border-radius: 12px;
            font-weight: 500;
            font-size: 0.9rem;
        }

        .badge-danger { background: linear-gradient(to right, #f5365c, #f56036); }
        .badge-warning { background: linear-gradient(to right, #fb6340, #fbb140); }
        .badge-primary { background: linear-gradient(to right, #11cdef, #1171ef); }
        .badge-success { background: linear-gradient(to right, #2dce89, #1aae6f); }
        .badge-info { background: linear-gradient(to right, var(--primary), var(--secondary)); }

        .comment-card {
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 12px;
            background-color: rgba(94, 114, 228, 0.05);
            border-left: 3px solid var(--primary);
            transition: all 0.3s ease;
        }

        .comment-card:hover {
            transform: translateX(5px);
            background-color: rgba(94, 114, 228, 0.1);
        }

        .comment-author {
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 5px;
        }

        .comment-time {
            font-size: 0.8rem;
            color: #718096;
            margin-bottom: 10px;
        }

        .btn {
            border-radius: 12px;
            padding: 10px 20px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
        }

        .btn-outline-secondary {
            border: 1px solid var(--border);
            color: var(--text);
        }

        .btn-outline-secondary:hover {
            background: rgba(94, 114, 228, 0.1);
            color: var(--primary);
            border-color: var(--primary-light);
        }

        .btn-primary {
            background: linear-gradient(to right, var(--primary), var(--secondary));
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 14px rgba(94, 114, 228, 0.3);
        }

        .form-select {
            border-radius: 12px;
            padding: 10px 15px;
            border: 1px solid var(--border);
            max-width: 250px;
        }

        .form-select:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 0.25rem rgba(94, 114, 228, 0.25);
        }

        .form-control {
            border-radius: 12px;
            padding: 12px 15px;
            border: 1px solid var(--border);
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 0.25rem rgba(94, 114, 228, 0.25);
        }

        .task-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .task-meta-item {
            background: rgba(94, 114, 228, 0.1);
            padding: 10px 15px;
            border-radius: 12px;
            font-weight: 500;
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .task-description {
            line-height: 1.8;
            margin-bottom: 25px;
        }

        .status-container {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-top: 25px;
        }

        .status-label {
            font-weight: 600;
            color: var(--text);
        }

        @media (max-width: 768px) {
            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .task-meta {
                flex-direction: column;
                align-items: flex-start;
            }

            .status-container {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../Header/header.jsp"/>

    <div class="container mt-4">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <div>
                <h2>Task Details</h2>
                <p class="welcome-message">Task ID: ${task.taskId}</p>
            </div>
            <a href="${pageContext.request.contextPath}/MemberDashboardServlet" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
            </a>
        </div>

        <!-- Task Details Card -->
        <div class="card">
            <div class="card-body">
                <!-- Task Metadata -->
                <div class="task-meta">
                    <div>
                        <span class="badge badge-${task.priority == 'URGENT' ? 'danger' :
                                             task.priority == 'HIGH' ? 'warning' : 'success'}">
                            <i class="fas fa-flag me-1"></i>${task.priority}
                        </span>
                        <span class="badge badge-info">
                            <i class="fas fa-tasks me-1"></i>${task.status}
                        </span>
                    </div>
                    <div class="task-meta-item">
                        <i class="fas fa-calendar-day"></i>
                        <strong>Deadline:</strong>
                        <fmt:formatDate value="${task.deadline}" pattern="MMM dd, yyyy hh:mm a"/>
                    </div>
                </div>

                <!-- Task Description -->
                <div class="task-description">
                    <h5 class="mb-3">Description</h5>
                    <p class="card-text">${task.description}</p>
                </div>

                <!-- Status Update Section -->
                <div class="status-container">
                    <div class="status-label">Update Status:</div>
                    <select class="form-select status-select"
                            data-task-id="${task.taskId}">
                        <option value="TODO" ${task.status == 'TODO' ? 'selected' : ''}>To Do</option>
                        <option value="IN_PROGRESS" ${task.status == 'IN_PROGRESS' ? 'selected' : ''}>In Progress</option>
                        <option value="BLOCKED" ${task.status == 'BLOCKED' ? 'selected' : ''}>Blocked</option>
                        <option value="COMPLETED" ${task.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- Comments Section -->
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0"><i class="fas fa-comments me-2"></i>Comments</h5>
            </div>
            <div class="card-body">
                <div id="commentsContainer">
                    <c:forEach items="${comments}" var="comment">
                        <div class="comment-card">
                            <div class="comment-author">
                                <i class="fas fa-user-circle me-2"></i>${comment.userFullName}
                            </div>
                            <div class="comment-time">
                                <i class="fas fa-clock me-1"></i>
                                <fmt:formatDate value="${comment.createdAt}" pattern="MMM dd, yyyy hh:mm a"/>
                            </div>
                            <p>${comment.content}</p>
                        </div>
                    </c:forEach>

                    <c:if test="${empty comments}">
                        <div class="text-center text-muted py-4">
                            <i class="fas fa-comment-slash fa-2x mb-3"></i>
                            <p>No comments yet. Be the first to add one!</p>
                        </div>
                    </c:if>
                </div>

                <form action="CommentServlet" method="POST" class="mt-4">
                    <input type="hidden" name="taskId" value="${task.taskId}">
                    <div class="mb-3">
                        <textarea name="content" class="form-control"
                                  placeholder="Add your comment here..."
                                  rows="3" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-paper-plane me-2"></i>Post Comment
                    </button>
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
                        const badge = $('.badge-info');
                        badge.text(newStatus);

                        // Update badge color based on new status
                        if (newStatus === 'COMPLETED') {
                            badge.removeClass('badge-info').addClass('badge-success');
                        } else if (newStatus === 'BLOCKED') {
                            badge.removeClass('badge-info').addClass('badge-danger');
                        } else {
                            badge.removeClass('badge-success badge-danger').addClass('badge-info');
                        }
                    } else {
                        alert('Error updating status');
                    }
                });
            });
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>