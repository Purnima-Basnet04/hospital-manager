<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    String userRole = (String) session.getAttribute("userRole");
    
    // Redirect to login page if not logged in or not a doctor/admin
    if (username == null || !(userRole.equals("DOCTOR") || userRole.equals("ADMIN"))) {
        // Save the current page as the redirect destination after login
        response.sendRedirect("login.jsp?redirect=schedule-appointment.jsp");
        return;
    }
    
    // Get patient ID from request parameter if available
    String patientId = request.getParameter("patient");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schedule Appointment - LifeCare Medical Center</title>
    
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
            color: white;
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
            margin: 0;
            font-size: 12px;
            opacity: 0.8;
        }
        
        nav {
            background-color: #34495e;
            margin-bottom: 30px;
        }
        
        nav ul {
            display: flex;
            list-style: none;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        nav ul li {
            margin-right: 5px;
        }
        
        nav ul li a {
            display: block;
            color: white;
            text-decoration: none;
            padding: 15px;
            transition: background-color 0.3s;
        }
        
        nav ul li a:hover, nav ul li a.active {
            background-color: #3498db;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px 40px;
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
            max-width: 700px;
            margin: 0 auto;
        }
        
        .appointment-form {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
            max-width: 800px;
            margin: 0 auto;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #2c3e50;
        }
        
        .form-group select,
        .form-group input[type="date"],
        .form-group input[type="time"],
        .form-group input[type="text"],
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        .form-group select:focus,
        .form-group input[type="date"]:focus,
        .form-group input[type="time"]:focus,
        .form-group input[type="text"]:focus,
        .form-group textarea:focus {
            border-color: #3498db;
            outline: none;
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        .form-row {
            display: flex;
            gap: 20px;
        }
        
        .form-row .form-group {
            flex: 1;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 24px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            text-align: center;
            transition: background-color 0.3s;
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
        
        .form-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        
        .patient-search {
            margin-bottom: 20px;
        }
        
        .patient-search input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        .patient-search input:focus {
            border-color: #3498db;
            outline: none;
        }
        
        .patient-results {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 5px;
            max-height: 200px;
            overflow-y: auto;
            display: none;
        }
        
        .patient-item {
            padding: 10px 15px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .patient-item:hover {
            background-color: #f5f7fa;
        }
        
        .patient-item:last-child {
            border-bottom: none;
        }
        
        footer {
            background-color: #2c3e50;
            color: white;
            padding: 40px 0 20px;
        }
        
        .footer-content {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .footer-section {
            flex: 1;
            min-width: 250px;
            margin-bottom: 20px;
        }
        
        .footer-section h3 {
            font-size: 18px;
            margin-bottom: 15px;
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
        
        .footer-bottom {
            text-align: center;
            padding-top: 20px;
            margin-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            opacity: 0.8;
        }
        
        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 0;
            }
            
            .header-content {
                flex-direction: column;
                text-align: center;
            }
            
            .logo-container {
                margin-bottom: 10px;
            }
            
            nav ul {
                flex-wrap: wrap;
            }
            
            nav ul li {
                margin-right: 0;
                flex: 1 0 33.33%;
                text-align: center;
            }
            
            .form-actions {
                flex-direction: column;
                gap: 10px;
            }
            
            .btn {
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
            <div class="user-info">
                <div class="user-avatar">
                    <%= username.substring(0, 1).toUpperCase() %>
                </div>
                <div class="user-details">
                    <h4><%= session.getAttribute("fullName") != null ? session.getAttribute("fullName") : username %></h4>
                    <p><%= userRole %></p>
                </div>
            </div>
        </div>
    </header>

    <nav>
        <ul>
            <li><a href="home.jsp">Home</a></li>
            <li><a href="appointments.jsp" class="active">Appointments</a></li>
            <li><a href="departments.jsp">Departments</a></li>
            <li><a href="services.jsp">Services</a></li>
            <% if (userRole.equals("DOCTOR")) { %>
            <li><a href="dashboard-doctor.jsp">Dashboard</a></li>
            <% } else if (userRole.equals("ADMIN")) { %>
            <li><a href="admin-dashboard.jsp">Dashboard</a></li>
            <% } %>
            <li><a href="profile.jsp">Profile</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="page-title">
            <h2>Schedule an Appointment</h2>
            <p>Schedule appointments for patients with our healthcare professionals.</p>
        </div>

        <form class="appointment-form" action="AppointmentServlet" method="post">
            <input type="hidden" name="action" value="schedule">
            
            <div class="form-group">
                <label for="patientSearch">Patient</label>
                <div class="patient-search">
                    <input type="text" id="patientSearch" placeholder="Search for patient by name or ID" autocomplete="off" onkeyup="searchPatients()">
                    <div id="patientResults" class="patient-results"></div>
                </div>
                <input type="hidden" id="patientId" name="patientId" required value="<%= patientId != null ? patientId : "" %>">
                <div id="selectedPatient"></div>
            </div>
            
            <div class="form-group">
                <label for="department">Department</label>
                <select id="department" name="departmentId" required onchange="loadDoctors()">
                    <option value="">Select Department</option>
                    <option value="1">Cardiology</option>
                    <option value="2">Neurology</option>
                    <option value="3">Orthopedics</option>
                    <option value="4">Pediatrics</option>
                    <option value="5">Dermatology</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="doctor">Doctor</label>
                <select id="doctor" name="doctorId" required>
                    <option value="">Select Doctor</option>
                    <!-- Options will be populated based on department selection -->
                </select>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="appointmentDate">Date</label>
                    <input type="date" id="appointmentDate" name="appointmentDate" required min="<%= java.time.LocalDate.now() %>" onchange="loadAvailableSlots()">
                </div>
                
                <div class="form-group">
                    <label for="appointmentTime">Time</label>
                    <select id="appointmentTime" name="appointmentTime" required>
                        <option value="">Select Time</option>
                        <!-- Options will be populated based on date and doctor selection -->
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <label for="appointmentType">Appointment Type</label>
                <select id="appointmentType" name="appointmentType" required>
                    <option value="">Select Type</option>
                    <option value="CONSULTATION">Consultation</option>
                    <option value="FOLLOW_UP">Follow-up</option>
                    <option value="PROCEDURE">Procedure</option>
                    <option value="CHECKUP">Regular Check-up</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="notes">Notes</label>
                <textarea id="notes" name="notes" placeholder="Add any notes or special instructions for this appointment"></textarea>
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn">Schedule Appointment</button>
                <a href="appointments.jsp" class="btn secondary">Cancel</a>
            </div>
        </form>
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
        // Function to search for patients
        function searchPatients() {
            const searchTerm = document.getElementById('patientSearch').value.trim();
            const resultsContainer = document.getElementById('patientResults');
            
            if (searchTerm.length < 2) {
                resultsContainer.style.display = 'none';
                return;
            }
            
            // In a real application, this would fetch patients from the server
            // For demonstration, we'll add some sample data
            const patients = [
                { id: 1, name: 'John Doe', email: 'john.doe@example.com' },
                { id: 2, name: 'Jane Smith', email: 'jane.smith@example.com' },
                { id: 3, name: 'Robert Johnson', email: 'robert.johnson@example.com' },
                { id: 4, name: 'Emily Davis', email: 'emily.davis@example.com' },
                { id: 5, name: 'Michael Wilson', email: 'michael.wilson@example.com' }
            ];
            
            // Filter patients based on search term
            const filteredPatients = patients.filter(patient => 
                patient.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                patient.id.toString().includes(searchTerm)
            );
            
            // Display results
            resultsContainer.innerHTML = '';
            
            if (filteredPatients.length === 0) {
                resultsContainer.innerHTML = '<div class="patient-item">No patients found</div>';
            } else {
                filteredPatients.forEach(patient => {
                    const patientItem = document.createElement('div');
                    patientItem.className = 'patient-item';
                    patientItem.textContent = `${patient.name} (ID: ${patient.id})`;
                    patientItem.onclick = function() {
                        selectPatient(patient);
                    };
                    resultsContainer.appendChild(patientItem);
                });
            }
            
            resultsContainer.style.display = 'block';
        }
        
        // Function to select a patient
        function selectPatient(patient) {
            document.getElementById('patientId').value = patient.id;
            document.getElementById('patientSearch').value = patient.name;
            document.getElementById('patientResults').style.display = 'none';
            
            const selectedPatientDiv = document.getElementById('selectedPatient');
            selectedPatientDiv.innerHTML = `
                <div style="margin-top: 10px; padding: 10px; background-color: #f5f7fa; border-radius: 5px;">
                    <strong>Selected Patient:</strong> ${patient.name} (ID: ${patient.id})<br>
                    <strong>Email:</strong> ${patient.email}
                </div>
            `;
        }
        
        // Function to load doctors based on department selection
        function loadDoctors() {
            const departmentId = document.getElementById('department').value;
            const doctorSelect = document.getElementById('doctor');
            
            // Clear existing options
            doctorSelect.innerHTML = '<option value="">Select Doctor</option>';
            
            if (!departmentId) return;
            
            // In a real application, this would fetch doctors from the server
            // For demonstration, we'll add some sample data
            const doctors = {
                '1': [
                    { id: 1, name: 'Dr. Sarah Johnson' },
                    { id: 2, name: 'Dr. Robert Chen' }
                ],
                '2': [
                    { id: 3, name: 'Dr. Michael Brown' },
                    { id: 4, name: 'Dr. Emily Davis' }
                ],
                '3': [
                    { id: 5, name: 'Dr. James Wilson' },
                    { id: 6, name: 'Dr. Lisa Martinez' }
                ],
                '4': [
                    { id: 7, name: 'Dr. David Thompson' },
                    { id: 8, name: 'Dr. Jennifer Lee' }
                ],
                '5': [
                    { id: 9, name: 'Dr. Richard Taylor' },
                    { id: 10, name: 'Dr. Amanda White' }
                ]
            };
            
            // Add options for the selected department
            if (doctors[departmentId]) {
                doctors[departmentId].forEach(doctor => {
                    const option = document.createElement('option');
                    option.value = doctor.id;
                    option.textContent = doctor.name;
                    doctorSelect.appendChild(option);
                });
            }
            
            // Trigger loading of available slots if date is already selected
            if (document.getElementById('appointmentDate').value) {
                loadAvailableSlots();
            }
        }
        
        // Function to load available time slots
        function loadAvailableSlots() {
            const doctorId = document.getElementById('doctor').value;
            const appointmentDate = document.getElementById('appointmentDate').value;
            const timeSelect = document.getElementById('appointmentTime');
            
            // Clear existing options
            timeSelect.innerHTML = '<option value="">Select Time</option>';
            
            if (!doctorId || !appointmentDate) return;
            
            // In a real application, this would fetch available slots from the server
            // For demonstration, we'll add some sample time slots
            const timeSlots = [
                '09:00', '09:30', '10:00', '10:30', '11:00', '11:30',
                '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30'
            ];
            
            // Add time slot options
            timeSlots.forEach(slot => {
                const option = document.createElement('option');
                option.value = slot;
                option.textContent = slot;
                timeSelect.appendChild(option);
            });
        }
        
        // Initialize the form
        document.addEventListener('DOMContentLoaded', function() {
            // Check if patient ID is provided in URL
            const patientId = '<%= patientId %>';
            if (patientId) {
                // In a real application, this would fetch patient details from the server
                // For demonstration, we'll use sample data
                const patients = [
                    { id: 1, name: 'John Doe', email: 'john.doe@example.com' },
                    { id: 2, name: 'Jane Smith', email: 'jane.smith@example.com' },
                    { id: 3, name: 'Robert Johnson', email: 'robert.johnson@example.com' },
                    { id: 4, name: 'Emily Davis', email: 'emily.davis@example.com' },
                    { id: 5, name: 'Michael Wilson', email: 'michael.wilson@example.com' }
                ];
                
                const patient = patients.find(p => p.id.toString() === patientId);
                if (patient) {
                    selectPatient(patient);
                }
            }
            
            // Load doctors if department is pre-selected
            if (document.getElementById('department').value) {
                loadDoctors();
            }
        });
    </script>
</body>
</html>
