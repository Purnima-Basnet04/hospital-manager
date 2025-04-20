<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    String userRole = (String) session.getAttribute("userRole");

    if (username == null || userRole == null || !userRole.equals("PATIENT")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard - LifeCare Medical Center</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <!-- Common CSS -->
    <link rel="stylesheet" type="text/css" href="styles/common.css">
    
    <!-- Dashboard CSS -->
    <link rel="stylesheet" type="text/css" href="styles/dashboard-patient.css">
    
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
                        <%= username.substring(0, 1) %>
                    </div>
                    <div class="user-details">
                        <h4><%= username %></h4>
                        <p><%= userRole %></p>
                    </div>
                </div>
            </div>
            
            <div class="sidebar-menu">
                <!-- Patient Menu -->
                <div class="menu-category">Medical</div>
                <ul>
                    <li><a href="dashboard-patient-simple.jsp" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
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
                
                <div class="menu-category">Account</div>
                <ul>
                    <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
            </div>
        </aside>
        
        <!-- Main Content -->
        <div class="main-content">
            <section class="dashboard">
                <h2>Patient Dashboard</h2>
                <p>Welcome, <%= username %>!</p>
                
                <div class="dashboard-stats">
                    <div class="stat-card">
                        <h3>Upcoming Appointments</h3>
                        <p class="stat-number">2</p>
                    </div>
                    <div class="stat-card">
                        <h3>Prescriptions</h3>
                        <p class="stat-number">3</p>
                    </div>
                    <div class="stat-card">
                        <h3>Medical Records</h3>
                        <p class="stat-number">5</p>
                    </div>
                    <div class="stat-card">
                        <h3>Messages</h3>
                        <p class="stat-number">1</p>
                    </div>
                </div>
                
                <div class="dashboard-actions">
                    <h3>Quick Actions</h3>
                    <div class="action-buttons">
                        <a href="patient-book-appointment.jsp" class="btn primary">Book Appointment</a>
                        <a href="patient-medical-records.jsp" class="btn primary">View Medical Records</a>
                        <a href="patient-prescriptions.jsp" class="btn primary">View Prescriptions</a>
                        <a href="patient-messages.jsp" class="btn secondary">Check Messages</a>
                    </div>
                </div>
                
                <div class="recent-section">
                    <h3>Upcoming Appointments</h3>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Doctor</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Department</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Dr. John Smith</td>
                                <td>2023-06-15</td>
                                <td>10:00 AM</td>
                                <td>Cardiology</td>
                                <td>
                                    <a href="patient-view-appointment.jsp?id=1" class="btn-small">View</a>
                                    <a href="patient-reschedule-appointment.jsp?id=1" class="btn-small">Reschedule</a>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Dr. Sarah Johnson</td>
                                <td>2023-06-20</td>
                                <td>2:30 PM</td>
                                <td>Neurology</td>
                                <td>
                                    <a href="patient-view-appointment.jsp?id=2" class="btn-small">View</a>
                                    <a href="patient-reschedule-appointment.jsp?id=2" class="btn-small">Reschedule</a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div class="recent-section">
                    <h3>Recent Prescriptions</h3>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Doctor</th>
                                <th>Date</th>
                                <th>Medication</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Dr. John Smith</td>
                                <td>2023-06-01</td>
                                <td>Lisinopril 10mg</td>
                                <td>Active</td>
                                <td>
                                    <a href="patient-view-prescription.jsp?id=1" class="btn-small">View</a>
                                    <a href="patient-request-refill.jsp?id=1" class="btn-small">Request Refill</a>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Dr. Sarah Johnson</td>
                                <td>2023-05-15</td>
                                <td>Amoxicillin 500mg</td>
                                <td>Completed</td>
                                <td>
                                    <a href="patient-view-prescription.jsp?id=2" class="btn-small">View</a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
    </div>
    
    <!-- Common JavaScript -->
    <script src="js/common.js"></script>
    
    <!-- Dashboard JavaScript -->
    <script src="js/dashboard-patient.js"></script>
</body>
</html>
