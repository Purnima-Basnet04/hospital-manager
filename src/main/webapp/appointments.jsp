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
    <title>Appointments - LifeCare Medical Center</title>

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

        .appointments-section {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-bottom: 30px;
        }

        .appointments-section h3 {
            color: #2c3e50;
            margin-top: 0;
            margin-bottom: 20px;
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

        .data-table tr:hover {
            background-color: #f5f7fa;
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
            background-color: #2980b9;
        }

        .btn-small.cancel {
            background-color: #e74c3c;
        }

        .btn-small.cancel:hover {
            background-color: #c0392b;
        }

        .appointment-filters {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 20px;
        }

        .filter-group {
            display: flex;
            align-items: center;
        }

        .filter-group label {
            margin-right: 10px;
            font-weight: 500;
        }

        .filter-group select,
        .filter-group input {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-family: inherit;
            font-size: 14px;
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination a {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
            color: #3498db;
            transition: all 0.3s;
        }

        .pagination a:hover,
        .pagination a.active {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
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

            .appointment-filters {
                flex-direction: column;
                align-items: flex-start;
            }

            .filter-group {
                width: 100%;
            }

            .filter-group select,
            .filter-group input {
                width: 100%;
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
            <li><a href="${pageContext.request.contextPath}/appointments.jsp" class="active">Appointments</a></li>
            <li><a href="${pageContext.request.contextPath}/departments.jsp">Departments</a></li>
            <li><a href="${pageContext.request.contextPath}/services.jsp">Services</a></li>
            <li><a href="${pageContext.request.contextPath}/login.jsp">Login</a></li>
            <li><a href="${pageContext.request.contextPath}/register.jsp">Register</a></li>
            <% } else { %>
            <li><a href="${pageContext.request.contextPath}/home.jsp">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/appointments.jsp" class="active">Appointments</a></li>
            <li><a href="${pageContext.request.contextPath}/departments.jsp">Departments</a></li>
            <li><a href="${pageContext.request.contextPath}/services.jsp">Services</a></li>
            <% if (userRole.equals("ADMIN")) { %>
            <li><a href="${pageContext.request.contextPath}/admin-dashboard.jsp">Admin Dashboard</a></li>
            <% } else if (userRole.equals("DOCTOR")) { %>
            <li><a href="${pageContext.request.contextPath}/doctor-dashboard.jsp">Doctor Dashboard</a></li>
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
            <h2>Appointments</h2>
            <p>Manage your medical appointments with our healthcare professionals.</p>
        </div>

        <div class="action-buttons">
            <% if (userRole.equals("PATIENT")) { %>
            <a href="${pageContext.request.contextPath}/book-appointment.jsp" class="btn">Book New Appointment</a>
            <% } else if (userRole.equals("DOCTOR") || userRole.equals("ADMIN")) { %>
            <a href="${pageContext.request.contextPath}/schedule-appointment.jsp" class="btn">Schedule Appointment</a>
            <% } else if (userRole.equals("GUEST")) { %>
            <a href="${pageContext.request.contextPath}/login.jsp?redirect=book-appointment.jsp" class="btn">Login to Book Appointment</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/appointment-calendar.jsp" class="btn secondary">View Calendar</a>
        </div>

        <div class="appointments-section">
            <h3>
                <% if (userRole.equals("PATIENT")) { %>
                My Appointments
                <% } else if (userRole.equals("DOCTOR")) { %>
                My Patient Appointments
                <% } else if (userRole.equals("GUEST")) { %>
                Available Appointments
                <% } else { %>
                All Appointments
                <% } %>
            </h3>

            <div class="appointment-filters">
                <div class="filter-group">
                    <label for="status-filter">Status:</label>
                    <select id="status-filter">
                        <option value="all">All</option>
                        <option value="scheduled">Scheduled</option>
                        <option value="completed">Completed</option>
                        <option value="cancelled">Cancelled</option>
                        <option value="no-show">No-Show</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label for="date-filter">Date:</label>
                    <input type="date" id="date-filter">
                </div>

                <% if (userRole.equals("ADMIN") || userRole.equals("DOCTOR")) { %>
                <div class="filter-group">
                    <label for="patient-filter">Patient:</label>
                    <input type="text" id="patient-filter" placeholder="Patient name">
                </div>
                <% } %>

                <% if (userRole.equals("ADMIN") || userRole.equals("PATIENT")) { %>
                <div class="filter-group">
                    <label for="doctor-filter">Doctor:</label>
                    <input type="text" id="doctor-filter" placeholder="Doctor name">
                </div>
                <% } %>

                <div class="filter-group">
                    <button class="btn" onclick="applyFilters()">Apply Filters</button>
                    <button class="btn secondary" onclick="resetFilters()">Reset</button>
                </div>
            </div>

            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <% if (userRole.equals("ADMIN") || userRole.equals("DOCTOR")) { %>
                        <th>Patient</th>
                        <% } %>
                        <% if (userRole.equals("ADMIN") || userRole.equals("PATIENT")) { %>
                        <th>Doctor</th>
                        <% } %>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Department</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Sample data - in a real application, this would be populated from the database -->
                    <tr>
                        <td>1</td>
                        <% if (userRole.equals("ADMIN") || userRole.equals("DOCTOR")) { %>
                        <td>John Doe</td>
                        <% } %>
                        <% if (userRole.equals("ADMIN") || userRole.equals("PATIENT")) { %>
                        <td>Dr. Sarah Johnson</td>
                        <% } %>
                        <td>2023-06-15</td>
                        <td>10:00 AM</td>
                        <td>Cardiology</td>
                        <td>Scheduled</td>
                        <td>
                            <% if (userRole.equals("GUEST")) { %>
                            <a href="${pageContext.request.contextPath}/login.jsp?redirect=view-appointment.jsp?id=1" class="btn-small">Login to View</a>
                            <% } else { %>
                            <a href="${pageContext.request.contextPath}/view-appointment.jsp?id=1" class="btn-small">View</a>
                            <% if (userRole.equals("PATIENT")) { %>
                            <a href="${pageContext.request.contextPath}${pageContext.request.contextPath}/reschedule-appointment.jsp?id=1" class="btn-small">Reschedule</a>
                            <a href="cancel-appointment.jsp?id=1" class="btn-small cancel">Cancel</a>
                            <% } else if (userRole.equals("DOCTOR")) { %>
                            <a href="${pageContext.request.contextPath}/update-appointment.jsp?id=1" class="btn-small">Update</a>
                            <% } else if (userRole.equals("ADMIN")) { %>
                            <a href="${pageContext.request.contextPath}/edit-appointment.jsp?id=1" class="btn-small">Edit</a>
                            <a href="${pageContext.request.contextPath}/delete-appointment.jsp?id=1" class="btn-small cancel">Delete</a>
                            <% } %>
                            <% } %>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <% if (userRole.equals("ADMIN") || userRole.equals("DOCTOR")) { %>
                        <td>Jane Smith</td>
                        <% } %>
                        <% if (userRole.equals("ADMIN") || userRole.equals("PATIENT")) { %>
                        <td>Dr. Michael Brown</td>
                        <% } %>
                        <td>2023-06-20</td>
                        <td>2:30 PM</td>
                        <td>Neurology</td>
                        <td>Scheduled</td>
                        <td>
                            <% if (userRole.equals("GUEST")) { %>
                            <a href="login.jsp?redirect=view-appointment.jsp?id=2" class="btn-small">Login to View</a>
                            <% } else { %>
                            <a href="view-appointment.jsp?id=2" class="btn-small">View</a>
                            <% if (userRole.equals("PATIENT")) { %>
                            <a href="reschedule-appointment.jsp?id=2" class="btn-small">Reschedule</a>
                            <a href="cancel-appointment.jsp?id=2" class="btn-small cancel">Cancel</a>
                            <% } else if (userRole.equals("DOCTOR")) { %>
                            <a href="update-appointment.jsp?id=2" class="btn-small">Update</a>
                            <% } else if (userRole.equals("ADMIN")) { %>
                            <a href="edit-appointment.jsp?id=2" class="btn-small">Edit</a>
                            <a href="delete-appointment.jsp?id=2" class="btn-small cancel">Delete</a>
                            <% } %>
                            <% } %>
                        </td>
                    </tr>
                </tbody>
            </table>

            <div class="pagination">
                <a href="#" class="active">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">Next</a>
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

    <script>
        function applyFilters() {
            // In a real application, this would filter the appointments based on the selected criteria
            alert('Filters applied!');
        }

        function resetFilters() {
            // Reset all filter fields
            document.getElementById('status-filter').value = 'all';
            document.getElementById('date-filter').value = '';

            if (document.getElementById('patient-filter')) {
                document.getElementById('patient-filter').value = '';
            }

            if (document.getElementById('doctor-filter')) {
                document.getElementById('doctor-filter').value = '';
            }

            // In a real application, this would reset the appointments list
            alert('Filters reset!');
        }
    </script>
</body>
</html>
