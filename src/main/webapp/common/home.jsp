<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Get user information from session
    String username = (String) session.getAttribute("username");
    String userRole = (String) session.getAttribute("userRole");
    String fullName = (String) session.getAttribute("fullName");

    // Set default values if needed
    if (fullName == null || fullName.isEmpty()) {
        fullName = username;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - LifeCare Medical Center</title>

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
            background-color: rgba(52, 152, 219, 0.2);
            padding: 8px 15px;
            border-radius: 30px;
            border: 1px solid rgba(52, 152, 219, 0.3);
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            background-color: #3498db;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-right: 12px;
            font-size: 18px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        .user-details h4 {
            margin: 0;
            font-size: 16px;
            font-weight: 600;
        }

        .user-details p {
            margin: 5px 0 0;
            font-size: 14px;
            color: #3498db;
            font-weight: 500;
            display: flex;
            align-items: center;
        }

        .user-details p i {
            margin-right: 5px;
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

        .welcome-section {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-bottom: 30px;
            text-align: center;
        }

        .welcome-section h2 {
            color: #2c3e50;
            margin-top: 0;
        }

        .feature-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 30px;
        }

        .feature-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            text-align: center;
            transition: transform 0.3s;
        }

        .feature-card:hover {
            transform: translateY(-5px);
        }

        .feature-icon {
            font-size: 48px;
            color: #3498db;
            margin-bottom: 20px;
        }

        .feature-card h3 {
            color: #2c3e50;
            margin-top: 0;
        }

        .feature-card p {
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
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .dashboard-link {
            text-align: center;
            margin: 30px 0;
        }

        .dashboard-link .btn {
            padding: 15px 30px;
            font-size: 18px;
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

            .feature-cards {
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
            <div class="user-info">
                <div class="user-avatar">
                    <%= username.substring(0, 1).toUpperCase() %>
                </div>
                <div class="user-details">
                    <h4><%= fullName %></h4>
                    <p>
                        <% if (userRole.equals("ADMIN")) { %>
                        <i class="fas fa-user-shield"></i>
                        <% } else if (userRole.equals("DOCTOR")) { %>
                        <i class="fas fa-user-md"></i>
                        <% } else if (userRole.equals("PATIENT")) { %>
                        <i class="fas fa-user"></i>
                        <% } %>
                        <%= userRole %>
                    </p>
                </div>
            </div>
        </div>
    </header>

    <nav>
        <ul>
            <li><a href="home.jsp" class="active">Home</a></li>
            <li><a href="appointments.jsp">Appointments</a></li>
            <li><a href="departments.jsp">Departments</a></li>
            <li><a href="services.jsp">Services</a></li>
            <% if (userRole.equals("ADMIN")) { %>
            <li><a href="admin-dashboard.jsp">Admin Dashboard</a></li>
            <% } else if (userRole.equals("DOCTOR")) { %>
            <li><a href="doctor-dashboard.jsp">Doctor Dashboard</a></li>
            <% } else if (userRole.equals("PATIENT")) { %>
            <li><a href="patient-dashboard.jsp">Patient Dashboard</a></li>
            <% } %>
            <li><a href="profile.jsp">Profile</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>

    <div class="container">
        <section class="welcome-section">
            <h2>Welcome to LifeCare Medical Center, <%= fullName %>!</h2>
            <p>Thank you for choosing LifeCare Medical Center for your healthcare needs. We are committed to providing you with the highest quality medical care.</p>
        </section>

        <section class="feature-cards">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <h3>Appointments</h3>
                <% if (userRole.equals("PATIENT")) { %>
                <p>Schedule appointments with our specialists at your convenience.</p>
                <a href="${pageContext.request.contextPath}/appointments.jsp" class="btn">Book Appointment</a>
                <% } else if (userRole.equals("DOCTOR")) { %>
                <p>View and manage your upcoming patient appointments.</p>
                <a href="${pageContext.request.contextPath}/appointments.jsp" class="btn">View Appointments</a>
                <% } else { %>
                <p>Manage all appointments in the system.</p>
                <a href="${pageContext.request.contextPath}/appointments.jsp" class="btn">Manage Appointments</a>
                <% } %>
            </div>

            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-hospital"></i>
                </div>
                <h3>Departments</h3>
                <p>Explore our specialized medical departments and services.</p>
                <a href="${pageContext.request.contextPath}/departments.jsp" class="btn">View Departments</a>
            </div>

            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-stethoscope"></i>
                </div>
                <h3>Services</h3>
                <p>Learn about the comprehensive healthcare services we offer.</p>
                <a href="${pageContext.request.contextPath}/services.jsp" class="btn">Explore Services</a>
            </div>
        </section>

        <div class="dashboard-link">
            <% if (userRole.equals("ADMIN")) { %>
            <a href="${pageContext.request.contextPath}/admin-dashboard.jsp" class="btn">Go to Admin Dashboard</a>
            <% } else if (userRole.equals("DOCTOR")) { %>
            <a href="${pageContext.request.contextPath}/doctor-dashboard.jsp" class="btn">Go to Doctor Dashboard</a>
            <% } else if (userRole.equals("PATIENT")) { %>
            <a href="${pageContext.request.contextPath}/patient-dashboard.jsp" class="btn">Go to Patient Dashboard</a>
            <% } %>
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
                    <li><a href="${pageContext.request.contextPath}/home.jsp">Home</a></li>
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
