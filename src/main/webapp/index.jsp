<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is already logged in
    String username = (String) session.getAttribute("username");
    String userRole = (String) session.getAttribute("userRole");
    String fullName = (String) session.getAttribute("fullName");

    // Set guest user if not logged in
    if (username == null) {
        username = "Guest";
        userRole = "GUEST";
        fullName = "Guest User";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LifeCare Medical Center - Your Health Is Our Priority</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            color: #333;
            line-height: 1.6;
            background-color: #f5f7fa;
        }

        .hero-section {
            height: 100vh;
            background-image: url('https://images.unsplash.com/photo-1631248055158-edec7a3c072b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2071&q=80');
            background-size: cover;
            background-position: center;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
            padding: 20px;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(41, 128, 185, 0.7), rgba(44, 62, 80, 0.9));
        }

        .hero-content {
            position: relative;
            z-index: 1;
            max-width: 800px;
            animation: fadeIn 1.5s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .hero-content h1 {
            font-size: 3.5rem;
            margin-bottom: 20px;
            font-weight: 700;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            letter-spacing: 1px;
        }

        .hero-content p {
            font-size: 1.3rem;
            margin-bottom: 30px;
            opacity: 0.95;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.8;
            text-shadow: 0 1px 5px rgba(0, 0, 0, 0.2);
        }

        .btn-group {
            display: flex;
            gap: 20px;
            justify-content: center;
            margin-top: 30px;
            animation: fadeIn 2s ease-out;
        }

        .btn {
            display: inline-block;
            padding: 15px 35px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            z-index: 1;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0%;
            height: 100%;
            background-color: rgba(255, 255, 255, 0.1);
            transition: all 0.5s ease;
            z-index: -1;
        }

        .btn:hover::before {
            width: 100%;
        }

        .btn:hover {
            background-color: #2980b9;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
        }

        .btn.secondary {
            background-color: transparent;
            border: 2px solid white;
        }

        .btn.secondary:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
        }

        header {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 10;
        }

        .logo-container {
            display: flex;
            align-items: center;
        }

        .logo {
            width: 50px;
            height: 50px;
            margin-right: 15px;
        }

        .logo img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        header h1 {
            font-size: 1.5rem;
            color: white;
        }

        nav ul {
            display: flex;
            list-style: none;
        }

        nav ul li {
            margin-left: 20px;
        }

        nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: opacity 0.3s;
        }

        nav ul li a:hover {
            opacity: 0.8;
        }

        .features-section {
            padding: 80px 20px;
            background-color: white;
        }

        .section-title {
            text-align: center;
            margin-bottom: 50px;
        }

        .section-title h2 {
            font-size: 2.5rem;
            color: #2c3e50;
            margin-bottom: 15px;
        }

        .section-title p {
            color: #7f8c8d;
            max-width: 700px;
            margin: 0 auto;
        }

        .features-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            flex: 1;
            min-width: 300px;
            max-width: 350px;
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            background-color: #3498db;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 2rem;
        }

        .feature-card h3 {
            font-size: 1.5rem;
            color: #2c3e50;
            margin-bottom: 15px;
        }

        .feature-card p {
            color: #7f8c8d;
            margin-bottom: 20px;
        }

        .departments-section {
            padding: 80px 20px;
            background-color: #f5f7fa;
            background-image: linear-gradient(to bottom, #f5f7fa, #edf1f7);
            position: relative;
            overflow: hidden;
        }

        .departments-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: radial-gradient(#e6e6e6 1px, transparent 1px);
            background-size: 20px 20px;
            opacity: 0.5;
            pointer-events: none;
        }

        .departments-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px 0;
        }

        .department-card {
            flex: 1;
            min-width: 300px;
            max-width: 350px;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            margin-bottom: 20px;
            width: calc(33.333% - 20px);
            border: 1px solid rgba(0,0,0,0.05);
        }

        .department-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .department-image {
            height: 180px;
            background-color: #f8f9fa;
            background-image: radial-gradient(#e6e6e6 1px, transparent 1px);
            background-size: 10px 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            overflow: hidden;
            position: relative;
        }

        .department-icon {
            font-size: 3.5rem;
            color: #3498db;
            transition: all 0.3s ease;
            background-color: white;
            width: 120px;
            height: 120px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .department-card:hover .department-icon {
            transform: scale(1.05);
            color: #2980b9;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .department-image::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 30%;
            background: linear-gradient(to top, rgba(248,249,250,0.8), rgba(248,249,250,0));
            pointer-events: none;
        }

        .department-content {
            padding: 20px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
            text-align: center;
        }

        .department-content h3 {
            font-size: 1.5rem;
            color: #2c3e50;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .department-content p {
            color: #7f8c8d;
            margin-bottom: 25px;
            flex-grow: 1;
            line-height: 1.6;
        }

        .department-content .btn {
            align-self: center;
            padding: 10px 30px;
            border-radius: 30px;
            font-size: 1rem;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            font-weight: 500;
            letter-spacing: 0.5px;
            border: none;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .department-content .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0%;
            height: 100%;
            background-color: rgba(255, 255, 255, 0.1);
            transition: all 0.5s ease;
            z-index: -1;
        }

        .department-content .btn:hover::before {
            width: 100%;
        }

        .department-content .btn:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
        }

        .cta-section {
            padding: 100px 20px;
            background-image: url('https://images.unsplash.com/photo-1579684385127-1ef15d508118?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2080&q=80');
            background-size: cover;
            background-position: center;
            position: relative;
            text-align: center;
            color: white;
        }

        .cta-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(to right, rgba(52, 152, 219, 0.8), rgba(41, 128, 185, 0.8));
        }

        .cta-content {
            position: relative;
            z-index: 1;
            max-width: 700px;
            margin: 0 auto;
        }

        .cta-content h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
        }

        .cta-content p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        footer {
            background-color: #2c3e50;
            color: white;
            padding: 50px 20px 20px;
        }

        .footer-content {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            max-width: 1200px;
            margin: 0 auto;
            gap: 30px;
        }

        .footer-section {
            flex: 1;
            min-width: 250px;
        }

        .footer-section h3 {
            font-size: 1.3rem;
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 10px;
        }

        .footer-section h3::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 2px;
            background-color: #3498db;
        }

        .footer-section p {
            margin-bottom: 10px;
            opacity: 0.8;
        }

        .footer-section ul {
            list-style: none;
        }

        .footer-section ul li {
            margin-bottom: 10px;
        }

        .footer-section ul li a {
            color: white;
            text-decoration: none;
            opacity: 0.8;
            transition: opacity 0.3s;
        }

        .footer-section ul li a:hover {
            opacity: 1;
        }

        .social-icons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .social-icons a {
            width: 40px;
            height: 40px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .social-icons a:hover {
            background-color: #3498db;
        }

        .footer-bottom {
            text-align: center;
            padding-top: 30px;
            margin-top: 30px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            opacity: 0.8;
        }

        @media (max-width: 768px) {
            .hero-content h1 {
                font-size: 2rem;
            }

            .hero-content p {
                font-size: 1rem;
            }

            .btn-group {
                flex-direction: column;
                gap: 10px;
            }

            header {
                flex-direction: column;
                padding: 10px;
            }

            nav ul {
                margin-top: 15px;
            }

            nav ul li {
                margin-left: 10px;
            }

            .section-title h2 {
                font-size: 2rem;
            }

            .feature-card, .department-card {
                min-width: 100%;
                width: 100%;
                max-width: 100%;
            }

            .departments-container {
                gap: 20px;
            }

            .department-icon {
                width: 100px;
                height: 100px;
                font-size: 3rem;
            }

            .cta-content h2 {
                font-size: 2rem;
            }

            .cta-content p {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="logo-container">
            <div class="logo">
                <img src="images/hospital-logo.svg" alt="LifeCare Medical Center Logo">
            </div>
            <h1>LifeCare Medical Center</h1>
        </div>
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="departments.jsp">Departments</a></li>
                <li><a href="services.jsp">Services</a></li>
                <li><a href="our-doctors.jsp">Our Doctors</a></li>
                <li><a href="about-us.jsp">About Us</a></li>
                <li><a href="contact-us.jsp">Contact</a></li>
                <% if (username.equals("Guest")) { %>
                <li><a href="login.jsp">Login</a></li>
                <li><a href="register.jsp">Register</a></li>
                <% } else { %>
                <li><a href="home.jsp">Dashboard</a></li>
                <li><a href="logout.jsp">Logout</a></li>
                <% } %>
            </ul>
        </nav>
    </header>

    <section class="hero-section">
        <div class="hero-content">
            <h1>Your Health Is Our Priority</h1>
            <p>LifeCare Medical Center provides comprehensive healthcare services with state-of-the-art facilities and experienced medical professionals. We are committed to delivering the highest quality care to our patients.</p>
            <div class="btn-group">
                <a href="appointments.jsp" class="btn">Book Appointment</a>
                <a href="departments.jsp" class="btn secondary">Explore Departments</a>
            </div>
        </div>
    </section>

    <section class="features-section">
        <div class="section-title">
            <h2>Why Choose Us</h2>
            <p>We offer a wide range of healthcare services with a focus on patient comfort and care excellence.</p>
        </div>
        <div class="features-container">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-user-md"></i>
                </div>
                <h3>Expert Doctors</h3>
                <p>Our team consists of highly qualified and experienced medical professionals dedicated to providing the best care.</p>
                <a href="doctors.jsp" class="btn">Meet Our Doctors</a>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-procedures"></i>
                </div>
                <h3>Modern Facilities</h3>
                <p>State-of-the-art medical equipment and facilities to ensure accurate diagnosis and effective treatment.</p>
                <a href="facilities.jsp" class="btn">View Facilities</a>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-heartbeat"></i>
                </div>
                <h3>24/7 Emergency Care</h3>
                <p>Round-the-clock emergency services with quick response times to handle critical situations.</p>
                <a href="emergency.jsp" class="btn">Emergency Services</a>
            </div>
        </div>
    </section>

    <section class="departments-section">
        <div class="section-title">
            <h2>Our Departments</h2>
            <p>Specialized departments with expert medical professionals to address various healthcare needs.</p>
        </div>
        <div class="departments-container">
            <div class="department-card">
                <div class="department-image">
                    <i class="fas fa-heartbeat department-icon"></i>
                </div>
                <div class="department-content">
                    <h3>Cardiology</h3>
                    <p>Comprehensive care for heart-related conditions with advanced diagnostic and treatment options.</p>
                    <a href="departments.jsp?dept=cardiology" class="btn">Learn More</a>
                </div>
            </div>
            <div class="department-card">
                <div class="department-image">
                    <i class="fas fa-brain department-icon"></i>
                </div>
                <div class="department-content">
                    <h3>Neurology</h3>
                    <p>Specialized care for neurological disorders with a focus on patient comfort and recovery.</p>
                    <a href="departments.jsp?dept=neurology" class="btn">Learn More</a>
                </div>
            </div>
            <div class="department-card">
                <div class="department-image">
                    <i class="fas fa-baby department-icon"></i>
                </div>
                <div class="department-content">
                    <h3>Pediatrics</h3>
                    <p>Comprehensive healthcare services for children in a child-friendly environment.</p>
                    <a href="departments.jsp?dept=pediatrics" class="btn">Learn More</a>
                </div>
            </div>
        </div>
    </section>

    <section class="cta-section">
        <div class="cta-content">
            <h2>Need Medical Assistance?</h2>
            <p>Book an appointment with our specialists or visit our emergency department for immediate care.</p>
            <div class="btn-group">
                <a href="appointments.jsp" class="btn">Book Appointment</a>
                <a href="contact-us.jsp" class="btn secondary">Contact Us</a>
            </div>
        </div>
    </section>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>LifeCare Medical Center</h3>
                <p>Providing quality healthcare services since 2000.</p>
                <p>123 Medical Avenue, Healthcare City</p>
                <p>Phone: (123) 456-7890</p>
                <p>Email: info@lifecaremedical.com</p>
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="departments.jsp">Departments</a></li>
                    <li><a href="services.jsp">Services</a></li>
                    <li><a href="doctors.jsp">Doctors</a></li>
                    <li><a href="appointments.jsp">Appointments</a></li>
                    <li><a href="about-us.jsp">About Us</a></li>
                    <li><a href="contact-us.jsp">Contact Us</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Services</h3>
                <ul>
                    <li><a href="services.jsp?service=emergency">Emergency Care</a></li>
                    <li><a href="services.jsp?service=outpatient">Outpatient Services</a></li>
                    <li><a href="services.jsp?service=inpatient">Inpatient Services</a></li>
                    <li><a href="services.jsp?service=laboratory">Laboratory Services</a></li>
                    <li><a href="services.jsp?service=pharmacy">Pharmacy Services</a></li>
                    <li><a href="services.jsp?service=radiology">Radiology Services</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2023 LifeCare Medical Center. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>