<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
   String userRole = (String) session.getAttribute("userRole");
    String fullName = (String) session.getAttribute("fullName");
    
    if (username == null ) {
        response.sendRedirect("login.jsp?error=session");
        return;
    }
    
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
    <title><%=userRole%> Dashboard - LifeCare Medical Center</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <!-- Common CSS -->
    <link rel="stylesheet" type="text/css" href="styles/common.css">
    
    <!-- Dashboard CSS -->
    <link rel="stylesheet" type="text/css" href="styles/dashboard.css">
    
    <style>
        /* Basic dashboard layout */
        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }
        
        .sidebar {
            width: 250px;
            background-color: #2c3e50;
            color: white;
            padding: 20px 0;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
        }
        
        .sidebar-header {
            padding: 0 20px 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .user-info {
            display: flex;
            align-items: center;
            margin-top: 20px;
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
        
        .menu-category {
            padding: 15px 20px 5px;
            font-size: 12px;
            text-transform: uppercase;
            color: rgba(255, 255, 255, 0.5);
        }
        
        .sidebar-menu ul {
            list-style: none;
            padding: 0;
            margin: 0 0 15px;
        }
        
        .sidebar-menu ul li a {
            display: flex;
            align-items: center;
            padding: 10px 20px;
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .sidebar-menu ul li a:hover,
        .sidebar-menu ul li a.active {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }
        
        .sidebar-menu ul li a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .main-content {
            flex: 1;
            padding: 20px;
            margin-left: 250px;
            background-color: #f5f7fa;
        }
        
        .dashboard h2 {
            margin-top: 0;
            color: #2c3e50;
        }
        
        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        
        .stat-card h3 {
            margin-top: 0;
            color: #2c3e50;
            font-size: 16px;
        }
        
        .stat-number {
            font-size: 28px;
            font-weight: bold;
            color: #3498db;
            margin: 10px 0 0;
        }
        
        .dashboard-actions {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }
        
        .dashboard-actions h3 {
            margin-top: 0;
            color: #2c3e50;
        }
        
        .action-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        
        .btn {
            display: inline-block;
            padding: 10px 15px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .btn.primary {
            background-color: #3498db;
        }
        
        .btn.secondary {
            background-color: #95a5a6;
        }
        
        .btn:hover {
            opacity: 0.9;
        }
        
        .recent-section {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }
        
        .recent-section h3 {
            margin-top: 0;
            color: #2c3e50;
        }
        
        .data-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .data-table th,
        .data-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .data-table th {
            background-color: #f9f9f9;
            font-weight: 600;
            color: #2c3e50;
        }
        
        .data-table tr:last-child td {
            border-bottom: none;
        }
        
        .btn-small {
            display: inline-block;
            padding: 5px 10px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-size: 12px;
            margin-right: 5px;
        }
        
        .btn-small:hover {
            opacity: 0.9;
        }
        
        /* Success and error messages */
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        
        .success-message {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .dashboard-stats {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <h3>LifeCare Medical</h3>
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
            
            <div class="sidebar-menu">
                <% if (userRole.equals("ADMIN")) { %>
                <!-- Admin Menu -->
                <div class="menu-category">Management</div>
                <ul>
                    <li><a href="dashboard-admin.jsp" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="admin-doctors.jsp"><i class="fas fa-user-md"></i> Doctors</a></li>
                    <li><a href="admin-patients.jsp"><i class="fas fa-users"></i> Patients</a></li>
                    <li><a href="admin-appointments.jsp"><i class="fas fa-calendar-check"></i> Appointments</a></li>
                    <li><a href="admin-departments.jsp"><i class="fas fa-hospital"></i> Departments</a></li>
                </ul>
                
                <div class="menu-category">System</div>
                <ul>
                    <li><a href="admin-settings.jsp"><i class="fas fa-cog"></i> Settings</a></li>
                    <li><a href="admin-reports.jsp"><i class="fas fa-chart-bar"></i> Reports</a></li>
                    <li><a href="admin-logs.jsp"><i class="fas fa-history"></i> Logs</a></li>
                </ul>
                <% } else if (userRole.equals("DOCTOR")) { %>
                <!-- Doctor Menu -->
                <div class="menu-category">Medical</div>
                <ul>
                    <li><a href="dashboard-doctor.jsp" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="doctor-appointments.jsp"><i class="fas fa-calendar-check"></i> Appointments</a></li>
                    <li><a href="doctor-patients.jsp"><i class="fas fa-users"></i> My Patients</a></li>
                    <li><a href="doctor-medical-records.jsp"><i class="fas fa-file-medical"></i> Medical Records</a></li>
                </ul>
                
                <div class="menu-category">Personal</div>
                <ul>
                    <li><a href="doctor-schedule.jsp"><i class="fas fa-clock"></i> My Schedule</a></li>
                    <li><a href="doctor-profile.jsp"><i class="fas fa-user-circle"></i> My Profile</a></li>
                    <li><a href="doctor-messages.jsp"><i class="fas fa-envelope"></i> Messages</a></li>
                </ul>
                <% } else if (userRole.equals("PATIENT")) { %>
                <!-- Patient Menu -->
                <div class="menu-category">Medical</div>
                <ul>
                    <li><a href="dashboard-patient.jsp" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="patient-appointments.jsp"><i class="fas fa-calendar-check"></i> My Appointments</a></li>
                    <li><a href="patient-medical-records.jsp"><i class="fas fa-file-medical"></i> Medical Records</a></li>
                    <li><a href="patient-prescriptions.jsp"><i class="fas fa-prescription"></i> Prescriptions</a></li>
                </ul>
                
                <div class="menu-category">Personal</div>
                <ul>
                    <li><a href="patient-profile.jsp"><i class="fas fa-user-circle"></i> My Profile</a></li>
                    <li><a href="patient-messages.jsp"><i class="fas fa-envelope"></i> Messages</a></li>
                    <li><a href="patient-billing.jsp"><i class="fas fa-file-invoice-dollar"></i> Billing</a></li>
                </ul>
                <% } %>
                
                <div class="menu-category">Account</div>
                <ul>
                    <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
            </div>
        </aside>
        
        <!-- Main Content -->
        <div class="main-content">
            <section class="dashboard">
                <!-- Success/Error Messages -->
                <% 
                    String successMessage = (String) request.getAttribute("successMessage");
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    
                    if (successMessage != null && !successMessage.isEmpty()) {
                %>
                    <div class="message success-message">
                        <%= successMessage %>
                    </div>
                <% } 
                    if (errorMessage != null && !errorMessage.isEmpty()) {
                %>
                    <div class="message error-message">
                        <%= errorMessage %>
                    </div>
                <% } %>
