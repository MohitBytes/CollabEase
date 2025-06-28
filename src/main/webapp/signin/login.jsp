<%@ page contentType="text/html;charset=UTF-8" %>

<% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger">${error}</div>
<% } %>

<% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success"><%= request.getParameter("success") %></div>
<% } %>

<!DOCTYPE html>
<html>
<head>
    <title>CollabEase - Login</title>
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
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            color: var(--text);
        }

        .login-container {
            width: 100%;
            max-width: 420px;
            margin: 0 auto;
        }

        .brand-logo {
            text-align: center;
            margin-bottom: 25px;
        }

        .brand-logo i {
            font-size: 2.8rem;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
        }

        .brand-logo h1 {
            font-weight: 600;
            font-size: 1.8rem;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            letter-spacing: -0.5px;
        }

        .card {
            border: none;
            border-radius: 18px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(94, 114, 228, 0.2);
        }

        .card-header {
            background: transparent;
            border: none;
            padding: 25px 25px 10px;
            text-align: center;
        }

        .card-header h4 {
            font-weight: 600;
            color: var(--text);
            font-size: 1.4rem;
        }

        .card-body {
            padding: 25px;
        }

        .form-label {
            font-weight: 500;
            color: var(--text);
            margin-bottom: 8px;
            font-size: 0.95rem;
        }

        .form-control {
            padding: 12px 20px;
            border-radius: 12px;
            border: 2px solid var(--border);
            transition: all 0.3s ease;
            font-size: 0.95rem;
        }

        .form-control:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(94, 114, 228, 0.15);
        }

        .input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary-light);
            z-index: 10;
            font-size: 1.1rem;
        }

        .form-control.with-icon {
            padding-left: 45px;
        }

        .btn-primary {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            border: none;
            padding: 12px;
            border-radius: 12px;
            font-weight: 500;
            font-size: 1rem;
            transition: all 0.3s ease;
            margin-top: 10px;
            box-shadow: 0 4px 10px rgba(94, 114, 228, 0.3);
            width: 100%;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 15px rgba(94, 114, 228, 0.4);
        }

        .footer-links {
            text-align: center;
            margin-top: 25px;
            font-size: 0.95rem;
            padding-top: 15px;
            border-top: 1px solid var(--border);
        }

        .footer-links a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--secondary);
            text-decoration: underline;
        }

        .alert {
            border-radius: 12px;
            padding: 15px 20px;
            margin-bottom: 25px;
            font-size: 0.95rem;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            border: none;
        }

        .alert-danger {
            background: linear-gradient(to right, #ff758c, #ff7eb3);
            color: white;
        }

        .alert-success {
            background: linear-gradient(to right, #42e695, #3bb2b8);
            color: white;
        }

        .decoration {
            position: absolute;
            z-index: -1;
            opacity: 0.1;
        }

        .decoration-1 {
            top: 10%;
            left: 10%;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(to right, var(--primary), var(--secondary));
        }

        .decoration-2 {
            bottom: 15%;
            right: 10%;
            width: 80px;
            height: 80px;
            border-radius: 30% 70% 70% 30% / 30% 30% 70% 70%;
            background: linear-gradient(to right, var(--accent), #ff9e7d);
        }

        .decoration-3 {
            top: 40%;
            right: 20%;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(to right, #3bb2b8, #42e695);
        }

        /* Responsive styles */
        @media (max-width: 576px) {
            .login-container {
                padding: 0 15px;
            }

            .card-body {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="decoration decoration-1"></div>
    <div class="decoration decoration-2"></div>
    <div class="decoration decoration-3"></div>

    <div class="login-container">
        <div class="brand-logo">
            <i class="fas fa-users"></i>
            <h1>CollabEase</h1>
        </div>

        <div class="card">
            <div class="card-header">
                <h4>Login to Your Account</h4>
            </div>
            <div class="card-body">
                <form action="LoginServlet" method="POST">
                    <div class="mb-4 input-group">
                        <span class="input-icon">
                            <i class="fas fa-envelope"></i>
                        </span>
                        <input type="email" name="email" class="form-control with-icon" placeholder="Enter your email" required>
                    </div>

                    <div class="mb-4 input-group">
                        <span class="input-icon">
                            <i class="fas fa-lock"></i>
                        </span>
                        <input type="password" name="password" class="form-control with-icon" placeholder="Enter your password" required>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-sign-in-alt me-2"></i>Login
                        </button>
                    </div>
                </form>

                <div class="footer-links">
                    <p class="mb-0">Don't have an account? <a href="register.jsp">Create new account</a></p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>