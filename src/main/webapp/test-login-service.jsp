<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.LoginService, model.User, model.Doctor, model.Admin" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Login Service</title>
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
        form {
            margin-bottom: 20px;
        }
        input[type="text"], input[type="password"], input[type="email"], select {
            padding: 8px;
            margin: 5px 0;
            width: 300px;
        }
        input[type="submit"] {
            padding: 8px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Test Login Service</h1>
    
    <form method="post">
        <table>
            <tr>
                <td>Username/Email:</td>
                <td><input type="text" name="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" required></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="password" name="password" value="<%= request.getParameter("password") != null ? request.getParameter("password") : "" %>" required></td>
            </tr>
            <tr>
                <td>Role:</td>
                <td>
                    <select name="role">
                        <option value="">Auto-detect</option>
                        <option value="PATIENT" <%= "PATIENT".equals(request.getParameter("role")) ? "selected" : "" %>>Patient</option>
                        <option value="DOCTOR" <%= "DOCTOR".equals(request.getParameter("role")) ? "selected" : "" %>>Doctor</option>
                        <option value="ADMIN" <%= "ADMIN".equals(request.getParameter("role")) ? "selected" : "" %>>Admin</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Test Login"></td>
            </tr>
        </table>
    </form>
    
    <%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String role = request.getParameter("role");
    
    if (username != null && password != null) {
        LoginService loginService = new LoginService();
        Object userObj = null;
        
        out.println("<h2>Login Test Results:</h2>");
        
        if (role != null && !role.trim().isEmpty()) {
            // If role is specified, authenticate with that role directly
            switch (role) {
                case "PATIENT":
                    userObj = loginService.authenticatePatient(username, password);
                    out.println("<p>Testing login as PATIENT</p>");
                    break;
                case "DOCTOR":
                    userObj = loginService.authenticateDoctor(username, password);
                    out.println("<p>Testing login as DOCTOR</p>");
                    break;
                case "ADMIN":
                    userObj = loginService.authenticateAdmin(username, password);
                    out.println("<p>Testing login as ADMIN</p>");
                    break;
                default:
                    userObj = loginService.authenticateAny(username, password);
                    out.println("<p>Testing login with auto-detect role</p>");
                    break;
            }
        } else {
            // If no role is specified, try all roles
            userObj = loginService.authenticateAny(username, password);
            out.println("<p>Testing login with auto-detect role</p>");
        }
        
        if (userObj != null) {
            out.println("<p class='success'>Login successful!</p>");
            
            if (userObj instanceof User) {
                User user = (User) userObj;
                out.println("<p>Logged in as PATIENT</p>");
                out.println("<p>Patient ID: " + user.getPatientID() + "</p>");
                out.println("<p>Name: " + user.getFullName() + "</p>");
                out.println("<p>Username: " + user.getUsername() + "</p>");
                out.println("<p>Email: " + user.getEmail() + "</p>");
            } else if (userObj instanceof Doctor) {
                Doctor doctor = (Doctor) userObj;
                out.println("<p>Logged in as DOCTOR</p>");
                out.println("<p>Doctor ID: " + doctor.getDoctorID() + "</p>");
                out.println("<p>Name: " + doctor.getName() + "</p>");
                out.println("<p>Email: " + doctor.getEmail() + "</p>");
                out.println("<p>Specialization: " + doctor.getSpecialization() + "</p>");
            } else if (userObj instanceof Admin) {
                Admin admin = (Admin) userObj;
                out.println("<p>Logged in as ADMIN</p>");
                out.println("<p>Admin ID: " + admin.getAdminID() + "</p>");
                out.println("<p>Name: " + admin.getName() + "</p>");
                out.println("<p>Email: " + admin.getEmail() + "</p>");
            }
        } else {
            out.println("<p class='error'>Login failed!</p>");
        }
    }
    %>
    
    <p><a href="initialize-database.jsp">Initialize Database</a> | <a href="login.jsp">Go to Login Page</a></p>
</body>
</html>
