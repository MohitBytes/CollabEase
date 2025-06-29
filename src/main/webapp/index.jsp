<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CollabEase - Team Collaboration Made Simple</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
            overflow-x: hidden;
            line-height: 1.6;
        }

        /* Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 20px 40px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            font-weight: 700;
            font-size: 1.8rem;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-decoration: none;
        }

        .navbar-brand i {
            font-size: 2rem;
            margin-right: 12px;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .nav-links {
            display: flex;
            gap: 25px;
        }

        .nav-link {
            color: var(--text);
            font-weight: 500;
            text-decoration: none;
            padding: 8px 12px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .nav-link:hover, .nav-link.active {
            color: var(--primary);
            background: rgba(94, 114, 228, 0.1);
        }

        .auth-buttons {
            display: flex;
            gap: 15px;
        }

        .btn {
            padding: 10px 25px;
            border-radius: 12px;
            font-weight: 500;
            font-size: 1rem;
            transition: all 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            border: none;
            box-shadow: 0 4px 10px rgba(94, 114, 228, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 15px rgba(94, 114, 228, 0.4);
        }

        .btn-outline {
            background: transparent;
            border: 2px solid var(--primary);
            color: var(--primary);
        }

        .btn-outline:hover {
            background: rgba(94, 114, 228, 0.1);
            transform: translateY(-2px);
        }

        /* Hero Section */
        .hero {
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 120px 40px 60px;
            position: relative;
            overflow: hidden;
        }

        .hero-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            gap: 60px;
        }

        .hero-text {
            flex: 1;
            position: relative;
            z-index: 10;
        }

        .hero-image {
            flex: 1;
            position: relative;
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
            100% { transform: translateY(0px); }
        }

        .hero h1 {
            font-size: 3.2rem;
            font-weight: 700;
            margin-bottom: 20px;
            line-height: 1.2;
        }

        .hero p {
            font-size: 1.2rem;
            color: #718096;
            margin-bottom: 30px;
            max-width: 600px;
        }

        .hero-btns {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        /* Features Section */
        .features {
            padding: 100px 40px;
            background: white;
            position: relative;
        }

        .section-title {
            text-align: center;
            margin-bottom: 70px;
            position: relative;
        }

        .section-title h2 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 15px;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .section-title p {
            font-size: 1.1rem;
            color: #718096;
            max-width: 700px;
            margin: 0 auto;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            background: var(--light);
            border-radius: 18px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            height: 100%;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(94, 114, 228, 0.2);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            font-size: 2rem;
            background: rgba(94, 114, 228, 0.15);
            color: var(--primary);
        }

        .feature-card h3 {
            font-size: 1.4rem;
            margin-bottom: 15px;
        }

        .feature-card p {
            color: #718096;
        }

        /* How It Works */
        .how-it-works {
            padding: 100px 40px;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edff 100%);
            position: relative;
        }

        .steps-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .step-card {
            background: white;
            border-radius: 18px;
            padding: 40px 30px;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            text-align: center;
            position: relative;
        }

        .step-card:hover {
            transform: translateY(-5px);
        }

        .step-number {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            font-size: 1.5rem;
            font-weight: 700;
            margin: 0 auto 25px;
        }

        .step-card h3 {
            font-size: 1.4rem;
            margin-bottom: 15px;
        }

        .step-card p {
            color: #718096;
        }

        /* Testimonials */
        .testimonials {
            padding: 100px 40px;
            background: white;
        }

        .testimonials-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .testimonial-card {
            background: var(--light);
            border-radius: 18px;
            padding: 40px 30px;
            box-shadow: var(--card-shadow);
            position: relative;
        }

        .testimonial-card:before {
            content: """;
            position: absolute;
            top: 20px;
            left: 30px;
            font-size: 5rem;
            color: rgba(94, 114, 228, 0.1);
            font-family: Georgia, serif;
            line-height: 1;
        }

        .testimonial-content {
            margin-bottom: 25px;
            color: #718096;
            font-style: italic;
            position: relative;
            z-index: 1;
        }

        .testimonial-author {
            display: flex;
            align-items: center;
        }

        .author-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            margin-right: 15px;
            flex-shrink: 0;
        }

        .author-info h4 {
            margin-bottom: 5px;
        }

        .author-info p {
            color: #718096;
            font-size: 0.9rem;
        }

        /* CTA Section */
        .cta {
            padding: 100px 40px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .cta-content {
            max-width: 800px;
            margin: 0 auto;
            position: relative;
            z-index: 10;
        }

        .cta h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
        }

        .cta p {
            font-size: 1.1rem;
            margin: 0 auto 30px;
            opacity: 0.9;
            max-width: 700px;
        }

        .cta-btns {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-light {
            background: white;
            color: var(--primary);
            border: none;
        }

        .btn-light:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 15px rgba(0, 0, 0, 0.1);
        }

        .btn-outline-light {
            background: transparent;
            border: 2px solid white;
            color: white;
        }

        .btn-outline-light:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        /* Footer */
        .footer {
            background: #1a202c;
            color: #a0aec0;
            padding: 70px 40px 30px;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
        }

        .footer-brand {
            margin-bottom: 20px;
        }

        .footer-title {
            color: white;
            font-size: 1.2rem;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .footer-links {
            list-style: none;
            padding: 0;
        }

        .footer-links li {
            margin-bottom: 12px;
        }

        .footer-links a {
            color: #a0aec0;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .footer-links a:hover {
            color: white;
            padding-left: 5px;
        }

        .social-links {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .social-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            transition: all 0.3s ease;
        }

        .social-icon:hover {
            background: var(--primary);
            transform: translateY(-3px);
        }

        .copyright {
            text-align: center;
            padding-top: 40px;
            margin-top: 40px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            max-width: 1200px;
            margin: 40px auto 0;
        }

        /* Decoration Elements */
        .decoration {
            position: absolute;
            z-index: 0;
            border-radius: 50%;
            opacity: 0.1;
        }

        .decoration-1 {
            top: 10%;
            left: 10%;
            width: 200px;
            height: 200px;
            background: linear-gradient(to right, var(--primary), var(--secondary));
        }

        .decoration-2 {
            bottom: 15%;
            right: 10%;
            width: 150px;
            height: 150px;
            border-radius: 30% 70% 70% 30% / 30% 30% 70% 70%;
            background: linear-gradient(to right, var(--accent), #ff9e7d);
        }

        .decoration-3 {
            top: 40%;
            right: 20%;
            width: 100px;
            height: 100px;
            background: linear-gradient(to right, #3bb2b8, #42e695);
        }

        /* Responsive */
        @media (max-width: 992px) {
            .hero-content {
                flex-direction: column;
                text-align: center;
            }

            .hero-text {
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .hero h1 {
                font-size: 2.5rem;
            }

            .hero-btns {
                justify-content: center;
            }

            .nav-links {
                display: none;
            }
        }

        @media (max-width: 768px) {
            .navbar {
                padding: 15px 20px;
            }

            .hero h1 {
                font-size: 2.2rem;
            }

            .hero-btns, .cta-btns {
                flex-direction: column;
                align-items: center;
                gap: 15px;
            }

            .auth-buttons {
                gap: 10px;
            }

            .btn {
                padding: 8px 15px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <a href="#" class="navbar-brand">
            <i class="fas fa-users"></i>
            CollabEase
        </a>

        <div class="nav-links">
            <a href="#" class="nav-link active">Home</a>
            <a href="#features" class="nav-link">Features</a>
            <a href="#how-it-works" class="nav-link">How It Works</a>
        </div>

        <div class="auth-buttons">
            <a href="signin/login.jsp" class="btn btn-outline">Login</a>
            <a href="signin/register.jsp" class="btn btn-primary">Get Started</a>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="decoration decoration-1"></div>
        <div class="decoration decoration-2"></div>
        <div class="decoration decoration-3"></div>

        <div class="hero-content">
            <div class="hero-text">
                <h1>Team Collaboration Made Simple & Productive</h1>
                <p>CollabEase brings your team together in one intuitive workspace. Manage projects, tasks, and communication in real-time with our all-in-one collaboration platform.</p>

                <div class="hero-btns">
                    <a href="signin/register.jsp" class="btn btn-primary">
                        <i class="fas fa-rocket me-2"></i>Get Started Free
                    </a>
                    <a href="#features" class="btn btn-outline">
                        <i class="fas fa-play-circle me-2"></i>See How It Works
                    </a>
                </div>
            </div>
            <div class="hero-image">
                <img src="https://images.unsplash.com/photo-1579389083078-4e7018379f7e?auto=format&fit=crop&w=800" alt="Team Collaboration" class="img-fluid rounded-3 shadow-lg" style="max-width: 100%;">
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="features">
        <div class="section-title">
            <h2>Powerful Features</h2>
            <p>Everything you need to streamline teamwork and boost productivity</p>
        </div>

        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-tasks"></i>
                </div>
                <h3>Task Management</h3>
                <p>Create, assign, and track tasks with due dates, priorities, and progress tracking.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-file-alt"></i>
                </div>
                <h3>Document Sharing</h3>
                <p>Collaborate on documents in real-time with version history and commenting.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <h3>Analytics Dashboard</h3>
                <p>Track team performance and project progress with visual analytics.</p>
            </div>


        </div>
    </section>

    <!-- How It Works -->
    <section id="how-it-works" class="how-it-works">
        <div class="section-title">
            <h2>How CollabEase Works</h2>
            <p>Simple steps to transform your team collaboration</p>
        </div>

        <div class="steps-container">
            <div class="step-card">
                <div class="step-number">1</div>
                <h3>Create Your Workspace</h3>
                <p>Set up your team workspace in minutes. Invite members and organize into projects.</p>
            </div>

            <div class="step-card">
                <div class="step-number">2</div>
                <h3>Add Projects & Tasks</h3>
                <p>Create projects, break them into tasks, assign to team members with deadlines.</p>
            </div>

            <div class="step-card">
                <div class="step-number">3</div>
                <h3>Collaborate in Real-Time</h3>
                <p>Communicate, share files, and track progress with integrated tools.</p>
            </div>

            <div class="step-card">
                <div class="step-number">4</div>
                <h3>Track & Analyze</h3>
                <p>Monitor project progress with visual dashboards and performance analytics.</p>
            </div>
        </div>
    </section>



    <!-- CTA Section -->
    <section class="cta">
        <div class="cta-content">
            <h2>Ready to Transform Your Team Collaboration?</h2>
            <p>Join thousands of teams who are already working smarter with CollabEase</p>

            <div class="cta-btns">
                <a href="signin/register.jsp" class="btn btn-light">
                    <i class="fas fa-rocket me-2"></i>Get Started Free
                </a>
                <a href="#features" class="btn btn-outline-light">
                    <i class="fas fa-book me-2"></i>Learn More
                </a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-brand">
                <a href="#" class="navbar-brand">
                    <i class="fas fa-users"></i>
                    CollabEase
                </a>
                <p class="mt-2">Streamline teamwork, boost productivity, and achieve more together.</p>
                <div class="social-links">
                    <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                </div>
            </div>

        </div>

        <div class="copyright">
            <p>&copy; 2025 CollabEase. All rights reserved. Designed with <i class="fas fa-heart text-danger"></i> for productive teams.</p>
        </div>
    </footer>

    <script>
        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();

                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // Simple animation for feature cards on scroll
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = 1;
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, { threshold: 0.1 });

        document.querySelectorAll('.feature-card, .step-card, .testimonial-card').forEach(card => {
            card.style.opacity = 0;
            card.style.transform = 'translateY(20px)';
            card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
            observer.observe(card);
        });
    </script>
</body>
</html>