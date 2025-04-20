<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.*, model.*, dao.*, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            line-height: 1.6;
        }
        .success {
            color: green;
            font-weight: bold;
        }
        .error {
            color: red;
            font-weight: bold;
        }
        pre {
            background-color: #f5f5f5;
            padding: 10px;
            border-radius: 5px;
            overflow-x: auto;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
    <h1>Test Registration</h1>
    
    <%
    // Create controllers
    UserController userController = new UserController();
    DoctorController doctorController = new DoctorController();
    AdminController adminController = new AdminController();
    
    // Test patient registration
    String patientUsername = "testpatient" + System.currentTimeMillis();
    String patientEmail = "testpatient" + System.currentTimeMillis() + "@example.com";
    
    User patient = new User();
    patient.setUsername(patientUsername);
    patient.setPassword("password");
    patient.setFullName("Test Patient");
    patient.setEmail(patientEmail);
    patient.setPhone("123-456-7890");
    patient.setAddress("123 Test St");
    patient.setGender("Male");
    patient.setBloodGroup("A+");
    patient.setRole("PATIENT");
    
    boolean patientSuccess = userController.registerUser(
        patientUsername, "password", "Test Patient", 
        patientEmail, "123-456-7890", "123 Test St", "PATIENT"
    );
    
    // Test doctor registration
    String doctorEmail = "testdoctor" + System.currentTimeMillis() + "@example.com";
    
    Doctor doctor = new Doctor();
    doctor.setName("Test Doctor");
    doctor.setSpecialization("Cardiologist");
    doctor.setEmail(doctorEmail);
    doctor.setPassword("password");
    doctor.setPhone("123-456-7890");
    
    boolean doctorSuccess = doctorController.addDoctor(doctor);
    
    // Test admin registration
    String adminEmail = "testadmin" + System.currentTimeMillis() + "@example.com";
    
    Admin admin = new Admin();
    admin.setName("Test Admin");
    admin.setEmail(adminEmail);
    admin.setPassword("password");
    admin.setPhone("123-456-7890");
    
    boolean adminSuccess = adminController.addAdmin(admin);
    %>
    
    <h2>Registration Results:</h2>
    <p>Patient Registration: <span class="<%= patientSuccess ? "success" : "error" %>"><%= patientSuccess ? "Success" : "Failed" %></span></p>
    <p>Doctor Registration: <span class="<%= doctorSuccess ? "success" : "error" %>"><%= doctorSuccess ? "Success" : "Failed" %></span></p>
    <p>Admin Registration: <span class="<%= adminSuccess ? "success" : "error" %>"><%= adminSuccess ? "Success" : "Failed" %></span></p>
    
    <h2>Registered Users:</h2>
    
    <h3>Patients:</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Role</th>
        </tr>
        <%
        List<User> patients = userController.getUsersByRole("PATIENT");
        for (User u : patients) {
        %>
        <tr>
            <td><%= u.getPatientID() %></td>
            <td><%= u.getUsername() %></td>
            <td><%= u.getFullName() %></td>
            <td><%= u.getEmail() %></td>
            <td><%= u.getRole() %></td>
        </tr>
        <% } %>
    </table>
    
    <h3>Doctors:</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Specialization</th>
            <th>Email</th>
        </tr>
        <%
        List<Doctor> doctors = doctorController.getAllDoctors();
        for (Doctor d : doctors) {
        %>
        <tr>
            <td><%= d.getDoctorID() %></td>
            <td><%= d.getName() %></td>
            <td><%= d.getSpecialization() %></td>
            <td><%= d.getEmail() %></td>
        </tr>
        <% } %>
    </table>
    
    <h3>Admins:</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
        </tr>
        <%
        List<Admin> admins = adminController.getAllAdmins();
        for (Admin a : admins) {
        %>
        <tr>
            <td><%= a.getAdminID() %></td>
            <td><%= a.getName() %></td>
            <td><%= a.getEmail() %></td>
        </tr>
        <% } %>
    </table>
    
    <h2>Test Authentication:</h2>
    <%
    // Test patient authentication
    Object patientAuth = userController.authenticateUser(patientEmail, "password", "PATIENT");
    
    // Test doctor authentication
    Object doctorAuth = userController.authenticateUser(doctorEmail, "password", "DOCTOR");
    
    // Test admin authentication
    Object adminAuth = userController.authenticateUser(adminEmail, "password", "ADMIN");
    %>
    
    <p>Patient Authentication: <span class="<%= patientAuth != null ? "success" : "error" %>"><%= patientAuth != null ? "Success" : "Failed" %></span></p>
    <p>Doctor Authentication: <span class="<%= doctorAuth != null ? "success" : "error" %>"><%= doctorAuth != null ? "Success" : "Failed" %></span></p>
    <p>Admin Authentication: <span class="<%= adminAuth != null ? "success" : "error" %>"><%= adminAuth != null ? "Success" : "Failed" %></span></p>
    
    <p><a href="login.jsp">Go to Login Page</a></p>
</body>
</html>
