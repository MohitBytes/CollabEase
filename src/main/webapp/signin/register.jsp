<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>CollabEase - Register</title>
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

        .register-container {
            width: 100%;
            max-width: 460px;
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

        .alert-danger {
            border-radius: 12px;
            padding: 15px 20px;
            margin-bottom: 25px;
            font-size: 0.95rem;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            border: none;
            background: linear-gradient(to right, #ff758c, #ff7eb3);
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

        .decoration-4 {
            bottom: 30%;
            left: 15%;
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: linear-gradient(to right, #ff9e7d, #ff758c);
        }

        .password-strength {
            height: 5px;
            background-color: #e9ecef;
            border-radius: 3px;
            margin-top: 8px;
            overflow: hidden;
        }

        .strength-meter {
            height: 100%;
            width: 0;
            border-radius: 3px;
            transition: width 0.3s ease;
        }

        .strength-weak {
            background: linear-gradient(to right, #ff758c, #ff7eb3);
        }

        .strength-medium {
            background: linear-gradient(to right, #ff9e7d, #ffcc81);
        }

        .strength-strong {
            background: linear-gradient(to right, #42e695, #3bb2b8);
        }

        .strength-text {
            font-size: 0.8rem;
            margin-top: 5px;
            text-align: right;
        }

        /* Responsive styles */
        @media (max-width: 576px) {
            .register-container {
                padding: 0 15px;
            }

            .card-body {
                padding: 20px;
            }
        }
    </style>
    <script>
        function checkPasswordStrength() {
            const password = document.getElementById('password').value;
            const meter = document.querySelector('.strength-meter');
            const text = document.querySelector('.strength-text');

            // Reset
            meter.style.width = '0';
            text.textContent = '';

            if (password.length === 0) return;

            // Calculate strength
            let strength = 0;
            if (password.length > 5) strength += 1;
            if (password.length > 7) strength += 1;
            if (/[A-Z]/.test(password)) strength += 1;
            if (/[0-9]/.test(password)) strength += 1;
            if (/[^A-Za-z0-9]/.test(password)) strength += 1;

            // Update meter
            if (strength <= 2) {
                meter.style.width = '33%';
                meter.className = 'strength-meter strength-weak';
                text.textContent = 'Weak password';
                text.style.color = '#ff758c';
            } else if (strength <= 4) {
                meter.style.width = '66%';
                meter.className = 'strength-meter strength-medium';
                text.textContent = 'Medium strength';
                text.style.color = '#ff9e7d';
            } else {
                meter.style.width = '100%';
                meter.className = 'strength-meter strength-strong';
                text.textContent = 'Strong password!';
                text.style.color = '#42e695';
            }
        }
    </script>
</head>
<body>
    <div class="decoration decoration-1"></div>
    <div class="decoration decoration-2"></div>
    <div class="decoration decoration-3"></div>
    <div class="decoration decoration-4"></div>

    <div class="register-container">
        <div class="brand-logo">
            <i class="fas fa-users"></i>
            <h1>CollabEase</h1>
        </div>

        <div class="card">
            <div class="card-header">
                <h4>Create Your Account</h4>
            </div>
            <div class="card-body">
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert-danger">${error}</div>
                <% } %>

                <form action="RegisterServlet" method="POST">
                    <div class="mb-4 input-group">
                        <span class="input-icon">
                            <i class="fas fa-user"></i>
                        </span>
                        <input type="text" name="fullname" class="form-control with-icon" placeholder="Enter your full name" required>
                    </div>

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
                        <input type="password" name="password" id="password" class="form-control with-icon" placeholder="Create a password"
                               oninput="checkPasswordStrength()" required>
                    </div>

                    <div class="password-strength">
                        <div class="strength-meter"></div>
                    </div>
                    <div class="strength-text"></div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-user-plus me-2"></i>Create Account
                        </button>
                    </div>
                </form>

                <div class="footer-links">
                    <p class="mb-0">Already have an account? <a href="login.jsp">Sign in</a></p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>