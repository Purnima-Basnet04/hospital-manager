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
    <title>Departments - LifeCare Medical Center</title>

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
            margin-bottom: 40px;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
        }

        .page-title h2 {
            color: #2c3e50;
            margin-top: 0;
            font-size: 32px;
            margin-bottom: 15px;
        }

        .page-title p {
            color: #555;
            max-width: 700px;
            margin: 0 auto;
            font-size: 16px;
            line-height: 1.6;
        }

        .page-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background-color: #3498db;
            border-radius: 3px;
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

        .departments-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 35px;
            margin-bottom: 40px;
            padding: 10px;
        }

        .department-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            transition: all 0.3s ease;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .department-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            border-color: rgba(52, 152, 219, 0.3);
        }

        .department-image {
            height: 200px;
            overflow: hidden;
            position: relative;
        }

        .department-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
            display: block;
        }

        .department-card:hover .department-image img {
            transform: scale(1.05);
        }

        .department-image::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 30%;
            background: linear-gradient(to top, rgba(0,0,0,0.3), transparent);
            pointer-events: none;
        }

        .department-content {
            padding: 25px;
        }

        .department-content h3 {
            color: #2c3e50;
            margin-top: 0;
            margin-bottom: 12px;
            font-size: 22px;
            font-weight: 600;
            position: relative;
            padding-bottom: 10px;
        }

        .department-content h3::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 3px;
            background-color: #3498db;
            border-radius: 3px;
        }

        .department-content p {
            margin-bottom: 22px;
            color: #555;
            line-height: 1.6;
            font-size: 15px;
        }

        .department-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
            font-size: 14px;
            background-color: #f8f9fa;
            padding: 10px 15px;
            border-radius: 6px;
        }

        .department-details span {
            display: flex;
            align-items: center;
            color: #555;
        }

        .department-details i {
            margin-right: 8px;
            color: #3498db;
            font-size: 16px;
        }

        .department-actions {
            display: flex;
            justify-content: space-between;
        }

        .department-actions .btn-small {
            flex: 1;
            text-align: center;
            margin-right: 10px;
        }

        .department-actions .btn-small:last-child {
            margin-right: 0;
        }

        .btn-small {
            display: inline-block;
            padding: 10px 18px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .btn-small:hover {
            background-color: #2980b9;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            transform: translateY(-2px);
        }

        .btn-small.secondary {
            background-color: #95a5a6;
        }

        .btn-small.secondary:hover {
            background-color: #7f8c8d;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            transform: translateY(-2px);
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
        @media (max-width: 1024px) {
            .departments-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 25px;
            }
        }

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

            .departments-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 20px;
            }

            .page-title h2 {
                font-size: 28px;
            }

            .department-content h3 {
                font-size: 20px;
            }
        }

        @media (max-width: 480px) {
            .departments-grid {
                grid-template-columns: 1fr;
            }

            .department-image {
                height: 180px;
            }

            .department-actions {
                flex-direction: column;
            }

            .department-actions .btn-small {
                margin-right: 0;
                margin-bottom: 10px;
                width: 100%;
            }

            .department-actions .btn-small:last-child {
                margin-bottom: 0;
            }

            .page-title h2 {
                font-size: 24px;
            }

            .page-title p {
                font-size: 14px;
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
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn-small">Login</a>
                <a href="${pageContext.request.contextPath}/register.jsp" class="btn-small">Register</a>
            </div>
            <% } %>
        </div>
    </header>

    <nav>
        <ul>
            <% if (username.equals("Guest")) { %>
            <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/appointments.jsp">Appointments</a></li>
            <li><a href="${pageContext.request.contextPath}/departments.jsp" class="active">Departments</a></li>
            <li><a href="${pageContext.request.contextPath}/services.jsp">Services</a></li>
            <li><a href="${pageContext.request.contextPath}/login.jsp">Login</a></li>
            <li><a href="${pageContext.request.contextPath}/register.jsp">Register</a></li>
            <% } else { %>
            <li><a href="${pageContext.request.contextPath}/home.jsp">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/appointments.jsp">Appointments</a></li>
            <li><a href="${pageContext.request.contextPath}/departments.jsp" class="active">Departments</a></li>
            <li><a href="${pageContext.request.contextPath}/services.jsp">Services</a></li>
            <% if (userRole.equals("ADMIN")) { %>
            <li><a href="${pageContext.request.contextPath}/admin-dashboard.jsp">Admin Dashboard</a></li>
            <% } else if (userRole.equals("DOCTOR")) { %>
            <li><a href="${pageContext.request.contextPath}/dashboard-doctor.jsp">Doctor Dashboard</a></li>
            <% } else if (userRole.equals("PATIENT")) { %>
            <li><a href="${pageContext.request.contextPath}/patient-dashboard.jsp">Patient Dashboard</a></li>
            <% } %>
            <li><a href="${pageContext.request.contextPath}/profile.jsp">Profile</a></li>
            <li><a href="${pageContext.request.contextPath}/logout.jsp">Logout</a></li>
            <% } %>
        </ul>
    </nav>

    <div class="container">
        <div class="page-title">
            <h2>Medical Departments</h2>
            <p>Explore our specialized medical departments and the services they offer.</p>
        </div>

        <% if (userRole.equals("ADMIN")) { %>
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/add-department.jsp" class="btn">Add New Department</a>
            <a href="${pageContext.request.contextPath}/manage-departments.jsp" class="btn secondary">Manage Departments</a>
        </div>
        <% } %>

        <div class="departments-grid">
            <!-- Cardiology Department -->
            <div class="department-card">
                <div class="department-image">
                    <img src="https://img.freepik.com/free-photo/doctor-with-stethoscope-hands-hospital-background_1423-1.jpg" alt="Cardiology Department">
                </div>
                <div class="department-content">
                    <h3>Cardiology</h3>
                    <p>Specialized in diagnosing and treating heart diseases and cardiovascular conditions.</p>
                    <div class="department-details">
                        <span><i class="fas fa-user-md"></i> 5 Specialists</span>
                        <span><i class="fas fa-map-marker-alt"></i> Building A, Floor 2</span>
                    </div>
                    <div class="department-actions">
                        <a href="${pageContext.request.contextPath}/view-department.jsp?id=1" class="btn-small">View Details</a>
                        <% if (userRole.equals("PATIENT")) { %>
                        <a href="${pageContext.request.contextPath}/book-appointment.jsp?dept=1" class="btn-small">Book Appointment</a>
                        <% } else if (userRole.equals("ADMIN")) { %>
                        <a href="${pageContext.request.contextPath}/edit-department.jsp?id=1" class="btn-small secondary">Edit</a>
                        <% } else if (userRole.equals("GUEST")) { %>
                        <a href="${pageContext.request.contextPath}/login.jsp?redirect=book-appointment.jsp?dept=1" class="btn-small">Book Appointment</a>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Neurology Department -->
            <div class="department-card">
                <div class="department-image">
                    <img src="https://img.freepik.com/free-photo/medical-banner-with-doctor-working-brain-scan_23-2149611199.jpg" alt="Neurology Department">
                </div>
                <div class="department-content">
                    <h3>Neurology</h3>
                    <p>Focused on disorders of the nervous system, including the brain, spinal cord, and nerves.</p>
                    <div class="department-details">
                        <span><i class="fas fa-user-md"></i> 4 Specialists</span>
                        <span><i class="fas fa-map-marker-alt"></i> Building B, Floor 1</span>
                    </div>
                    <div class="department-actions">
                        <a href="${pageContext.request.contextPath}/view-department.jsp?id=2" class="btn-small">View Details</a>
                        <% if (userRole.equals("PATIENT")) { %>
                        <a href="${pageContext.request.contextPath}/book-appointment.jsp?dept=2" class="btn-small">Book Appointment</a>
                        <% } else if (userRole.equals("ADMIN")) { %>
                        <a href="${pageContext.request.contextPath}/edit-department.jsp?id=2" class="btn-small secondary">Edit</a>
                        <% } else if (userRole.equals("GUEST")) { %>
                        <a href="${pageContext.request.contextPath}/login.jsp?redirect=book-appointment.jsp?dept=2" class="btn-small">Book Appointment</a>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Pediatrics Department -->
            <div class="department-card">
                <div class="department-image">
                    <img src="https://img.freepik.com/free-photo/doctor-child-patient-medical-examination-hospital_1303-21297.jpg" alt="Pediatrics Department">
                </div>
                <div class="department-content">
                    <h3>Pediatrics</h3>
                    <p>Dedicated to the health and medical care of infants, children, and adolescents.</p>
                    <div class="department-details">
                        <span><i class="fas fa-user-md"></i> 6 Specialists</span>
                        <span><i class="fas fa-map-marker-alt"></i> Building C, Floor 1</span>
                    </div>
                    <div class="department-actions">
                        <a href="${pageContext.request.contextPath}/view-department.jsp?id=3" class="btn-small">View Details</a>
                        <% if (userRole.equals("PATIENT")) { %>
                        <a href="${pageContext.request.contextPath}/book-appointment.jsp?dept=3" class="btn-small">Book Appointment</a>
                        <% } else if (userRole.equals("ADMIN")) { %>
                        <a href="${pageContext.request.contextPath}/edit-department.jsp?id=3" class="btn-small secondary">Edit</a>
                        <% } else if (userRole.equals("GUEST")) { %>
                        <a href="${pageContext.request.contextPath}/login.jsp?redirect=book-appointment.jsp?dept=3" class="btn-small">Book Appointment</a>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Orthopedics Department -->
            <div class="department-card">
                <div class="department-image">
                    <img src="https://img.freepik.com/free-photo/physiotherapist-giving-exercise-treatment-about-knee-patient-hospital_1150-15811.jpg" alt="Orthopedics Department">
                </div>
                <div class="department-content">
                    <h3>Orthopedics</h3>
                    <p>Specializing in conditions affecting the musculoskeletal system, including bones, joints, and muscles.</p>
                    <div class="department-details">
                        <span><i class="fas fa-user-md"></i> 4 Specialists</span>
                        <span><i class="fas fa-map-marker-alt"></i> Building A, Floor 3</span>
                    </div>
                    <div class="department-actions">
                        <a href="${pageContext.request.contextPath}/view-department.jsp?id=4" class="btn-small">View Details</a>
                        <% if (userRole.equals("PATIENT")) { %>
                        <a href="${pageContext.request.contextPath}/book-appointment.jsp?dept=4" class="btn-small">Book Appointment</a>
                        <% } else if (userRole.equals("ADMIN")) { %>
                        <a href="${pageContext.request.contextPath}/edit-department.jsp?id=4" class="btn-small secondary">Edit</a>
                        <% } else if (userRole.equals("GUEST")) { %>
                        <a href="${pageContext.request.contextPath}/login.jsp?redirect=book-appointment.jsp?dept=4" class="btn-small">Book Appointment</a>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Dermatology Department -->
            <div class="department-card">
                <div class="department-image">
                    <img src="https://img.freepik.com/free-photo/dermatologist-checking-patient-moles_23-2148865287.jpg" alt="Dermatology Department">
                </div>
                <div class="department-content">
                    <h3>Dermatology</h3>
                    <p>Focused on diagnosing and treating conditions related to the skin, hair, and nails.</p>
                    <div class="department-details">
                        <span><i class="fas fa-user-md"></i> 3 Specialists</span>
                        <span><i class="fas fa-map-marker-alt"></i> Building B, Floor 2</span>
                    </div>
                    <div class="department-actions">
                        <a href="${pageContext.request.contextPath}/view-department.jsp?id=5" class="btn-small">View Details</a>
                        <% if (userRole.equals("PATIENT")) { %>
                        <a href="${pageContext.request.contextPath}/book-appointment.jsp?dept=5" class="btn-small">Book Appointment</a>
                        <% } else if (userRole.equals("ADMIN")) { %>
                        <a href="${pageContext.request.contextPath}/edit-department.jsp?id=5" class="btn-small secondary">Edit</a>
                        <% } else if (userRole.equals("GUEST")) { %>
                        <a href="${pageContext.request.contextPath}/login.jsp?redirect=book-appointment.jsp?dept=5" class="btn-small">Book Appointment</a>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Ophthalmology Department -->
            <div class="department-card">
                <div class="department-image">
                    <img src="https://img.freepik.com/free-photo/ophthalmologist-checking-patient-s-vision-with-equipment_651396-1129.jpg" alt="Ophthalmology Department">
                </div>
                <div class="department-content">
                    <h3>Ophthalmology</h3>
                    <p>Specializing in the diagnosis and treatment of eye disorders and vision problems.</p>
                    <div class="department-details">
                        <span><i class="fas fa-user-md"></i> 3 Specialists</span>
                        <span><i class="fas fa-map-marker-alt"></i> Building A, Floor 1</span>
                    </div>
                    <div class="department-actions">
                        <a href="view-department.jsp?id=6" class="btn-small">View Details</a>
                        <% if (userRole.equals("PATIENT")) { %>
                        <a href="book-appointment.jsp?dept=6" class="btn-small">Book Appointment</a>
                        <% } else if (userRole.equals("ADMIN")) { %>
                        <a href="edit-department.jsp?id=6" class="btn-small secondary">Edit</a>
                        <% } else if (userRole.equals("GUEST")) { %>
                        <a href="login.jsp?redirect=book-appointment.jsp?dept=6" class="btn-small">Book Appointment</a>
                        <% } %>
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
                    <li><a href="${pageContext.request.contextPath}/home.jsp">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/appointments.jsp">Appointments</a></li>
                    <li><a href="${pageContext.request.contextPath}/departments.jsp">Departments</a></li>
                    <li><a href="${pageContext.request.contextPath}/services.jsp">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/profile.jsp">Profile</a></li>
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
