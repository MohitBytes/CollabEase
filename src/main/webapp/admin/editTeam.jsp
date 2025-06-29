<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Team</title>
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
            --success: #2dce89;
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
            background: linear-gradient(to right, var(--success), #1aae6f);
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
            background: linear-gradient(to right, var(--success), #1aae6f);
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
            border-color: var(--success);
            box-shadow: 0 0 0 0.25rem rgba(45, 206, 137, 0.25);
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

        .btn-success {
            background: linear-gradient(to right, var(--success), #1aae6f);
        }

        .btn-outline-secondary {
            border: 1px solid var(--border);
            color: var(--text);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 14px rgba(45, 206, 137, 0.3);
        }

        .btn-outline-secondary:hover {
            background: rgba(94, 114, 228, 0.1);
            color: var(--primary);
            border-color: var(--primary-light);
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 10px;
            flex-wrap: wrap;
        }

        .team-info {
            background: rgba(45, 206, 137, 0.08);
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 25px;
        }

        .info-item {
            display: flex;
            gap: 10px;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }

        .info-label {
            font-weight: 500;
            min-width: 120px;
            color: var(--success);
        }

        .info-value {
            color: var(--text);
        }

        .form-section {
            margin-bottom: 25px;
        }

        .form-section h5 {
            font-weight: 600;
            color: var(--success);
            margin-bottom: 15px;
            padding-bottom: 8px;
            border-bottom: 1px solid var(--border);
        }

        .members-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }

        .member-card {
            background: rgba(94, 114, 228, 0.05);
            border-radius: 12px;
            padding: 12px;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
        }

        .member-card:hover {
            transform: translateY(-3px);
            background: rgba(94, 114, 228, 0.1);
        }

        .member-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }

        .member-name {
            font-weight: 500;
            font-size: 0.95rem;
        }

        .member-role {
            font-size: 0.8rem;
            color: #718096;
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

            .members-grid {
                grid-template-columns: 1fr;
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
                <h2>Edit Team</h2>
                <p class="welcome-message">Update team details below</p>
            </div>
            <a href="${pageContext.request.contextPath}/TeamServlet" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i>Back to Teams
            </a>
        </div>

        <!-- Edit Card -->
        <div class="edit-card">
            <!-- Team Information -->
            <div class="team-info">
                <div class="info-item">
                    <span class="info-label">Team ID:</span>
                    <span class="info-value">${team.teamId}</span>
                </div>

                <div class="info-item">
                    <span class="info-label">Projects:</span>
                    <span class="info-value">3 Active Projects</span>
                </div>
            </div>

            <!-- Edit Form -->
            <form method="post" action="../EditEntityServlet">
                <input type="hidden" name="type" value="team">
                <input type="hidden" name="id" value="${team.teamId}">

                <div class="form-section">
                    <h5>Team Information</h5>
                    <div class="mb-3">
                        <label for="name" class="form-label">Team Name</label>
                        <input type="text" class="form-control" name="name" id="name"
                               value="${team.teamName}" required>
                    </div>

                </div>


                <div class="action-buttons">
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save me-2"></i>Update Team
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
                window.location.href = '${pageContext.request.contextPath}/TeamServlet';
            });

            // Form submission feedback
            $('form').submit(function(e) {
                $('.btn-success').html('<i class="fas fa-spinner fa-spin me-2"></i>Updating...');
                $('.btn-success').prop('disabled', true);
            });

            // Add member animation
            $('.member-card').each(function(index) {
                $(this).delay(100 * index).animate({opacity: 1}, 300);
            });
        });
    </script>
</body>
</html>