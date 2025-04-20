<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, util.DatabaseConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Initialize Database</title>
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
    <h1>Database Initialization</h1>
    
    <%
    try (Connection conn = DatabaseConnection.getConnection()) {
        Statement stmt = conn.createStatement();
        
        // Check if tables exist and have data
        boolean adminHasData = false;
        boolean doctorHasData = false;
        
        try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM admin")) {
            if (rs.next()) {
                adminHasData = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            out.println("<p class='error'>Error checking admin table: " + e.getMessage() + "</p>");
        }
        
        try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM doctor")) {
            if (rs.next()) {
                doctorHasData = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            out.println("<p class='error'>Error checking doctor table: " + e.getMessage() + "</p>");
        }
        
        // Insert sample admin if none exists
        if (!adminHasData) {
            try {
                String insertAdmin = "INSERT INTO admin (Name, Email, Password, Phone) VALUES " +
                                    "('Admin User', 'admin@example.com', 'password', '123-456-7890')";
                int adminRows = stmt.executeUpdate(insertAdmin);
                out.println("<p class='success'>Added " + adminRows + " admin user(s)</p>");
            } catch (SQLException e) {
                out.println("<p class='error'>Error adding admin: " + e.getMessage() + "</p>");
            }
        } else {
            out.println("<p>Admin data already exists</p>");
        }
        
        // Insert sample doctors if none exist
        if (!doctorHasData) {
            try {
                String insertDoctors = "INSERT INTO doctor (Name, Specialization, Email, Phone, Password) VALUES " +
                                      "('Dr. John Smith', 'Cardiologist', 'john.smith@example.com', '123-456-7890', 'password'), " +
                                      "('Dr. Sarah Johnson', 'Neurologist', 'sarah.johnson@example.com', '123-456-7891', 'password'), " +
                                      "('Dr. Michael Brown', 'Pediatrician', 'michael.brown@example.com', '123-456-7892', 'password')";
                int doctorRows = stmt.executeUpdate(insertDoctors);
                out.println("<p class='success'>Added " + doctorRows + " doctor(s)</p>");
            } catch (SQLException e) {
                out.println("<p class='error'>Error adding doctors: " + e.getMessage() + "</p>");
            }
        } else {
            out.println("<p>Doctor data already exists</p>");
        }
        
        // Display admin table data
        out.println("<h2>Admin Table Data:</h2>");
        out.println("<table>");
        out.println("<tr><th>AdminID</th><th>Name</th><th>Email</th><th>Password</th><th>Phone</th></tr>");
        
        try (ResultSet rs = stmt.executeQuery("SELECT * FROM admin")) {
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
                out.println("<tr>");
                out.println("<td>" + rs.getInt("AdminID") + "</td>");
                out.println("<td>" + rs.getString("Name") + "</td>");
                out.println("<td>" + rs.getString("Email") + "</td>");
                out.println("<td>" + rs.getString("Password") + "</td>");
                out.println("<td>" + rs.getString("Phone") + "</td>");
                out.println("</tr>");
            }
            
            if (!hasData) {
                out.println("<tr><td colspan='5' style='text-align:center;'>No data found</td></tr>");
            }
        } catch (SQLException e) {
            out.println("<tr><td colspan='5' style='color:red;'>Error retrieving admin data: " + e.getMessage() + "</td></tr>");
        }
        out.println("</table>");
        
        // Display doctor table data
        out.println("<h2>Doctor Table Data:</h2>");
        out.println("<table>");
        out.println("<tr><th>DoctorID</th><th>Name</th><th>Specialization</th><th>Email</th><th>Phone</th><th>Password</th></tr>");
        
        try (ResultSet rs = stmt.executeQuery("SELECT * FROM doctor")) {
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
                out.println("<tr>");
                out.println("<td>" + rs.getInt("DoctorID") + "</td>");
                out.println("<td>" + rs.getString("Name") + "</td>");
                out.println("<td>" + rs.getString("Specialization") + "</td>");
                out.println("<td>" + rs.getString("Email") + "</td>");
                out.println("<td>" + rs.getString("Phone") + "</td>");
                out.println("<td>" + rs.getString("Password") + "</td>");
                out.println("</tr>");
            }
            
            if (!hasData) {
                out.println("<tr><td colspan='6' style='text-align:center;'>No data found</td></tr>");
            }
        } catch (SQLException e) {
            out.println("<tr><td colspan='6' style='color:red;'>Error retrieving doctor data: " + e.getMessage() + "</td></tr>");
        }
        out.println("</table>");
        
        // Display users table data
        out.println("<h2>Users (Patients) Table Data:</h2>");
        out.println("<table>");
        out.println("<tr><th>PatientID</th><th>Full Name</th><th>Username</th><th>Email</th><th>Password</th><th>Gender</th><th>Phone</th></tr>");
        
        try (ResultSet rs = stmt.executeQuery("SELECT * FROM users")) {
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
                out.println("<tr>");
                out.println("<td>" + rs.getInt("PatientID") + "</td>");
                out.println("<td>" + rs.getString("full_name") + "</td>");
                out.println("<td>" + rs.getString("username") + "</td>");
                out.println("<td>" + rs.getString("email") + "</td>");
                out.println("<td>" + rs.getString("password") + "</td>");
                out.println("<td>" + rs.getString("Gender") + "</td>");
                out.println("<td>" + rs.getString("phone") + "</td>");
                out.println("</tr>");
            }
            
            if (!hasData) {
                out.println("<tr><td colspan='7' style='text-align:center;'>No data found</td></tr>");
            }
        } catch (SQLException e) {
            out.println("<tr><td colspan='7' style='color:red;'>Error retrieving user data: " + e.getMessage() + "</td></tr>");
        }
        out.println("</table>");
        
    } catch (Exception e) {
        out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace(new java.io.PrintWriter(out));
    }
    %>
    
    <h2>Login Credentials</h2>
    <p>You can now log in with the following credentials:</p>
    
    <h3>Admin Login</h3>
    <ul>
        <li>Email: admin@example.com</li>
        <li>Password: password</li>
        <li>Role: ADMIN</li>
    </ul>
    
    <h3>Doctor Login</h3>
    <ul>
        <li>Email: john.smith@example.com</li>
        <li>Password: password</li>
        <li>Role: DOCTOR</li>
    </ul>
    
    <h3>Patient Login</h3>
    <ul>
        <li>Username: test</li>
        <li>Password: Password</li>
        <li>Role: PATIENT</li>
    </ul>
    
    <p><a href="login.jsp">Go to Login Page</a></p>
</body>
</html>
