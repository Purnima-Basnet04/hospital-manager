<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Get user information from session
    String username = (String) session.getAttribute("username");
    String userRole = (String) session.getAttribute("userRole");
    String fullName = (String) session.getAttribute("fullName");
    String email = (String) session.getAttribute("email");
    String phone = (String) session.getAttribute("phone");
    String address = (String) session.getAttribute("address");
    
    // Set default values for non-logged in users
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    } else if (fullName == null || fullName.isEmpty()) {
        fullName = username;
    }
    
    // Set default values for missing profile information
    if (email == null) email = "example@lifecare.com";
    if (phone == null) phone = "Not provided";
    if (address == null) address = "Not provided";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile - LifeCare Medical Center</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
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
        
        .profile-container {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-top: 30px;
        }
        
        .profile-sidebar {
            flex: 1;
            min-width: 250px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 25px;
        }
        
        .profile-main {
            flex: 3;
            min-width: 300px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 25px;
        }
        
        .profile-header {
            text-align: center;
            margin-bottom: 25px;
            padding-bottom: 25px;
            border-bottom: 1px solid #eee;
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            background-color: #3498db;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            font-weight: bold;
            color: white;
            margin: 0 auto 15px;
        }
        
        .profile-name {
            font-size: 24px;
            font-weight: 600;
            margin: 10px 0 5px;
        }
        
        .profile-role {
            color: #666;
            font-size: 16px;
            margin: 0;
        }
        
        .profile-nav {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .profile-nav li {
            margin-bottom: 10px;
        }
        
        .profile-nav a {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: #333;
            text-decoration: none;
            border-radius: 6px;
            transition: all 0.3s;
        }
        
        .profile-nav a:hover,
        .profile-nav a.active {
            background-color: #f0f7ff;
            color: #3498db;
        }
        
        .profile-nav i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
            color: #3498db;
        }
        
        .section-title {
            font-size: 20px;
            font-weight: 600;
            margin-top: 0;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
            color: #2c3e50;
        }
        
        .profile-form {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        .form-control:focus {
            border-color: #3498db;
            outline: none;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 25px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s;
            text-decoration: none;
        }
        
        .btn:hover {
            background-color: #2980b9;
        }
        
        .btn-secondary {
            background-color: #95a5a6;
        }
        
        .btn-secondary:hover {
            background-color: #7f8c8d;
        }
        
        .form-actions {
            margin-top: 30px;
            display: flex;
            gap: 15px;
        }
        
        .profile-info {
            margin-bottom: 30px;
        }
        
        .info-item {
            display: flex;
            margin-bottom: 15px;
            align-items: center;
        }
        
        .info-label {
            font-weight: 500;
            width: 150px;
            color: #555;
        }
        
        .info-value {
            flex: 1;
        }
        
        .info-icon {
            margin-right: 10px;
            width: 20px;
            text-align: center;
            color: #3498db;
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
            
            .profile-container {
                flex-direction: column;
            }
            
            .profile-form {
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
                    <p><%= userRole %></p>
                </div>
            </div>
        </div>
    </header>
    
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/home.jsp">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/appointments.jsp">Appointments</a></li>
            <li><a href="${pageContext.request.contextPath}/departments.jsp">Departments</a></li>
            <li><a href="${pageContext.request.contextPath}/services.jsp">Services</a></li>
            <% if (userRole.equals("ADMIN")) { %>
            <li><a href="${pageContext.request.contextPath}/dashboard-admin.jsp">Admin Dashboard</a></li>
            <% } else if (userRole.equals("DOCTOR")) { %>
            <li><a href="${pageContext.request.contextPath}/dashboard-doctor.jsp">Doctor Dashboard</a></li>
            <% } else if (userRole.equals("PATIENT")) { %>
            <li><a href="${pageContext.request.contextPath}/dashboard-patient.jsp">Patient Dashboard</a></li>
            <% } %>
            <li><a href="${pageContext.request.contextPath}/profile.jsp" class="active">Profile</a></li>
            <li><a href="${pageContext.request.contextPath}/logout.jsp">Logout</a></li>
        </ul>
    </nav>
    
    <div class="container">
        <h2>User Profile</h2>
        
        <div class="profile-container">
            <div class="profile-sidebar">
                <div class="profile-header">
                    <div class="profile-avatar">
                        <%= username.substring(0, 1).toUpperCase() %>
                    </div>
                    <h3 class="profile-name"><%= fullName %></h3>
                    <p class="profile-role"><%= userRole %></p>
                </div>
                
                <ul class="profile-nav">
                    <li><a href="#" class="active"><i class="fas fa-user"></i> Personal Information</a></li>
                    <li><a href="#"><i class="fas fa-lock"></i> Security</a></li>
                    <li><a href="#"><i class="fas fa-bell"></i> Notifications</a></li>
                    <% if (userRole.equals("PATIENT")) { %>
                    <li><a href="#"><i class="fas fa-file-medical"></i> Medical History</a></li>
                    <li><a href="#"><i class="fas fa-pills"></i> Prescriptions</a></li>
                    <% } else if (userRole.equals("DOCTOR")) { %>
                    <li><a href="#"><i class="fas fa-calendar-alt"></i> Schedule</a></li>
                    <li><a href="#"><i class="fas fa-certificate"></i> Qualifications</a></li>
                    <% } %>
                    <li><a href="#"><i class="fas fa-cog"></i> Preferences</a></li>
                </ul>
            </div>
            
            <div class="profile-main">
                <h3 class="section-title">Personal Information</h3>
                
                <div class="profile-info">
                    <div class="info-item">
                        <div class="info-label"><i class="fas fa-user info-icon"></i> Full Name</div>
                        <div class="info-value"><%= fullName %></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label"><i class="fas fa-envelope info-icon"></i> Email</div>
                        <div class="info-value"><%= email %></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label"><i class="fas fa-phone info-icon"></i> Phone</div>
                        <div class="info-value"><%= phone %></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label"><i class="fas fa-map-marker-alt info-icon"></i> Address</div>
                        <div class="info-value"><%= address %></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label"><i class="fas fa-id-badge info-icon"></i> Role</div>
                        <div class="info-value"><%= userRole %></div>
                    </div>
                </div>
                
                <h3 class="section-title">Edit Profile</h3>
                
                <form action="update-profile" method="post" class="profile-form">
                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <input type="text" id="fullName" name="fullName" class="form-control" value="<%= fullName %>">
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" class="form-control" value="<%= email %>">
                    </div>
                    
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="tel" id="phone" name="phone" class="form-control" value="<%= phone %>">
                    </div>
                    
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" class="form-control" value="<%= address %>">
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn">Save Changes</button>
                        <button type="reset" class="btn btn-secondary">Cancel</button>
                    </div>
                </form>
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
