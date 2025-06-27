<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create New User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .password-toggle {
            cursor: pointer;
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
        }
        .form-group {
            position: relative;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <h2>Create New User</h2>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="card mb-4">
            <div class="card-header">
                User Information
            </div>
            <div class="card-body">
                <form action="UserServlet" method="POST" id="userForm">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">First Name</label>
                            <input type="text" name="firstName" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Last Name</label>
                            <input type="text" name="lastName" class="form-control" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" name="username" class="form-control" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3 form-group">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" id="password" class="form-control" required>
                            <i class="fas fa-eye password-toggle" id="togglePassword"></i>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Confirm Password</label>
                            <input type="password" name="confirmPassword" class="form-control" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Role</label>
                            <select name="role" class="form-select" required>
                                <option value="USER">Regular User</option>
                                <option value="MANAGER">Manager</option>
                                <option value="ADMIN">Administrator</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Team</label>
                            <select name="teamId" class="form-select">
                                <option value="">-- Select Team --</option>
                                <c:forEach items="${teams}" var="team">
                                    <option value="${team.teamId}">${team.teamName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Profile Picture URL</label>
                        <input type="url" name="profilePicture" class="form-control" placeholder="https://example.com/profile.jpg">
                    </div>

                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" name="isActive" id="isActive" checked>
                        <label class="form-check-label" for="isActive">
                            Active User
                        </label>
                    </div>

                    <div class="d-flex justify-content-between">
                        <button type="submit" class="btn btn-primary">Create User</button>
                        <a href="users.jsp" class="btn btn-outline-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // Password toggle functionality
            $('#togglePassword').click(function() {
                const passwordField = $('#password');
                const type = passwordField.attr('type') === 'password' ? 'text' : 'password';
                passwordField.attr('type', type);
                $(this).toggleClass('fa-eye fa-eye-slash');
            });

            // Form validation
            $('#userForm').submit(function(e) {
                const password = $('input[name="password"]').val();
                const confirmPassword = $('input[name="confirmPassword"]').val();

                if (password !== confirmPassword) {
                    alert('Passwords do not match!');
                    e.preventDefault();
                }
            });
        });
    </script>

    <!-- Font Awesome for icons -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>