<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
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
            --info: #11cdef;
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
            background: linear-gradient(to right, var(--info), #1171ef);
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
            background: linear-gradient(to right, var(--info), #1171ef);
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
            border-color: var(--info);
            box-shadow: 0 0 0 0.25rem rgba(17, 205, 239, 0.25);
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

        .btn-info {
            background: linear-gradient(to right, var(--info), #1171ef);
        }

        .btn-outline-secondary {
            border: 1px solid var(--border);
            color: var(--text);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 14px rgba(17, 205, 239, 0.3);
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

        .user-profile {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 25px;
            text-align: center;
        }

        .avatar-container {
            position: relative;
            margin-bottom: 15px;
        }

        .user-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2.5rem;
            font-weight: 600;
        }

        .change-avatar {
            position: absolute;
            bottom: 0;
            right: 0;
            background: var(--info);
            color: white;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .user-name {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .user-role {
            background: linear-gradient(to right, var(--info), #1171ef);
            color: white;
            padding: 4px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            display: inline-block;
        }

        .form-section {
            margin-bottom: 25px;
        }

        .form-section h5 {
            font-weight: 600;
            color: var(--info);
            margin-bottom: 15px;
            padding-bottom: 8px;
            border-bottom: 1px solid var(--border);
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 42px;
            cursor: pointer;
            color: #718096;
        }

        .password-container {
            position: relative;
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
        }
    </style>
</head>
<body>
    <jsp:include page="../Header/header.jsp" />

    <div class="container mt-4">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <div>
                <h2>Edit User</h2>
                <p class="welcome-message">Update user profile and settings</p>
            </div>
        </div>

        <!-- Edit Card -->
        <div class="edit-card">
            <!-- User Profile Section -->
            <div class="user-profile">
                <div class="avatar-container">
                    <div class="user-avatar">
                        ${fn:substring(user.fullName, 0, 1)}
                    </div>
                    <div class="change-avatar">
                        <i class="fas fa-camera"></i>
                    </div>
                </div>
                <div>
                    <h3 class="user-name">${user.fullName}</h3>
                    <span class="user-role">${user.role}</span>
                </div>
            </div>

            <!-- Edit Form -->
            <form method="post" action="../EditEntityServlet">
                <input type="hidden" name="type" value="user">
                <input type="hidden" name="id" value="${user.userId}">

                <div class="form-section">
                    <h5>Personal Information</h5>
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" name="fullName" id="fullName"
                               value="${user.fullName}" required>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email Address</label>
                        <input type="email" class="form-control" name="email" id="email"
                               value="${user.email}" required>
                    </div>

                </div>

                <div class="form-section">
                    <h5>Account Settings</h5>
                    <div class="mb-3">
                        <label for="role" class="form-label">User Role</label>
                        <select class="form-select" name="role" id="role">
                            <option value="admin" ${user.role == 'ADMIN' ? 'selected' : ''}>Administrator</option>
                            <option value="manager" ${user.role == 'MANAGER' ? 'selected' : ''}>Manager</option>
                            <option value="member" ${user.role == 'MEMBER' ? 'selected' : ''}>Team Member</option>
                        </select>
                    </div>

                    <div class="password-container">
                        <label for="password" class="form-label">Change Password</label>
                        <input type="password" class="form-control" name="password" id="password"
                               placeholder="Enter new password">
                        <span class="password-toggle" id="passwordToggle">
                            <i class="fas fa-eye"></i>
                        </span>
                    </div>
                </div>

                <div class="action-buttons">
                    <button type="submit" class="btn btn-info">
                        <i class="fas fa-save me-2"></i>Update Profile
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
                window.location.href = '${pageContext.request.contextPath}/UserServlet';
            });

            // Form submission feedback
            $('form').submit(function(e) {
                $('.btn-info').html('<i class="fas fa-spinner fa-spin me-2"></i>Saving...');
                $('.btn-info').prop('disabled', true);
            });

            // Password toggle
            $('#passwordToggle').click(function() {
                const passwordField = $('#password');
                const type = passwordField.attr('type') === 'password' ? 'text' : 'password';
                passwordField.attr('type', type);
                $(this).find('i').toggleClass('fa-eye fa-eye-slash');
            });

            // Change avatar placeholder
            $('.change-avatar').click(function() {
                alert(#);
            });
        });
    </script>
</body>
</html>