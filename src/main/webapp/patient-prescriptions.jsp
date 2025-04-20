<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Prescription" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Prescriptions | LifeCare Medical Center</title>
    
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
        
        .prescription-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }
        
        .prescription-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .prescription-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #ecf0f1;
        }
        
        .prescription-title {
            font-size: 20px;
            font-weight: 600;
            color: #2c3e50;
        }
        
        .prescription-date {
            font-size: 14px;
            color: #7f8c8d;
        }
        
        .prescription-details {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .detail-item {
            margin-bottom: 10px;
        }
        
        .detail-label {
            font-size: 14px;
            color: #7f8c8d;
            margin-bottom: 5px;
        }
        
        .detail-value {
            font-weight: 500;
            color: #2c3e50;
        }
        
        .prescription-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #ecf0f1;
        }
        
        .prescription-doctor {
            display: flex;
            align-items: center;
        }
        
        .doctor-avatar {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            margin-right: 10px;
        }
        
        .doctor-name {
            font-weight: 500;
            color: #2c3e50;
        }
        
        .prescription-actions {
            display: flex;
            gap: 10px;
        }
        
        .empty-state {
            text-align: center;
            padding: 50px 20px;
        }
        
        .empty-state-icon {
            font-size: 60px;
            color: #bdc3c7;
            margin-bottom: 20px;
        }
        
        .empty-state-title {
            font-size: 24px;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .empty-state-message {
            color: #7f8c8d;
            margin-bottom: 20px;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
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
            
            .prescription-details {
                grid-template-columns: 1fr;
            }
            
            .prescription-footer {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
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
        
        // Redirect to login page if not logged in or not a patient
        if (username == null || !userRole.equals("PATIENT")) {
            response.sendRedirect("login.jsp?redirect=patient-prescriptions.jsp");
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
                <img src="assets/images/patient-avatar.png" alt="Patient Avatar">
                <div class="user-details">
                    <div class="user-name"><%= fullName != null ? fullName : username %></div>
                    <div class="user-role">Patient</div>
                </div>
            </div>
        </div>
    </header>

    <nav>
        <ul>
            <li><a href="home.jsp">Home</a></li>
            <li><a href="dashboard-patient.jsp">Dashboard</a></li>
            <li><a href="appointments.jsp">Appointments</a></li>
            <li><a href="patient-prescriptions.jsp" class="active">Prescriptions</a></li>
            <li><a href="patient-medical-records.jsp">Medical Records</a></li>
            <li><a href="patient-profile.jsp">Profile</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="page-title">
            <h2>My Prescriptions</h2>
            <p>View and manage your prescriptions</p>
        </div>
        
        <% if (prescriptions != null && !prescriptions.isEmpty()) { %>
        <div class="prescriptions-container">
            <div class="prescriptions-header">
                <h3>Current Prescriptions</h3>
                <a href="book-appointment.jsp" class="btn">Book Appointment</a>
            </div>
            
            <% for (Prescription prescription : prescriptions) { 
                if (prescription.isActive()) { %>
            <div class="prescription-card">
                <div class="prescription-header">
                    <div class="prescription-title"><%= prescription.getMedication() %></div>
                    <div class="status-badge status-active">Active</div>
                </div>
                
                <div class="prescription-details">
                    <div class="detail-item">
                        <div class="detail-label">Dosage</div>
                        <div class="detail-value"><%= prescription.getDosage() %></div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">Frequency</div>
                        <div class="detail-value"><%= prescription.getFrequency() %></div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">Duration</div>
                        <div class="detail-value"><%= prescription.getDuration() %></div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">Issue Date</div>
                        <div class="detail-value"><%= dateFormat.format(prescription.getIssueDate()) %></div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">Expiry Date</div>
                        <div class="detail-value"><%= dateFormat.format(prescription.getExpiryDate()) %></div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">Instructions</div>
                        <div class="detail-value"><%= prescription.getInstructions() %></div>
                    </div>
                </div>
                
                <div class="prescription-footer">
                    <div class="prescription-doctor">
                        <img src="assets/images/doctor-avatar.png" alt="Doctor Avatar" class="doctor-avatar">
                        <div class="doctor-name">Dr. <%= prescription.getDoctorName() %></div>
                    </div>
                    
                    <div class="prescription-actions">
                        <a href="PrescriptionServlet?action=view&id=<%= prescription.getId() %>" class="btn-small">View Details</a>
                        <a href="PrescriptionServlet?action=print&id=<%= prescription.getId() %>" class="btn-small">Print</a>
                    </div>
                </div>
            </div>
            <% } } %>
            
            <div class="prescriptions-header" style="margin-top: 40px;">
                <h3>Past Prescriptions</h3>
            </div>
            
            <% boolean hasPastPrescriptions = false;
               for (Prescription prescription : prescriptions) { 
                if (!prescription.isActive()) { 
                    hasPastPrescriptions = true; %>
            <div class="prescription-card">
                <div class="prescription-header">
                    <div class="prescription-title"><%= prescription.getMedication() %></div>
                    <div class="status-badge status-expired">Expired</div>
                </div>
                
                <div class="prescription-details">
                    <div class="detail-item">
                        <div class="detail-label">Dosage</div>
                        <div class="detail-value"><%= prescription.getDosage() %></div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">Frequency</div>
                        <div class="detail-value"><%= prescription.getFrequency() %></div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">Duration</div>
                        <div class="detail-value"><%= prescription.getDuration() %></div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">Issue Date</div>
                        <div class="detail-value"><%= dateFormat.format(prescription.getIssueDate()) %></div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">Expiry Date</div>
                        <div class="detail-value"><%= dateFormat.format(prescription.getExpiryDate()) %></div>
                    </div>
                </div>
                
                <div class="prescription-footer">
                    <div class="prescription-doctor">
                        <img src="assets/images/doctor-avatar.png" alt="Doctor Avatar" class="doctor-avatar">
                        <div class="doctor-name">Dr. <%= prescription.getDoctorName() %></div>
                    </div>
                    
                    <div class="prescription-actions">
                        <a href="PrescriptionServlet?action=view&id=<%= prescription.getId() %>" class="btn-small">View Details</a>
                        <a href="PrescriptionServlet?action=print&id=<%= prescription.getId() %>" class="btn-small">Print</a>
                    </div>
                </div>
            </div>
            <% } } 
               if (!hasPastPrescriptions) { %>
            <div style="text-align: center; padding: 20px;">
                <p>No past prescriptions found.</p>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="empty-state">
            <i class="fas fa-prescription-bottle-alt empty-state-icon"></i>
            <h3 class="empty-state-title">No Prescriptions Found</h3>
            <p class="empty-state-message">You don't have any prescriptions yet. Book an appointment with a doctor to get a prescription.</p>
            <a href="book-appointment.jsp" class="btn">Book Appointment</a>
        </div>
        <% } %>
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
