<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Prescription" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Prescriptions | LifeCare Medical Center</title>
    
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
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }
        
        header {
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px 0;
        }
        
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .logo {
            display: flex;
            align-items: center;
        }
        
        .logo img {
            height: 40px;
            margin-right: 10px;
        }
        
        .logo h1 {
            font-size: 24px;
            color: #3498db;
            font-weight: 700;
        }
        
        .user-info {
            display: flex;
            align-items: center;
        }
        
        .user-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }
        
        .user-details {
            text-align: right;
        }
        
        .user-name {
            font-weight: 600;
            color: #2c3e50;
        }
        
        .user-role {
            font-size: 14px;
            color: #7f8c8d;
        }
        
        nav {
            background-color: #3498db;
            padding: 15px 0;
        }
        
        nav ul {
            display: flex;
            justify-content: center;
            list-style: none;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        nav ul li {
            margin: 0 15px;
        }
        
        nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            padding: 5px 10px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        
        nav ul li a:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }
        
        nav ul li a.active {
            background-color: white;
            color: #3498db;
        }
        
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .page-title {
            margin-bottom: 30px;
            text-align: center;
        }
        
        .page-title h2 {
            font-size: 32px;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .page-title p {
            color: #7f8c8d;
            font-size: 18px;
        }
        
        .prescriptions-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .prescriptions-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .prescriptions-header h3 {
            font-size: 24px;
            color: #2c3e50;
        }
        
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn:hover {
            background-color: #2980b9;
            transform: translateY(-3px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        
        .btn.secondary {
            background-color: #95a5a6;
        }
        
        .btn.secondary:hover {
            background-color: #7f8c8d;
        }
        
        .btn.success {
            background-color: #2ecc71;
        }
        
        .btn.success:hover {
            background-color: #27ae60;
        }
        
        .btn.warning {
            background-color: #f39c12;
        }
        
        .btn.warning:hover {
            background-color: #d35400;
        }
        
        .btn.danger {
            background-color: #e74c3c;
        }
        
        .btn.danger:hover {
            background-color: #c0392b;
        }
        
        .btn-small {
            padding: 5px 10px;
            font-size: 14px;
        }
        
        .prescriptions-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .prescriptions-table th,
        .prescriptions-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ecf0f1;
        }
        
        .prescriptions-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #2c3e50;
        }
        
        .prescriptions-table tr:hover {
            background-color: #f8f9fa;
        }
        
        .prescriptions-table .actions {
            display: flex;
            gap: 10px;
        }
        
        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
        }
        
        .status-active {
            background-color: #e8f8f5;
            color: #27ae60;
        }
        
        .status-expired {
            background-color: #fef5e7;
            color: #d35400;
        }
        
        .status-pending {
            background-color: #eaecee;
            color: #7f8c8d;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        
        .pagination a {
            display: inline-block;
            padding: 8px 16px;
            margin: 0 5px;
            border-radius: 5px;
            background-color: white;
            color: #3498db;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        
        .pagination a:hover {
            background-color: #3498db;
            color: white;
        }
        
        .pagination a.active {
            background-color: #3498db;
            color: white;
        }
        
        footer {
            background-color: #2c3e50;
            color: white;
            padding: 40px 0;
            margin-top: 50px;
        }
        
        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        
        .footer-section {
            flex: 1;
            min-width: 250px;
            margin-bottom: 30px;
        }
        
        .footer-section h3 {
            font-size: 18px;
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 10px;
        }
        
        .footer-section h3::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 2px;
            background-color: #3498db;
        }
        
        .footer-section p {
            margin-bottom: 15px;
            color: #bdc3c7;
        }
        
        .footer-section ul {
            list-style: none;
        }
        
        .footer-section ul li {
            margin-bottom: 10px;
        }
        
        .footer-section ul li a {
            color: #bdc3c7;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .footer-section ul li a:hover {
            color: #3498db;
            padding-left: 5px;
        }
        
        .footer-bottom {
            background-color: #1a252f;
            padding: 20px 0;
            text-align: center;
        }
        
        .footer-bottom p {
            color: #bdc3c7;
            font-size: 14px;
        }
        
        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                text-align: center;
            }
            
            .logo {
                margin-bottom: 15px;
            }
            
            nav ul {
                flex-direction: column;
                align-items: center;
            }
            
            nav ul li {
                margin: 5px 0;
            }
            
            .user-info {
                margin-top: 15px;
            }
            
            .prescriptions-header {
                flex-direction: column;
                gap: 15px;
            }
            
            .prescriptions-table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
    <%
        // Check if user is logged in
        String username = (String) session.getAttribute("username");
        String userRole = (String) session.getAttribute("userRole");
        String fullName = (String) session.getAttribute("fullName");
        
        // Redirect to login page if not logged in or not a doctor
        if (username == null || !userRole.equals("DOCTOR")) {
            response.sendRedirect("login.jsp?redirect=doctor-prescriptions.jsp");
            return;
        }
        
        // Get prescriptions from request attribute
        List<Prescription> prescriptions = (List<Prescription>) request.getAttribute("prescriptions");
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy");
    %>

    <header>
        <div class="header-container">
            <div class="logo">
                <img src="assets/images/logo.png" alt="LifeCare Medical Center Logo">
                <h1>LifeCare Medical Center</h1>
            </div>
            
            <div class="user-info">
                <img src="assets/images/doctor-avatar.png" alt="Doctor Avatar">
                <div class="user-details">
                    <div class="user-name"><%= fullName != null ? fullName : username %></div>
                    <div class="user-role">Doctor</div>
                </div>
            </div>
        </div>
    </header>

    <nav>
        <ul>
            <li><a href="home.jsp">Home</a></li>
            <li><a href="dashboard-doctor.jsp">Dashboard</a></li>
            <li><a href="doctor-appointments.jsp">Appointments</a></li>
            <li><a href="doctor-prescriptions.jsp" class="active">Prescriptions</a></li>
            <li><a href="doctor-patients.jsp">My Patients</a></li>
            <li><a href="doctor-profile.jsp">Profile</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="page-title">
            <h2>Prescriptions</h2>
            <p>Manage prescriptions for your patients</p>
        </div>
        
        <div class="prescriptions-container">
            <div class="prescriptions-header">
                <h3>All Prescriptions</h3>
                <a href="doctor-add-prescription.jsp" class="btn">Add New Prescription</a>
            </div>
            
            <% if (prescriptions != null && !prescriptions.isEmpty()) { %>
            <table class="prescriptions-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Patient</th>
                        <th>Medication</th>
                        <th>Dosage</th>
                        <th>Issue Date</th>
                        <th>Expiry Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Prescription prescription : prescriptions) { %>
                    <tr>
                        <td><%= prescription.getId() %></td>
                        <td><%= prescription.getPatientName() %></td>
                        <td><%= prescription.getMedication() %></td>
                        <td><%= prescription.getDosage() %></td>
                        <td><%= dateFormat.format(prescription.getIssueDate()) %></td>
                        <td><%= dateFormat.format(prescription.getExpiryDate()) %></td>
                        <td>
                            <% if (prescription.isActive()) { %>
                            <span class="status-badge status-active">Active</span>
                            <% } else { %>
                            <span class="status-badge status-expired">Expired</span>
                            <% } %>
                        </td>
                        <td class="actions">
                            <a href="PrescriptionServlet?action=view&id=<%= prescription.getId() %>" class="btn-small">View</a>
                            <a href="PrescriptionServlet?action=edit&id=<%= prescription.getId() %>" class="btn-small warning">Edit</a>
                            <a href="PrescriptionServlet?action=delete&id=<%= prescription.getId() %>" class="btn-small danger" onclick="return confirm('Are you sure you want to delete this prescription?')">Delete</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            
            <div class="pagination">
                <a href="#">&laquo;</a>
                <a href="#" class="active">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">&raquo;</a>
            </div>
            <% } else { %>
            <div style="text-align: center; padding: 30px;">
                <p>No prescriptions found. Start by adding a new prescription.</p>
            </div>
            <% } %>
        </div>
    </div>

    <footer>
        <div class="footer-container">
            <div class="footer-section">
                <h3>About Us</h3>
                <p>LifeCare Medical Center is dedicated to providing exceptional healthcare services with a focus on patient comfort and advanced medical treatments.</p>
            </div>
            
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="services.jsp">Services</a></li>
                    <li><a href="departments.jsp">Departments</a></li>
                    <li><a href="our-doctors.jsp">Doctors</a></li>
                    <li><a href="contact-us.jsp">Contact Us</a></li>
                </ul>
            </div>
            
            <div class="footer-section">
                <h3>Contact Information</h3>
                <p><i class="fas fa-map-marker-alt"></i> 123 Medical Center Drive, Healthcare City, HC 12345</p>
                <p><i class="fas fa-phone"></i> +1 (555) 123-4567</p>
                <p><i class="fas fa-envelope"></i> info@lifecaremedical.com</p>
            </div>
        </div>
        
        <div class="footer-bottom">
            <p>&copy; <%= new java.util.Date().getYear() + 1900 %> LifeCare Medical Center. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
