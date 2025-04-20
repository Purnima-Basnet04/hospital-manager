<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Get user information from session
    String username = (String) session.getAttribute("username");
    String userRole = (String) session.getAttribute("userRole");
    String fullName = (String) session.getAttribute("fullName");

    // Set default values for non-logged in users
    if (username == null) {
        username = "Guest";
        userRole = "GUEST";
        fullName = "Guest User";
    } else if (fullName == null || fullName.isEmpty()) {
        fullName = username;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Services - LifeCare Medical Center</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- Common CSS -->
    <link rel="stylesheet" type="text/css" href="styles/common.css">

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            background-color: #2c3e50;
            color: white;
            padding: 15px 0;
            margin-bottom: 30px;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .logo-container {
            display: flex;
            align-items: center;
        }

        .logo {
            margin-right: 15px;
        }

        .logo img {
            height: 40px;
        }

        h1 {
            font-size: 24px;
            margin: 0;
        }

        .user-info {
            display: flex;
            align-items: center;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            background-color: #3498db;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-right: 10px;
        }

        .user-details h4 {
            margin: 0;
            font-size: 16px;
        }

        .user-details p {
            margin: 5px 0 0;
            font-size: 12px;
            opacity: 0.7;
        }

        nav {
            background-color: #34495e;
        }

        nav ul {
            display: flex;
            list-style: none;
            padding: 0;
            margin: 0;
            max-width: 1200px;
            margin: 0 auto;
        }

        nav ul li {
            margin: 0;
        }

        nav ul li a {
            display: block;
            color: white;
            text-decoration: none;
            padding: 15px 20px;
            transition: background-color 0.3s;
        }

        nav ul li a:hover,
        nav ul li a.active {
            background-color: #3498db;
        }

        .page-title {
            margin-bottom: 30px;
        }

        .page-title h2 {
            color: #2c3e50;
            margin-top: 0;
        }

        .action-buttons {
            margin-bottom: 20px;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s;
            margin-right: 10px;
            margin-bottom: 10px;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .btn.secondary {
            background-color: #95a5a6;
        }

        .btn.secondary:hover {
            background-color: #7f8c8d;
        }

        .services-section {
            margin-bottom: 50px;
        }

        .services-section h3 {
            color: #2c3e50;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #3498db;
        }

        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
        }

        .service-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s;
        }

        .service-card:hover {
            transform: translateY(-5px);
        }

        .service-icon {
            height: 120px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #3498db;
            color: white;
            font-size: 48px;
        }

        .service-content {
            padding: 20px;
        }

        .service-content h4 {
            color: #2c3e50;
            margin-top: 0;
            margin-bottom: 10px;
        }

        .service-content p {
            margin-bottom: 20px;
            color: #555;
        }

        .service-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .service-details span {
            display: flex;
            align-items: center;
        }

        .service-details i {
            margin-right: 5px;
            color: #3498db;
        }

        .service-actions {
            display: flex;
            justify-content: space-between;
        }

        .service-actions .btn-small {
            flex: 1;
            text-align: center;
            margin-right: 10px;
        }

        .service-actions .btn-small:last-child {
            margin-right: 0;
        }

        .btn-small {
            display: inline-block;
            padding: 8px 15px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
        }

        .btn-small:hover {
            background-color: #2980b9;
        }

        .btn-small.secondary {
            background-color: #95a5a6;
        }

        .btn-small.secondary:hover {
            background-color: #7f8c8d;
        }

        .special-services {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-bottom: 30px;
        }

        .special-services h3 {
            color: #2c3e50;
            margin-top: 0;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #3498db;
        }

        .special-services-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }

        .special-service-item {
            display: flex;
            align-items: center;
            padding: 15px;
            border-radius: 8px;
            background-color: #f8f9fa;
            transition: background-color 0.3s;
        }

        .special-service-item:hover {
            background-color: #e9ecef;
        }

        .special-service-icon {
            width: 50px;
            height: 50px;
            background-color: #3498db;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-right: 15px;
        }

        .special-service-info h4 {
            margin: 0 0 5px;
            color: #2c3e50;
            font-size: 16px;
        }

        .special-service-info p {
            margin: 0;
            color: #555;
            font-size: 14px;
        }

        footer {
            background-color: #2c3e50;
            color: white;
            padding: 40px 0 20px;
            margin-top: 50px;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .footer-section h3 {
            margin-top: 0;
            margin-bottom: 20px;
            font-size: 18px;
        }

        .footer-section ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .footer-section ul li {
            margin-bottom: 10px;
        }

        .footer-section ul li a {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-section ul li a:hover {
            color: white;
        }

        .footer-bottom {
            text-align: center;
            padding-top: 20px;
            margin-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            max-width: 1200px;
            margin: 20px auto 0;
            padding: 20px;
        }

        .footer-bottom p {
            margin: 0;
            font-size: 14px;
            opacity: 0.7;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                text-align: center;
            }

            .user-info {
                margin-top: 15px;
            }

            nav ul {
                flex-direction: column;
            }

            .services-grid {
                grid-template-columns: 1fr;
            }

            .special-services-list {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="header-content">
            <div class="logo-container">
                <div class="logo">
                    <img src="images/hospital-logo.svg" alt="LifeCare Medical Center Logo">
                </div>
                <h1>LifeCare Medical Center</h1>
            </div>
            <% if (!username.equals("Guest")) { %>
            <div class="user-info">
                <div class="user-avatar">
                    <%= username.substring(0, 1).toUpperCase() %>
                </div>
                <div class="user-details">
                    <h4><%= fullName %></h4>
                    <p><%= userRole %></p>
                </div>
            </div>
            <% } else { %>
            <div class="login-register">
                <a href="login.jsp" class="btn-small">Login</a>
                <a href="register.jsp" class="btn-small">Register</a>
            </div>
            <% } %>
        </div>
    </header>

    <nav>
        <ul>
            <% if (username.equals("Guest")) { %>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="appointments.jsp">Appointments</a></li>
            <li><a href="departments.jsp">Departments</a></li>
            <li><a href="services.jsp" class="active">Services</a></li>
            <li><a href="login.jsp">Login</a></li>
            <li><a href="register.jsp">Register</a></li>
            <% } else { %>
            <li><a href="home.jsp">Home</a></li>
            <li><a href="appointments.jsp">Appointments</a></li>
            <li><a href="departments.jsp">Departments</a></li>
            <li><a href="services.jsp" class="active">Services</a></li>
            <% if (userRole.equals("ADMIN")) { %>
            <li><a href="admin-dashboard.jsp">Admin Dashboard</a></li>
            <% } else if (userRole.equals("DOCTOR")) { %>
            <li><a href="dashboard-doctor.jsp">Doctor Dashboard</a></li>
            <% } else if (userRole.equals("PATIENT")) { %>
            <li><a href="patient-dashboard.jsp">Patient Dashboard</a></li>
            <% } %>
            <li><a href="profile.jsp">Profile</a></li>
            <li><a href="logout.jsp">Logout</a></li>
            <% } %>
        </ul>
    </nav>

    <div class="container">
        <div class="page-title">
            <h2>Our Medical Services</h2>
            <p>Discover the comprehensive healthcare services we offer at LifeCare Medical Center.</p>
        </div>

        <% if (userRole.equals("ADMIN")) { %>
        <div class="action-buttons">
            <a href="add-service.jsp" class="btn">Add New Service</a>
            <a href="manage-services.jsp" class="btn secondary">Manage Services</a>
        </div>
        <% } %>

        <div class="special-services">
            <h3>Special Services</h3>
            <div class="special-services-list">
                <div class="special-service-item">
                    <div class="special-service-icon">
                        <i class="fas fa-ambulance"></i>
                    </div>
                    <div class="special-service-info">
                        <h4>24/7 Emergency Care</h4>
                        <p>Round-the-clock emergency medical services</p>
                    </div>
                </div>

                <div class="special-service-item">
                    <div class="special-service-icon">
                        <i class="fas fa-home"></i>
                    </div>
                    <div class="special-service-info">
                        <h4>Home Healthcare</h4>
                        <p>Medical care provided at your home</p>
                    </div>
                </div>

                <div class="special-service-item">
                    <div class="special-service-icon">
                        <i class="fas fa-laptop-medical"></i>
                    </div>
                    <div class="special-service-info">
                        <h4>Telemedicine</h4>
                        <p>Virtual consultations with our specialists</p>
                    </div>
                </div>

                <div class="special-service-item">
                    <div class="special-service-icon">
                        <i class="fas fa-heartbeat"></i>
                    </div>
                    <div class="special-service-info">
                        <h4>Cardiac Rehabilitation</h4>
                        <p>Comprehensive cardiac recovery programs</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="services-section">
            <h3>Diagnostic Services</h3>
            <div class="services-grid">
                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-x-ray"></i>
                    </div>
                    <div class="service-content">
                        <h4>X-Ray Imaging</h4>
                        <p>Advanced X-ray imaging for accurate diagnosis of bone fractures and other conditions.</p>
                        <div class="service-details">
                            <span><i class="fas fa-clock"></i> Available 24/7</span>
                            <span><i class="fas fa-map-marker-alt"></i> Building A, Floor 1</span>
                        </div>
                        <div class="service-actions">
                            <a href="view-service.jsp?id=1" class="btn-small">View Details</a>
                            <% if (userRole.equals("PATIENT")) { %>
                            <a href="book-service.jsp?id=1" class="btn-small">Book Service</a>
                            <% } else if (userRole.equals("ADMIN")) { %>
                            <a href="edit-service.jsp?id=1" class="btn-small secondary">Edit</a>
                            <% } else if (userRole.equals("GUEST")) { %>
                            <a href="login.jsp?redirect=book-service.jsp?id=1" class="btn-small">Login to Book</a>
                            <% } %>
                        </div>
                    </div>
                </div>

                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-brain"></i>
                    </div>
                    <div class="service-content">
                        <h4>MRI Scanning</h4>
                        <p>High-resolution magnetic resonance imaging for detailed visualization of organs and tissues.</p>
                        <div class="service-details">
                            <span><i class="fas fa-clock"></i> 8:00 AM - 8:00 PM</span>
                            <span><i class="fas fa-map-marker-alt"></i> Building B, Floor 1</span>
                        </div>
                        <div class="service-actions">
                            <a href="view-service.jsp?id=2" class="btn-small">View Details</a>
                            <% if (userRole.equals("PATIENT")) { %>
                            <a href="book-service.jsp?id=2" class="btn-small">Book Service</a>
                            <% } else if (userRole.equals("ADMIN")) { %>
                            <a href="edit-service.jsp?id=2" class="btn-small secondary">Edit</a>
                            <% } else if (userRole.equals("GUEST")) { %>
                            <a href="login.jsp?redirect=book-service.jsp?id=2" class="btn-small">Login to Book</a>
                            <% } %>
                        </div>
                    </div>
                </div>

                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-vial"></i>
                    </div>
                    <div class="service-content">
                        <h4>Laboratory Services</h4>
                        <p>Comprehensive laboratory testing for blood work, urine analysis, and other diagnostic tests.</p>
                        <div class="service-details">
                            <span><i class="fas fa-clock"></i> 7:00 AM - 7:00 PM</span>
                            <span><i class="fas fa-map-marker-alt"></i> Building A, Floor 2</span>
                        </div>
                        <div class="service-actions">
                            <a href="view-service.jsp?id=3" class="btn-small">View Details</a>
                            <% if (userRole.equals("PATIENT")) { %>
                            <a href="book-service.jsp?id=3" class="btn-small">Book Service</a>
                            <% } else if (userRole.equals("ADMIN")) { %>
                            <a href="edit-service.jsp?id=3" class="btn-small secondary">Edit</a>
                            <% } else if (userRole.equals("GUEST")) { %>
                            <a href="login.jsp?redirect=book-service.jsp?id=3" class="btn-small">Login to Book</a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="services-section">
            <h3>Therapeutic Services</h3>
            <div class="services-grid">
                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-walking"></i>
                    </div>
                    <div class="service-content">
                        <h4>Physical Therapy</h4>
                        <p>Rehabilitation services to help patients recover from injuries and improve mobility.</p>
                        <div class="service-details">
                            <span><i class="fas fa-clock"></i> 9:00 AM - 5:00 PM</span>
                            <span><i class="fas fa-map-marker-alt"></i> Building C, Floor 2</span>
                        </div>
                        <div class="service-actions">
                            <a href="view-service.jsp?id=4" class="btn-small">View Details</a>
                            <% if (userRole.equals("PATIENT")) { %>
                            <a href="book-service.jsp?id=4" class="btn-small">Book Service</a>
                            <% } else if (userRole.equals("ADMIN")) { %>
                            <a href="edit-service.jsp?id=4" class="btn-small secondary">Edit</a>
                            <% } else if (userRole.equals("GUEST")) { %>
                            <a href="login.jsp?redirect=book-service.jsp?id=4" class="btn-small">Login to Book</a>
                            <% } %>
                        </div>
                    </div>
                </div>

                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-comments"></i>
                    </div>
                    <div class="service-content">
                        <h4>Speech Therapy</h4>
                        <p>Specialized therapy to help patients with speech and language disorders.</p>
                        <div class="service-details">
                            <span><i class="fas fa-clock"></i> 9:00 AM - 4:00 PM</span>
                            <span><i class="fas fa-map-marker-alt"></i> Building C, Floor 1</span>
                        </div>
                        <div class="service-actions">
                            <a href="view-service.jsp?id=5" class="btn-small">View Details</a>
                            <% if (userRole.equals("PATIENT")) { %>
                            <a href="book-service.jsp?id=5" class="btn-small">Book Service</a>
                            <% } else if (userRole.equals("ADMIN")) { %>
                            <a href="edit-service.jsp?id=5" class="btn-small secondary">Edit</a>
                            <% } else if (userRole.equals("GUEST")) { %>
                            <a href="login.jsp?redirect=book-service.jsp?id=5" class="btn-small">Login to Book</a>
                            <% } %>
                        </div>
                    </div>
                </div>

                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-hand-holding-heart"></i>
                    </div>
                    <div class="service-content">
                        <h4>Occupational Therapy</h4>
                        <p>Therapy to help patients develop, recover, and maintain daily living skills.</p>
                        <div class="service-details">
                            <span><i class="fas fa-clock"></i> 8:30 AM - 4:30 PM</span>
                            <span><i class="fas fa-map-marker-alt"></i> Building C, Floor 2</span>
                        </div>
                        <div class="service-actions">
                            <a href="view-service.jsp?id=6" class="btn-small">View Details</a>
                            <% if (userRole.equals("PATIENT")) { %>
                            <a href="book-service.jsp?id=6" class="btn-small">Book Service</a>
                            <% } else if (userRole.equals("ADMIN")) { %>
                            <a href="edit-service.jsp?id=6" class="btn-small secondary">Edit</a>
                            <% } else if (userRole.equals("GUEST")) { %>
                            <a href="login.jsp?redirect=book-service.jsp?id=6" class="btn-small">Login to Book</a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="services-section">
            <h3>Surgical Services</h3>
            <div class="services-grid">
                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-procedures"></i>
                    </div>
                    <div class="service-content">
                        <h4>General Surgery</h4>
                        <p>Comprehensive surgical procedures for various medical conditions.</p>
                        <div class="service-details">
                            <span><i class="fas fa-clock"></i> By Appointment</span>
                            <span><i class="fas fa-map-marker-alt"></i> Building A, Floor 3</span>
                        </div>
                        <div class="service-actions">
                            <a href="view-service.jsp?id=7" class="btn-small">View Details</a>
                            <% if (userRole.equals("PATIENT")) { %>
                            <a href="book-service.jsp?id=7" class="btn-small">Book Consultation</a>
                            <% } else if (userRole.equals("ADMIN")) { %>
                            <a href="edit-service.jsp?id=7" class="btn-small secondary">Edit</a>
                            <% } else if (userRole.equals("GUEST")) { %>
                            <a href="login.jsp?redirect=book-service.jsp?id=7" class="btn-small">Login to Book</a>
                            <% } %>
                        </div>
                    </div>
                </div>

                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-eye"></i>
                    </div>
                    <div class="service-content">
                        <h4>Ophthalmologic Surgery</h4>
                        <p>Specialized surgical procedures for eye conditions and vision correction.</p>
                        <div class="service-details">
                            <span><i class="fas fa-clock"></i> By Appointment</span>
                            <span><i class="fas fa-map-marker-alt"></i> Building A, Floor 3</span>
                        </div>
                        <div class="service-actions">
                            <a href="view-service.jsp?id=8" class="btn-small">View Details</a>
                            <% if (userRole.equals("PATIENT")) { %>
                            <a href="book-service.jsp?id=8" class="btn-small">Book Consultation</a>
                            <% } else if (userRole.equals("ADMIN")) { %>
                            <a href="edit-service.jsp?id=8" class="btn-small secondary">Edit</a>
                            <% } else if (userRole.equals("GUEST")) { %>
                            <a href="login.jsp?redirect=book-service.jsp?id=8" class="btn-small">Login to Book</a>
                            <% } %>
                        </div>
                    </div>
                </div>

                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-bone"></i>
                    </div>
                    <div class="service-content">
                        <h4>Orthopedic Surgery</h4>
                        <p>Surgical procedures for conditions affecting bones, joints, and muscles.</p>
                        <div class="service-details">
                            <span><i class="fas fa-clock"></i> By Appointment</span>
                            <span><i class="fas fa-map-marker-alt"></i> Building A, Floor 3</span>
                        </div>
                        <div class="service-actions">
                            <a href="view-service.jsp?id=9" class="btn-small">View Details</a>
                            <% if (userRole.equals("PATIENT")) { %>
                            <a href="book-service.jsp?id=9" class="btn-small">Book Consultation</a>
                            <% } else if (userRole.equals("ADMIN")) { %>
                            <a href="edit-service.jsp?id=9" class="btn-small secondary">Edit</a>
                            <% } else if (userRole.equals("GUEST")) { %>
                            <a href="login.jsp?redirect=book-service.jsp?id=9" class="btn-small">Login to Book</a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>LifeCare Medical Center</h3>
                <p>Providing quality healthcare services since 2000.</p>
            </div>
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="appointments.jsp">Appointments</a></li>
                    <li><a href="departments.jsp">Departments</a></li>
                    <li><a href="services.jsp">Services</a></li>
                    <li><a href="profile.jsp">Profile</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Contact Us</h3>
                <p>123 Medical Avenue, Healthcare City</p>
                <p>Phone: (123) 456-7890</p>
                <p>Email: info@lifecaremedical.com</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2023 LifeCare Medical Center. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
