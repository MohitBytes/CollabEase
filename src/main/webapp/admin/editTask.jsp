<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Task</title>
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
            --warning: #fb6340;
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
            max-width: 800px;
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
            background: linear-gradient(to right, var(--warning), #fbb140);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0;
        }

        .edit-card {
            background: white;
            border-radius: 18px;
            padding: 30px;
            box-shadow: var(--card-shadow);
            position: relative;
            overflow: hidden;
            border: none;
        }

        .edit-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, var(--warning), #fbb140);
        }

        .form-label {
            font-weight: 500;
            color: var(--text);
            margin-bottom: 8px;
        }

        .form-control {
            border-radius: 12px;
            padding: 12px 15px;
            border: 1px solid var(--border);
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }

        .form-control:focus {
            border-color: var(--warning);
            box-shadow: 0 0 0 0.25rem rgba(251, 99, 64, 0.25);
        }

        .btn {
            border-radius: 12px;
            padding: 12px 25px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            font-size: 1rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-warning {
            background: linear-gradient(to right, var(--warning), #fbb140);
            color: white;
        }

        .btn-outline-secondary {
            border: 1px solid var(--border);
            color: var(--text);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 14px rgba(251, 99, 64, 0.3);
        }

        .btn-outline-secondary:hover {
            background: rgba(94, 114, 228, 0.1);
            color: var(--primary);
            border-color: var(--primary-light);
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .task-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border);
        }

        .task-id {
            background: rgba(251, 99, 64, 0.1);
            color: var(--warning);
            padding: 6px 15px;
            border-radius: 20px;
            font-weight: 500;
        }

        .priority-badge {
            padding: 6px 15px;
            border-radius: 20px;
            font-weight: 500;
        }

        .badge-danger { background: linear-gradient(to right, #f5365c, #f56036); }
        .badge-warning { background: linear-gradient(to right, var(--warning), #fbb140); }
        .badge-success { background: linear-gradient(to right, #2dce89, #1aae6f); }

        .form-section {
            margin-bottom: 25px;
        }

        .form-section h5 {
            font-weight: 600;
            color: var(--warning);
            margin-bottom: 15px;
            padding-bottom: 8px;
            border-bottom: 1px solid var(--border);
        }

        .status-indicator {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .status-dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            display: inline-block;
        }

        .status-dot.pending { background-color: #6c757d; }
        .status-dot.in-progress { background-color: #11cdef; }
        .status-dot.completed { background-color: #2dce89; }

        .date-picker-container {
            display: flex;
            gap: 15px;
        }

        @media (max-width: 768px) {
            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .action-buttons {
                flex-direction: column;
                gap: 10px;
            }

            .btn {
                width: 100%;
            }

            .date-picker-container {
                flex-direction: column;
                gap: 0;
            }

            .task-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../Header/header.jsp" />

    <div class="container mt-4">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <div>
                <h2>Edit Task</h2>
                <p class="welcome-message">Update task details and assignments</p>
            </div>
        </div>

        <!-- Edit Card -->
        <div class="edit-card">
            <!-- Task Header -->
            <div class="task-header">
                <div class="task-id">
                    <i class="fas fa-hashtag me-2"></i>Task ID: ${task.taskId}
                </div>
                <div>
                    <span class="priority-badge badge-${task.priority == 'URGENT' ? 'danger' :
                                             task.priority == 'HIGH' ? 'warning' : 'success'}">
                        <i class="fas fa-flag me-2"></i>${task.priority} Priority
                    </span>
                </div>
            </div>

            <!-- Edit Form -->
            <form method="post" action="EditEntityServlet">
                <input type="hidden" name="type" value="task">
                <input type="hidden" name="id" value="${task.taskId}">

                <div class="form-section">
                    <h5>Task Information</h5>
                    <div class="mb-3">
                        <label for="title" class="form-label">Task Title</label>
                        <input type="text" class="form-control" name="title" id="title"
                               value="${task.title}" required>
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" name="description" id="description"
                                  rows="4">${task.description}</textarea>
                    </div>
                </div>

                <div class="form-section">
                    <h5>Assignment & Status</h5>
                    <div class="mb-3">
                        <label for="assignedTo" class="form-label">Assigned To</label>
                        <select class="form-select" name="assignedTo" id="assignedTo" required>
                            <c:forEach items="${teamMembers}" var="member">
                                <option value="${member.userId}" ${member.userId == task.assignedTo ? 'selected' : ''}>
                                    ${member.fullName} (${member.role})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="status" class="form-label">Status</label>
                        <select class="form-select" name="status" id="status">
                            <option value="TODO" ${task.status == 'TODO' ? 'selected' : ''}>
                                <span class="status-dot pending"></span> To Do
                            </option>
                            <option value="IN_PROGRESS" ${task.status == 'IN_PROGRESS' ? 'selected' : ''}>
                                <span class="status-dot in-progress"></span> In Progress
                            </option>
                            <option value="COMPLETED" ${task.status == 'COMPLETED' ? 'selected' : ''}>
                                <span class="status-dot completed"></span> Completed
                            </option>
                        </select>
                    </div>
                </div>

                <div class="form-section">
                    <h5>Timeline</h5>
                    <div class="row">
                        <div class="col-md-6">
                            <label for="deadline" class="form-label">Deadline</label>
                            <input type="date" class="form-control" name="deadline" id="deadline"
                                   <c:if test="${not empty task.deadline}">
                                       <input type="date" class="form-control" name="deadline" id="deadline"
                                              value="<fmt:formatDate value='${task.deadline}' pattern='yyyy-MM-dd'/>" required>
                                   </c:if>
                        </div>
                    </div>
                </div>

                <div class="action-buttons">
                    <button type="submit" class="btn btn-warning">
                        <i class="fas fa-save me-2"></i>Update Task
                    </button>
                    <button type="button" class="btn btn-outline-secondary">
                        <i class="fas fa-times me-2"></i>Cancel
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            // Cancel button functionality
            $('.btn-outline-secondary').click(function() {
                window.location.href = '${pageContext.request.contextPath}/TaskServlet';
            });

            // Form submission feedback
            $('form').submit(function(e) {
                $('.btn-warning').html('<i class="fas fa-spinner fa-spin me-2"></i>Updating...');
                $('.btn-warning').prop('disabled', true);
            });

            // Status indicator dots in select options
            $('#status option').each(function() {
                const status = $(this).val().toLowerCase().replace('_', '-');
                const dotColor = $(this).find('.status-dot').attr('class').split(' ')[1];
                $(this).prepend(`<span class="status-dot ${dotColor} me-2"></span>`);
            });
        });
    </script>
</body>
</html>